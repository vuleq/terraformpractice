locals {
  # Default template đơn giản
  mapping_templates = {
    "default" = <<EOF
#set($allParams = $input.params())
{
"body-json" : $input.json('$'),
"params" : {
#foreach($type in $allParams.keySet())
    #set($params = $allParams.get($type))
"$type" : {
    #foreach($paramName in $params.keySet())
    "$paramName" : "$util.escapeJavaScript($params.get($paramName))"
        #if($foreach.hasNext),#end
    #end
}
    #if($foreach.hasNext),#end
#end
},
"stage-variables" : {
#foreach($key in $stageVariables.keySet())
"$key" : "$util.escapeJavaScript($stageVariables.get($key))"
    #if($foreach.hasNext),#end
#end
},
"context" : {
    "account-id" : "$context.identity.accountId",
    "api-id" : "$context.apiId",
    "api-key" : "$context.identity.apiKey",
    "authorizer-principal-id" : "$context.authorizer.principalId",
    "caller" : "$context.identity.caller",
    "cognito-authentication-provider" : "$context.identity.cognitoAuthenticationProvider",
    "cognito-authentication-type" : "$context.identity.cognitoAuthenticationType",
    "cognito-identity-id" : "$context.identity.cognitoIdentityId",
    "cognito-identity-pool-id" : "$context.identity.cognitoIdentityPoolId",
    "http-method" : "$context.httpMethod",
    "stage" : "$context.stage",
    "source-ip" : "$context.identity.sourceIp",
    "user" : "$context.identity.user",
    "user-agent" : "$context.identity.userAgent",
    "user-arn" : "$context.identity.userArn",
    "request-id" : "$context.requestId",
    "resource-id" : "$context.resourceId",
    "resource-path" : "$context.resourcePath"
    }
}
EOF
  }
}

# Định nghĩa method OPTIONS để hỗ trợ CORS
resource "aws_api_gateway_method" "options_method" {
  for_each = {
    for item in flatten([
      for path_key, path in var.api_paths : [
        for method in path.http_methods : {
          key        = "${path_key}_${method.method}"
          path_key   = path_key
          method     = method.method
          lambda_key = method.lambda_key
        } if method.method == "OPTIONS"
      ]
    ]) : item.key => item
  }
  rest_api_id   = aws_api_gateway_rest_api.api.id
  # CODE CU (chi 3 cap):
  # resource_id   = var.api_paths[each.value.path_key].grandchild_path != "" ? aws_api_gateway_resource.grandchild[try(local.path_key_to_grandchild_resource_key[each.value.path_key], each.value.path_key)].id : (
  #                 var.api_paths[each.value.path_key].child_path != "" ? aws_api_gateway_resource.child["${var.api_paths[each.value.path_key].parent_path}/${var.api_paths[each.value.path_key].child_path}"].id : 
  #                 aws_api_gateway_resource.parent[var.api_paths[each.value.path_key].parent_path].id
  #               )
  # CODE MOI (4 cap - support great_grandchild_path):
  # resource_id   = var.api_paths[each.value.path_key].great_grandchild_path != "" ? aws_api_gateway_resource.great_grandchild[each.value.path_key].id : (
  #                 var.api_paths[each.value.path_key].grandchild_path != "" ? aws_api_gateway_resource.grandchild[try(local.path_key_to_grandchild_resource_key[each.value.path_key], each.value.path_key)].id : (
  #                   var.api_paths[each.value.path_key].child_path != "" ? aws_api_gateway_resource.child["${var.api_paths[each.value.path_key].parent_path}/${var.api_paths[each.value.path_key].child_path}"].id : 
  #                   aws_api_gateway_resource.parent[var.api_paths[each.value.path_key].parent_path].id
  #                 )
  #               )
  # CODE MOI (dung try() de xu ly optional field):
  resource_id   = try(var.api_paths[each.value.path_key].great_grandchild_path, "") != "" ? aws_api_gateway_resource.great_grandchild[each.value.path_key].id : (
                    var.api_paths[each.value.path_key].grandchild_path != "" ? aws_api_gateway_resource.grandchild[try(local.path_key_to_grandchild_resource_key[each.value.path_key], each.value.path_key)].id : (
                      var.api_paths[each.value.path_key].child_path != "" ? aws_api_gateway_resource.child["${var.api_paths[each.value.path_key].parent_path}/${var.api_paths[each.value.path_key].child_path}"].id : 
                      aws_api_gateway_resource.parent[var.api_paths[each.value.path_key].parent_path].id
                    )
                  )
  http_method   = each.value.method
  authorization = "NONE"
}

