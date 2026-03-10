# Outputs for Step Functions State Machine Module

output "state_machine_arn" {
  description = "ARN of the Step Functions state machine"
  value       = aws_sfn_state_machine.this.arn
}

output "state_machine_name" {
  description = "Name of the Step Functions state machine"
  value       = aws_sfn_state_machine.this.name
}

output "state_machine_role_arn" {
  description = "ARN of the IAM role used by the state machine"
  # Sử dụng existing_role_arn (role creation đã bị comment)
  # Nếu muốn tạo role mới, uncomment phần tạo role trong main.tf và sửa lại logic này
  value = var.existing_role_arn
  # value = var.existing_role_arn != null ? var.existing_role_arn : aws_iam_role.state_machine[0].arn
}

output "state_machine_role_name" {
  description = "Name of the IAM role used by the state machine"
  # Extract role name from ARN: arn:aws:iam::ACCOUNT:role/ROLE_NAME
  value = var.existing_role_arn != null ? (
    split("/", var.existing_role_arn)[length(split("/", var.existing_role_arn)) - 1]
  ) : null
  # Nếu muốn tạo role mới, uncomment phần tạo role trong main.tf và sửa lại logic này
  # value = var.existing_role_arn != null ? (
  #   split("/", var.existing_role_arn)[length(split("/", var.existing_role_arn)) - 1]
  # ) : aws_iam_role.state_machine[0].name
}

