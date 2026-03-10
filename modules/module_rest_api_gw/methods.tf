locals {
  parent_paths = distinct([for k, v in var.api_paths : v.parent_path if v.parent_path != ""])
  child_paths = distinct([
    for k, v in var.api_paths : "${v.parent_path}/${v.child_path}" 
    if v.child_path != ""
  ])
  # Tạo unique grandchild paths để tránh conflict khi nhiều path_keys có cùng parent/child/grandchild path
  # Chỉ áp dụng cho các path_keys có cùng unique path (ví dụ: offline_mode_project_id, offline_mode_project_id_syncjobs, etc.)
  unique_grandchild_paths = distinct([
    for k, v in var.api_paths : "${v.parent_path}/${v.child_path}/${v.grandchild_path}"
    if v.grandchild_path != ""
  ])
  # Map từ unique path sang path_key đầu tiên (để dùng làm key cho resource)
  # Nếu nhiều path_keys có cùng unique path, chỉ dùng path_key đầu tiên
  unique_path_to_first_path_key = {
    for unique_path in local.unique_grandchild_paths :
    unique_path => [
      for k, v in var.api_paths :
      k if v.grandchild_path != "" && "${v.parent_path}/${v.child_path}/${v.grandchild_path}" == unique_path
    ][0]
  }
  # Map từ path_key sang grandchild resource key (path_key hoặc unique path key nếu có conflict)
  # Chỉ tạo cho các paths có grandchild_path
  path_key_to_grandchild_resource_key = {
    for k, v in var.api_paths :
    k => (
      # Đếm số path_keys có cùng unique path
      length([
        for k2, v2 in var.api_paths :
        k2 if v2.grandchild_path != "" && 
             "${v2.parent_path}/${v2.child_path}/${v2.grandchild_path}" == "${v.parent_path}/${v.child_path}/${v.grandchild_path}"
      ]) > 1 ? try(local.unique_path_to_first_path_key["${v.parent_path}/${v.child_path}/${v.grandchild_path}"], k) : k
    )
    if v.grandchild_path != ""
  }
  # Set các path_keys cần tạo resource (chỉ path_key đầu tiên trong mỗi group)
  grandchild_resource_keys = {
    for k, v in local.path_key_to_grandchild_resource_key :
    k => true
    if v == k
  }
}

resource "aws_api_gateway_resource" "parent" {
  for_each    = { for path in local.parent_paths : path => path }
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = each.value
}

resource "aws_api_gateway_resource" "child" {
  for_each = {
    for path in local.child_paths : 
    path => {
      parent_path = split("/", path)[0]
      child_path  = split("/", path)[1]
    }
  }
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.parent[each.value.parent_path].id
  path_part   = each.value.child_path
}

resource "aws_api_gateway_resource" "grandchild" {
  # Tạo resource dựa trên path_key (như code cũ)
  # Nhưng nếu nhiều path_keys có cùng unique path, chỉ tạo 1 resource cho path_key đầu tiên
  for_each = {
    for k, v in var.api_paths :
    k => v
    if v.grandchild_path != "" && try(local.grandchild_resource_keys[k], false)
  }
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.child["${each.value.parent_path}/${each.value.child_path}"].id
  path_part   = each.value.grandchild_path
}

resource "aws_api_gateway_resource" "great_grandchild" {
  # Chỉ tạo great_grandchild khi có cả great_grandchild_path VÀ grandchild_path (vì great_grandchild là child của grandchild)
  for_each    = { 
    for k, v in var.api_paths : 
    k => v 
    if try(v.great_grandchild_path, "") != "" && v.grandchild_path != ""
  }
  rest_api_id = aws_api_gateway_rest_api.api.id
  # Reference grandchild resource bằng path_key (có thể là path_key gốc hoặc path_key đầu tiên nếu có conflict)
  # Vì đã filter để chỉ có paths có grandchild_path, nên path_key_to_grandchild_resource_key[each.key] sẽ luôn tồn tại
  parent_id   = aws_api_gateway_resource.grandchild[local.path_key_to_grandchild_resource_key[each.key]].id
  path_part   = each.value.great_grandchild_path
}

resource "aws_api_gateway_method" "method" {
  for_each = {
    for item in flatten([
      for path_key, path in var.api_paths : [
        for method in path.http_methods : {
          key        = "${path_key}_${method.method}"
          path_key   = path_key
          method     = method.method
          lambda_key = method.lambda_key
          enable_auth = try(method.enable_auth, true)  # Default: true nếu không có
        } if method.method != "OPTIONS"
      ]
    ]) : item.key => item
  }
  rest_api_id = aws_api_gateway_rest_api.api.id
  # CODE CU (chi 3 cap):
  # resource_id = var.api_paths[each.value.path_key].grandchild_path != "" ? aws_api_gateway_resource.grandchild[each.value.path_key].id : (
  #                 var.api_paths[each.value.path_key].child_path != "" ? aws_api_gateway_resource.child["${var.api_paths[each.value.path_key].parent_path}/${var.api_paths[each.value.path_key].child_path}"].id : 
  #                 aws_api_gateway_resource.parent[var.api_paths[each.value.path_key].parent_path].id
  #               )
  # CODE MOI (4 cap - support great_grandchild_path):
  # resource_id = var.api_paths[each.value.path_key].great_grandchild_path != "" ? aws_api_gateway_resource.great_grandchild[each.value.path_key].id : (
  #                 var.api_paths[each.value.path_key].grandchild_path != "" ? aws_api_gateway_resource.grandchild[each.value.path_key].id : (
  #                 var.api_paths[each.value.path_key].child_path != "" ? aws_api_gateway_resource.child["${var.api_paths[each.value.path_key].parent_path}/${var.api_paths[each.value.path_key].child_path}"].id : 
  #                 aws_api_gateway_resource.parent[var.api_paths[each.value.path_key].parent_path].id
  #                 )
  #               )
  # CODE MOI (dung try() de xu ly optional field):
  resource_id = try(var.api_paths[each.value.path_key].great_grandchild_path, "") != "" ? aws_api_gateway_resource.great_grandchild[each.value.path_key].id : (
                    var.api_paths[each.value.path_key].grandchild_path != "" ? aws_api_gateway_resource.grandchild[try(local.path_key_to_grandchild_resource_key[each.value.path_key], each.value.path_key)].id : (
                    var.api_paths[each.value.path_key].child_path != "" ? aws_api_gateway_resource.child["${var.api_paths[each.value.path_key].parent_path}/${var.api_paths[each.value.path_key].child_path}"].id : 
                    aws_api_gateway_resource.parent[var.api_paths[each.value.path_key].parent_path].id
                    )
                  )
  http_method = each.value.method
  # --- Logic authorization: 
  # 1. Nếu enable_cognito_auth = false (module level) -> NONE
  # 2. Nếu method = OPTIONS -> NONE (luôn không cần auth)
  # 3. Nếu enable_auth = false (method level) -> NONE
  # 4. Còn lại -> COGNITO_USER_POOLS
  authorization = var.enable_cognito_auth && each.value.method != "OPTIONS" && each.value.enable_auth ? "COGNITO_USER_POOLS" : "NONE"
  authorizer_id = var.enable_cognito_auth && each.value.method != "OPTIONS" && each.value.enable_auth ? aws_api_gateway_authorizer.cognito.id : null
}