# Định nghĩa integration cho các method (Lambda hoặc MOCK)
resource "aws_api_gateway_integration" "integration" {
  for_each = {
    for item in flatten([
      for path_key, path in var.api_paths : [
        for method in path.http_methods : {
          key        = "${path_key}_${method.method}"
          path_key   = path_key
          method     = method.method
          lambda_key = method.lambda_key
          template_file = method.template_file
        }
      ]
    ]) : item.key => item
  }
  rest_api_id             = aws_api_gateway_rest_api.api.id
  # CODE CU (chi 3 cap):
  # resource_id             = var.api_paths[each.value.path_key].grandchild_path != "" ? aws_api_gateway_resource.grandchild[try(local.path_key_to_grandchild_resource_key[each.value.path_key], each.value.path_key)].id : (
  #                           var.api_paths[each.value.path_key].child_path != "" ? aws_api_gateway_resource.child["${var.api_paths[each.value.path_key].parent_path}/${var.api_paths[each.value.path_key].child_path}"].id : 
  #                           aws_api_gateway_resource.parent[var.api_paths[each.value.path_key].parent_path].id
  #                         )
  # CODE MOI (4 cap - support great_grandchild_path):
  # resource_id             = var.api_paths[each.value.path_key].great_grandchild_path != "" ? aws_api_gateway_resource.great_grandchild[each.value.path_key].id : (
  #                           var.api_paths[each.value.path_key].grandchild_path != "" ? aws_api_gateway_resource.grandchild[try(local.path_key_to_grandchild_resource_key[each.value.path_key], each.value.path_key)].id : (
  #                             var.api_paths[each.value.path_key].child_path != "" ? aws_api_gateway_resource.child["${var.api_paths[each.value.path_key].parent_path}/${var.api_paths[each.value.path_key].child_path}"].id : 
  #                             aws_api_gateway_resource.parent[var.api_paths[each.value.path_key].parent_path].id
  #                           )
  #                         )
  # CODE MOI (dung try() de xu ly optional field):
  resource_id             = try(var.api_paths[each.value.path_key].great_grandchild_path, "") != "" ? aws_api_gateway_resource.great_grandchild[each.value.path_key].id : (
                            var.api_paths[each.value.path_key].grandchild_path != "" ? aws_api_gateway_resource.grandchild[try(local.path_key_to_grandchild_resource_key[each.value.path_key], each.value.path_key)].id : (
                              var.api_paths[each.value.path_key].child_path != "" ? aws_api_gateway_resource.child["${var.api_paths[each.value.path_key].parent_path}/${var.api_paths[each.value.path_key].child_path}"].id : 
                              aws_api_gateway_resource.parent[var.api_paths[each.value.path_key].parent_path].id
                            )
                          )
  http_method             = each.value.method
  # ===== LAMBDA PROXY INTEGRATION (Simplified) =====
  # Force all Lambda integrations to use AWS_PROXY for consistency
  type                    = each.value.lambda_key != "" ? "AWS_PROXY" : "MOCK"
  integration_http_method = each.value.lambda_key != "" ? "POST" : null
  uri                     = each.value.lambda_key != "" ? var.lambda_functions[each.value.lambda_key].invoke_arn : null
  passthrough_behavior    = null
  
  request_templates = each.value.lambda_key != "" ? null : {
    "application/json" = "{\"statusCode\": 200}"
  }
  
  # ===== CUSTOM INTEGRATION (Commented - Uncomment if needed) =====
  # Uncomment the lines below if you need to support both AWS_PROXY and AWS (Custom) integrations
  # This allows using template_file for custom request/response mapping
  #
  # HOW TO SWITCH BACK TO MIXED MODE:
  # 1. Comment out the LAMBDA PROXY INTEGRATION section above (lines 95-104)
  # 2. Uncomment the CUSTOM INTEGRATION section below (lines 110-125)
  # 3. Run: terraform apply -var-file="infra.tfvars"
  #
  # MIXED MODE BEHAVIOR:
  # - If template_file is provided: Uses AWS (Custom) integration
  # - If template_file is null/empty: Uses AWS_PROXY integration
  # - If lambda_key is empty: Uses MOCK integration (for OPTIONS)
  
  # type                    = each.value.lambda_key != "" ? (
  #   each.value.template_file != null && each.value.template_file != "" ? "AWS" : "AWS_PROXY"
  # ) : "MOCK"
  # integration_http_method = each.value.lambda_key != "" ? (
  #   each.value.template_file != null && each.value.template_file != "" ? "POST" : "POST"
  # ) : null
  # passthrough_behavior    = each.value.lambda_key != "" ? (
  #   each.value.template_file != null && each.value.template_file != "" ? "WHEN_NO_MATCH" : null
  # ) : null
  # request_templates = each.value.lambda_key != "" ? (
  #   each.value.template_file != null && each.value.template_file != "" ? {
  #     "application/json" = file("${path.module}/${each.value.template_file}")
  #   } : null  
  # ) : {
  #   "application/json" = "{\"statusCode\": 200}"
  # }
  # # Template đơn giản - chỉ dùng default ---> before update from chatgpt
  # request_templates = each.value.lambda_key != "" ? {
  #   "application/json" = local.mapping_templates["default"]
  # } : {
  #   # Template cho OPTIONS integration (MOCK)
  #   "application/json" = "{\"statusCode\": 200}"
  # }
  
  depends_on = [
    aws_api_gateway_method.method,        # Từ methods.tf cho POST, GET
    aws_api_gateway_method.options_method # Từ integrations.tf cho OPTIONS
  ]
}

