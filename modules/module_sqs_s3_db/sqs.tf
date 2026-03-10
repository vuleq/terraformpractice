# SQS Queues - Tách DLQ và main queues để tránh circular dependency
# Tạo DLQ queues trước (không có dlq_key)
resource "aws_sqs_queue" "dlq" {
  for_each = {
    for k, v in var.sqs_queues : k => v
    if lookup(v, "dlq_key", null) == null && length(lookup(v, "lambda_keys", [])) == 0
  }

  name                      = each.value.name
  delay_seconds             = lookup(each.value, "delay_seconds", 0)
  message_retention_seconds = lookup(each.value, "retention_seconds", 345600)  # Default: 4 days
  visibility_timeout_seconds = lookup(each.value, "visibility_timeout", 60)
  receive_wait_time_seconds = lookup(each.value, "receive_wait_time", 0)  # 0 = short polling, >0 = long polling
}

# Tạo main queues (có thể có dlq_key reference đến DLQ)
resource "aws_sqs_queue" "this" {
  for_each = {
    for k, v in var.sqs_queues : k => v
    if lookup(v, "dlq_key", null) != null || length(lookup(v, "lambda_keys", [])) > 0
  }

  name                      = each.value.name
  delay_seconds             = lookup(each.value, "delay_seconds", 0)
  message_retention_seconds = lookup(each.value, "retention_seconds", 345600)  # Default: 4 days
  visibility_timeout_seconds = lookup(each.value, "visibility_timeout", 60)
  receive_wait_time_seconds = lookup(each.value, "receive_wait_time", 0)  # 0 = short polling, >0 = long polling

  # Dead Letter Queue configuration
  # Reference đến DLQ queue (đã tách ra resource riêng)
  redrive_policy = lookup(each.value, "dlq_key", null) != null ? jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq[each.value.dlq_key].arn
    maxReceiveCount     = lookup(each.value, "max_receive_count", 3)
  }) : null
}

# Lambda Event Source Mappings - Integrate SQS với Lambda
resource "aws_lambda_event_source_mapping" "sqs_to_lambda" {
  for_each = {
    for item in flatten([
      for queue_key, queue in var.sqs_queues : [
        for lambda_key in lookup(queue, "lambda_keys", []) : {
          key         = "${queue_key}_${lambda_key}"
          queue_key   = queue_key
          lambda_key  = lambda_key
          queue_name  = queue.name
          batch_size  = lookup(queue, "batch_size", 10)
          enabled     = lookup(queue, "enabled", true)
        }
      ]
    ]) : item.key => item
  }

  event_source_arn = contains(keys(aws_sqs_queue.this), each.value.queue_key) ? aws_sqs_queue.this[each.value.queue_key].arn : aws_sqs_queue.dlq[each.value.queue_key].arn
  function_name     = var.lambda_functions[each.value.lambda_key].function_name
  batch_size        = each.value.batch_size
  enabled           = each.value.enabled

  # SQS-specific settings
  maximum_batching_window_in_seconds = lookup(var.sqs_queues[each.value.queue_key], "batching_window", 0)
  
  # Error handling
  # maximum_retry_attempts = lookup(var.sqs_queues[each.value.queue_key], "max_retry_attempts", 5)  # -1 = unlimited

  depends_on = [
    aws_sqs_queue.this,
    aws_lambda_permission.sqs_to_lambda
  ]
}

# Lambda permissions để SQS có thể invoke Lambda
resource "aws_lambda_permission" "sqs_to_lambda" {
  for_each = {
    for item in flatten([
      for queue_key, queue in var.sqs_queues : [
        for lambda_key in lookup(queue, "lambda_keys", []) : {
          key        = "${queue_key}_${lambda_key}"
          queue_key  = queue_key
          lambda_key = lambda_key
        }
      ]
    ]) : item.key => item
  }

  statement_id  = "AllowExecutionFromSQS-${substr(each.value.queue_key, 0, 30)}-${substr(each.value.lambda_key, 0, 20)}"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_functions[each.value.lambda_key].function_name
  principal     = "sqs.amazonaws.com"
  source_arn    = contains(keys(aws_sqs_queue.this), each.value.queue_key) ? aws_sqs_queue.this[each.value.queue_key].arn : aws_sqs_queue.dlq[each.value.queue_key].arn
}

