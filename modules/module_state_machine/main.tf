# Step Functions State Machine Module
# Tạo AWS Step Functions State Machine để orchestrate workflows

# IAM Role cho State Machine
# COMMENTED: Không tạo role mới, sử dụng existing role
# Chỉ tạo role mới nếu không có existing_role_arn
# resource "aws_iam_role" "state_machine" {
#   count = var.existing_role_arn == null ? 1 : 0
#   
#   name = "${var.state_machine_name}-role"
#
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Principal = {
#           Service = "states.amazonaws.com"
#         }
#       }
#     ]
#   })
#
#   tags = {
#     Name        = "${var.state_machine_name}-role"
#     Environment = var.environment
#     Purpose     = "IAM Role for ${var.state_machine_name}"
#   }
# }

# IAM Policy cho State Machine
# COMMENTED: Không tạo policy mới, sử dụng existing role (role đã có policy sẵn)
# Chỉ tạo policy nếu tạo role mới
# resource "aws_iam_role_policy" "state_machine" {
#   count = var.existing_role_arn == null ? 1 : 0
#   
#   name = "${var.state_machine_name}-policy"
#   role = aws_iam_role.state_machine[0].id
#
#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = var.iam_policy_statements
#   })
# }

# Local để chọn role ARN
# Sử dụng existing_role_arn (bắt buộc phải có vì không có permission tạo role mới)
locals {
  # Bắt buộc phải có existing_role_arn
  # Nếu muốn tạo role mới, uncomment phần tạo role ở trên và sửa lại logic này
  state_machine_role_arn = var.existing_role_arn
}

# State Machine Definition (từ file hoặc inline)
# LƯU Ý: Definition file phải có ARN đúng format
# Nếu export từ AWS Console, sử dụng script helper để fix ARN:
#   .\devops\scripts\fix-state-machine-arns.ps1
locals {
  # Đọc definition từ file hoặc dùng inline JSON
  raw_definition = var.definition_file != null ? file(var.definition_file) : (
    var.definition_json != null ? var.definition_json : null
  )
  
  # Replace REGION và ACCOUNT placeholders (nếu có)
  # Để replace function names hoặc lambda keys, sử dụng script helper trước
  state_machine_definition = local.raw_definition != null ? (
    var.account_id != null && var.region != null ? (
      replace(
        replace(
          local.raw_definition,
          "REGION",
          var.region
        ),
        "ACCOUNT",
        var.account_id
      )
    ) : local.raw_definition
  ) : null
}

# Step Functions State Machine
resource "aws_sfn_state_machine" "this" {
  name     = var.state_machine_name
  role_arn = local.state_machine_role_arn

  # Definition từ local 
  # Nếu null, Terraform sẽ tự động báo lỗi khi apply
  definition = local.state_machine_definition

  # Logging configuration (optional)
  # Chỉ enable logging nếu có log_group_arn (không được null)
  dynamic "logging_configuration" {
    for_each = var.enable_logging && var.log_group_arn != null ? [1] : []
    content {
      log_destination        = var.log_group_arn
      include_execution_data = var.include_execution_data
      level                  = var.log_level
    }
  }

  # Tracing configuration (optional)
  dynamic "tracing_configuration" {
    for_each = var.enable_tracing ? [1] : []
    content {
      enabled = true
    }
  }

  tags = merge(
    {
      Name        = var.state_machine_name
      Environment = var.environment
    },
    var.additional_tags
  )
}