# Cấp quyền cho API Gateway gọi Lambda
resource "aws_lambda_permission" "api_gw_lambda" {
  for_each = {
    for item in flatten([
      for path_key, path in var.api_paths : [
        for method in path.http_methods : {
          key        = "${path_key}_${method.method}"
          path_key   = path_key
          lambda_key = method.lambda_key
        } if method.lambda_key != ""
      ]
    ]) : item.key => item
  }
  statement_id  = "AllowAPI-${substr(var.api_name, 0, 20)}-${substr(each.value.path_key, 0, 30)}-${substr(each.value.lambda_key, 0, 20)}"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_functions[each.value.lambda_key].function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}

# Định nghĩa method response cho OPTIONS (CORS)
resource "aws_api_gateway_method_response" "options_response" {
  for_each = {
    for item in flatten([
      for path_key, path in var.api_paths : [
        for method in path.http_methods : {
          key        = "${path_key}_${method.method}"
          path_key   = path_key
          method     = method.method
          lambda_key = method.lambda_key
        } if method.method == "OPTIONS"
      ]
    ]) : item.key => item
  }
  rest_api_id = aws_api_gateway_rest_api.api.id
  # CODE CU (chi 3 cap):
  # resource_id = var.api_paths[each.value.path_key].grandchild_path != "" ? aws_api_gateway_resource.grandchild[try(local.path_key_to_grandchild_resource_key[each.value.path_key], each.value.path_key)].id : (
  #               var.api_paths[each.value.path_key].child_path != "" ? aws_api_gateway_resource.child["${var.api_paths[each.value.path_key].parent_path}/${var.api_paths[each.value.path_key].child_path}"].id : 
  #               aws_api_gateway_resource.parent[var.api_paths[each.value.path_key].parent_path].id
  #             )
  # CODE MOI (4 cap - support great_grandchild_path):
  # resource_id = var.api_paths[each.value.path_key].great_grandchild_path != "" ? aws_api_gateway_resource.great_grandchild[each.value.path_key].id : (
  #               var.api_paths[each.value.path_key].grandchild_path != "" ? aws_api_gateway_resource.grandchild[try(local.path_key_to_grandchild_resource_key[each.value.path_key], each.value.path_key)].id : (
  #                 var.api_paths[each.value.path_key].child_path != "" ? aws_api_gateway_resource.child["${var.api_paths[each.value.path_key].parent_path}/${var.api_paths[each.value.path_key].child_path}"].id : 
  #                 aws_api_gateway_resource.parent[var.api_paths[each.value.path_key].parent_path].id
  #               )
  #             )
  # CODE MOI (dung try() de xu ly optional field):
  resource_id = try(var.api_paths[each.value.path_key].great_grandchild_path, "") != "" ? aws_api_gateway_resource.great_grandchild[each.value.path_key].id : (
                    var.api_paths[each.value.path_key].grandchild_path != "" ? aws_api_gateway_resource.grandchild[try(local.path_key_to_grandchild_resource_key[each.value.path_key], each.value.path_key)].id : (
                      var.api_paths[each.value.path_key].child_path != "" ? aws_api_gateway_resource.child["${var.api_paths[each.value.path_key].parent_path}/${var.api_paths[each.value.path_key].child_path}"].id : 
                      aws_api_gateway_resource.parent[var.api_paths[each.value.path_key].parent_path].id
                    )
                  )
  http_method = each.value.method
  status_code = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Headers" = true
  }
  depends_on = [aws_api_gateway_method.options_method]
}

