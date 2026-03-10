# EventBridge Scheduler Module
# Tạo EventBridge scheduler để trigger Lambda function theo lịch
# Sử dụng existing IAM role (cần update trust policy để include scheduler.amazonaws.com)

# EventBridge Scheduler Group - chỉ tạo nếu create_schedule_group = true
resource "aws_scheduler_schedule_group" "this" {
  count = var.create_schedule_group ? 1 : 0
  
  name = var.scheduler_group_name
  
  tags = {
    Name        = var.scheduler_group_name
    Environment = var.environment
    Purpose     = "EventBridge Scheduler Group for ${var.scheduler_name}"
  }
}

# Local để lấy group name (từ resource mới tạo hoặc dùng tên được truyền vào)
locals {
  schedule_group_name = var.create_schedule_group ? aws_scheduler_schedule_group.this[0].name : var.scheduler_group_name
}

# EventBridge Scheduler
resource "aws_scheduler_schedule" "this" {
  name       = var.scheduler_name
  group_name = local.schedule_group_name  # Sử dụng group name từ local

  # Schedule expression - có thể cấu hình thông qua variable
  # Mặc định: 6:00 AM UTC+8 (Singapore time) = 22:00 UTC
  # Cron format: minute hour day month day-of-week year
  schedule_expression = var.schedule_expression

  # Flexible time window - cho phép chạy trong khoảng 1 giờ
  flexible_time_window {
    mode = "OFF"
  }

  # Target configuration
  target {
    arn      = var.target_lambda_arn
    role_arn = var.existing_role_arn

    # Input payload cho Lambda function
    input = var.lambda_input != null ? jsonencode(var.lambda_input) : null

    # Retry policy
    retry_policy {
      maximum_retry_attempts = var.max_retry_attempts
      maximum_event_age_in_seconds = var.max_event_age
    }

    # Dead letter queue (optional)
    dynamic "dead_letter_config" {
      for_each = var.dead_letter_queue_arn != null ? [1] : []
      content {
        arn = var.dead_letter_queue_arn
      }
    }
  }

  # State
  state = var.enabled ? "ENABLED" : "DISABLED"

  # Lifecycle: Ignore changes từ AWS Console/web
  # Cho phép thay đổi scheduler trên web mà không bị Terraform revert lại
  lifecycle {
    ignore_changes = [
      # schedule_expression,
      target[0].input,
      target[0].retry_policy[0].maximum_retry_attempts,
      target[0].retry_policy[0].maximum_event_age_in_seconds,
    ]
  }
}

# Lambda Permission để cho phép EventBridge invoke Lambda
resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = var.target_lambda_function_name
  principal     = "scheduler.amazonaws.com"
  source_arn    = aws_scheduler_schedule.this.arn
}
