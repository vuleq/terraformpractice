# Outputs for EventBridge Scheduler Module

output "scheduler_arn" {
  description = "ARN of the EventBridge scheduler"
  value       = aws_scheduler_schedule.this.arn
}

output "scheduler_name" {
  description = "Name of the EventBridge scheduler"
  value       = aws_scheduler_schedule.this.name
}

output "scheduler_group_name" {
  description = "Name of the EventBridge scheduler group"
  value       = var.create_schedule_group ? aws_scheduler_schedule_group.this[0].name : var.scheduler_group_name
}

output "scheduler_group_arn" {
  description = "ARN of the EventBridge scheduler group"
  value       = var.create_schedule_group ? aws_scheduler_schedule_group.this[0].arn : null
}

output "scheduler_role_arn" {
  description = "ARN of the IAM role for EventBridge scheduler"
  value       = var.existing_role_arn
}

output "scheduler_state" {
  description = "Current state of the scheduler"
  value       = aws_scheduler_schedule.this.state
}

output "schedule_expression" {
  description = "Schedule expression used"
  value       = aws_scheduler_schedule.this.schedule_expression
}