# Định nghĩa integration response cho OPTIONS (CORS)
resource "aws_api_gateway_integration_response" "options_integration_response" {
  for_each = {
    for item in flatten([
      for path_key, path in var.api_paths : [
        for method in path.http_methods : {
          key        = "${path_key}_${method.method}"
          path_key   = path_key
          method     = method.method
        } if method.method == "OPTIONS"
      ]
    ]) : item.key => item
  }
  rest_api_id = aws_api_gateway_rest_api.api.id
  # CODE CU (chi 3 cap):
  # resource_id = var.api_paths[each.value.path_key].grandchild_path != "" ? aws_api_gateway_resource.grandchild[try(local.path_key_to_grandchild_resource_key[each.value.path_key], each.value.path_key)].id : (
  #               var.api_paths[each.value.path_key].child_path != "" ? aws_api_gateway_resource.child["${var.api_paths[each.value.path_key].parent_path}/${var.api_paths[each.value.path_key].child_path}"].id : 
  #               aws_api_gateway_resource.parent[var.api_paths[each.value.path_key].parent_path].id
  #             )
  # CODE MOI (4 cap - support great_grandchild_path):
  # resource_id = var.api_paths[each.value.path_key].great_grandchild_path != "" ? aws_api_gateway_resource.great_grandchild[each.value.path_key].id : (
  #               var.api_paths[each.value.path_key].grandchild_path != "" ? aws_api_gateway_resource.grandchild[try(local.path_key_to_grandchild_resource_key[each.value.path_key], each.value.path_key)].id : (
  #                 var.api_paths[each.value.path_key].child_path != "" ? aws_api_gateway_resource.child["${var.api_paths[each.value.path_key].parent_path}/${var.api_paths[each.value.path_key].child_path}"].id : 
  #                 aws_api_gateway_resource.parent[var.api_paths[each.value.path_key].parent_path].id
  #               )
  #             )
  # CODE MOI (dung try() de xu ly optional field):
  resource_id = try(var.api_paths[each.value.path_key].great_grandchild_path, "") != "" ? aws_api_gateway_resource.great_grandchild[each.value.path_key].id : (
                    var.api_paths[each.value.path_key].grandchild_path != "" ? aws_api_gateway_resource.grandchild[try(local.path_key_to_grandchild_resource_key[each.value.path_key], each.value.path_key)].id : (
                      var.api_paths[each.value.path_key].child_path != "" ? aws_api_gateway_resource.child["${var.api_paths[each.value.path_key].parent_path}/${var.api_paths[each.value.path_key].child_path}"].id : 
                      aws_api_gateway_resource.parent[var.api_paths[each.value.path_key].parent_path].id
                    )
                  )
  http_method = each.value.method
  status_code = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
    "method.response.header.Access-Control-Allow-Methods" = "'GET,POST,PUT,DELETE,OPTIONS'"
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,Authorization,X-Amz-Date'"
  }
  depends_on = [aws_api_gateway_method.options_method, aws_api_gateway_method_response.options_response, aws_api_gateway_integration.integration]
}

# --- Bổ sung header CORS cho tất cả method response (bao gồm cả GET, POST, PUT, DELETE,...) ---
resource "aws_api_gateway_method_response" "lambda_response" {
  for_each = {
    for item in flatten([
      for path_key, path in var.api_paths : [
        for method in path.http_methods : {
          key        = "${path_key}_${method.method}"
          path_key   = path_key
          method     = method.method
          lambda_key = method.lambda_key
        } if method.lambda_key != ""
      ]
    ]) : item.key => item
  }
  rest_api_id = aws_api_gateway_rest_api.api.id
  # CODE CU (chi 3 cap):
  # resource_id = var.api_paths[each.value.path_key].grandchild_path != "" ? aws_api_gateway_resource.grandchild[try(local.path_key_to_grandchild_resource_key[each.value.path_key], each.value.path_key)].id : (
  #               var.api_paths[each.value.path_key].child_path != "" ? aws_api_gateway_resource.child["${var.api_paths[each.value.path_key].parent_path}/${var.api_paths[each.value.path_key].child_path}"].id : 
  #               aws_api_gateway_resource.parent[var.api_paths[each.value.path_key].parent_path].id
  #             )
  # CODE MOI (4 cap - support great_grandchild_path):
  # resource_id = var.api_paths[each.value.path_key].great_grandchild_path != "" ? aws_api_gateway_resource.great_grandchild[each.value.path_key].id : (
  #               var.api_paths[each.value.path_key].grandchild_path != "" ? aws_api_gateway_resource.grandchild[try(local.path_key_to_grandchild_resource_key[each.value.path_key], each.value.path_key)].id : (
  #                 var.api_paths[each.value.path_key].child_path != "" ? aws_api_gateway_resource.child["${var.api_paths[each.value.path_key].parent_path}/${var.api_paths[each.value.path_key].child_path}"].id : 
  #                 aws_api_gateway_resource.parent[var.api_paths[each.value.path_key].parent_path].id
  #               )
  #             )
  # CODE MOI (dung try() de xu ly optional field):
  resource_id = try(var.api_paths[each.value.path_key].great_grandchild_path, "") != "" ? aws_api_gateway_resource.great_grandchild[each.value.path_key].id : (
                    var.api_paths[each.value.path_key].grandchild_path != "" ? aws_api_gateway_resource.grandchild[try(local.path_key_to_grandchild_resource_key[each.value.path_key], each.value.path_key)].id : (
                      var.api_paths[each.value.path_key].child_path != "" ? aws_api_gateway_resource.child["${var.api_paths[each.value.path_key].parent_path}/${var.api_paths[each.value.path_key].child_path}"].id : 
                      aws_api_gateway_resource.parent[var.api_paths[each.value.path_key].parent_path].id
                    )
                  )
  http_method = each.value.method
  status_code = "200"
  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Content-Type" = true
    "method.response.header.Access-Control-Allow-Origin" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Headers" = true
  }
  depends_on = [aws_api_gateway_method.method]
}

# --- Bổ sung header CORS cho tất cả integration response (bao gồm cả GET, POST, PUT, DELETE,...) ---
resource "aws_api_gateway_integration_response" "lambda_integration_response" {
  for_each = {
    for item in flatten([
      for path_key, path in var.api_paths : [
        for method in path.http_methods : {
          key        = "${path_key}_${method.method}"
          path_key   = path_key
          method     = method.method
          lambda_key = method.lambda_key
        } if method.lambda_key != ""
      ]
    ]) : item.key => item
  }
  rest_api_id = aws_api_gateway_rest_api.api.id
  # CODE CU (chi 3 cap):
  # resource_id = var.api_paths[each.value.path_key].grandchild_path != "" ? aws_api_gateway_resource.grandchild[try(local.path_key_to_grandchild_resource_key[each.value.path_key], each.value.path_key)].id : (
  #               var.api_paths[each.value.path_key].child_path != "" ? aws_api_gateway_resource.child["${var.api_paths[each.value.path_key].parent_path}/${var.api_paths[each.value.path_key].child_path}"].id : 
  #               aws_api_gateway_resource.parent[var.api_paths[each.value.path_key].parent_path].id
  #             )
  # CODE MOI (4 cap - support great_grandchild_path):
  # resource_id = var.api_paths[each.value.path_key].great_grandchild_path != "" ? aws_api_gateway_resource.great_grandchild[each.value.path_key].id : (
  #               var.api_paths[each.value.path_key].grandchild_path != "" ? aws_api_gateway_resource.grandchild[try(local.path_key_to_grandchild_resource_key[each.value.path_key], each.value.path_key)].id : (
  #                 var.api_paths[each.value.path_key].child_path != "" ? aws_api_gateway_resource.child["${var.api_paths[each.value.path_key].parent_path}/${var.api_paths[each.value.path_key].child_path}"].id : 
  #                 aws_api_gateway_resource.parent[var.api_paths[each.value.path_key].parent_path].id
  #               )
  #             )
  # CODE MOI (dung try() de xu ly optional field):
  resource_id = try(var.api_paths[each.value.path_key].great_grandchild_path, "") != "" ? aws_api_gateway_resource.great_grandchild[each.value.path_key].id : (
                    var.api_paths[each.value.path_key].grandchild_path != "" ? aws_api_gateway_resource.grandchild[try(local.path_key_to_grandchild_resource_key[each.value.path_key], each.value.path_key)].id : (
                      var.api_paths[each.value.path_key].child_path != "" ? aws_api_gateway_resource.child["${var.api_paths[each.value.path_key].parent_path}/${var.api_paths[each.value.path_key].child_path}"].id : 
                      aws_api_gateway_resource.parent[var.api_paths[each.value.path_key].parent_path].id
                    )
                  )
  http_method = each.value.method
  status_code = "200"

  response_parameters = {
    "method.response.header.Content-Type" = "'application/json'"
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
    "method.response.header.Access-Control-Allow-Methods" = "'GET,POST,PUT,DELETE,OPTIONS'"
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,Authorization,X-Amz-Date'"
  }
  depends_on = [
    aws_api_gateway_integration.integration,
    aws_api_gateway_method_response.lambda_response
  ]
}

# Thêm resource random_id để force deploy
resource "random_id" "deployment" {
  byte_length = 8
}

# Thêm deployment để áp dụng thay đổi
resource "aws_api_gateway_deployment" "api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  
  triggers = {
    # Trigger khi có bất kỳ thay đổi nào trong API Gateway
    redeployment = sha1(jsonencode([
      aws_api_gateway_integration.integration,
      aws_api_gateway_method.method,
      aws_api_gateway_method.options_method,
      aws_api_gateway_method_response.lambda_response,
      aws_api_gateway_method_response.options_response,
      aws_api_gateway_integration_response.lambda_integration_response,
      aws_api_gateway_integration_response.options_integration_response,
      aws_api_gateway_resource.parent,
      aws_api_gateway_resource.child,
      aws_api_gateway_resource.grandchild,
      aws_api_gateway_resource.great_grandchild,
      random_id.deployment.hex, # Sẽ thay đổi mỗi lần apply
      local.mapping_templates # Trigger khi template thay đổi
    ]))
  }
  
  depends_on = [
    aws_api_gateway_integration.integration,
    aws_api_gateway_integration_response.options_integration_response,
    aws_api_gateway_integration_response.lambda_integration_response,
    aws_api_gateway_method_response.lambda_response,
    aws_api_gateway_method_response.options_response
  ]
  
  lifecycle {
    create_before_destroy = true
  }
}

# --- Cognito Authorizer cho API Gateway ---
resource "aws_api_gateway_authorizer" "cognito" {
  name                    = "cognito-authorizer"
  rest_api_id             = aws_api_gateway_rest_api.api.id
  type                    = "COGNITO_USER_POOLS"
  provider_arns           = [var.cognito_user_pool_arn]
  identity_source         = "method.request.header.Authorization"
}

# --- Đã xóa resource aws_api_gateway_method.method ở đây để tránh trùng lặp, giữ lại ở methods.tf ---


