output "s3_bucket_names" {
  value = [for b in aws_s3_bucket.this : b.bucket]
}
# SQS Queues Outputs - Merge DLQ và main queues
output "sqs_queue_urls" {
  description = "SQS queue URLs"
  value       = merge(
    { for k, q in aws_sqs_queue.dlq : k => q.url },
    { for k, q in aws_sqs_queue.this : k => q.url }
  )
}

output "sqs_queue_arns" {
  description = "SQS queue ARNs"
  value       = merge(
    { for k, q in aws_sqs_queue.dlq : k => q.arn },
    { for k, q in aws_sqs_queue.this : k => q.arn }
  )
}

output "sqs_queue_dlq_config" {
  description = "SQS queue Dead Letter Queue configuration - shows which queue uses which DLQ"
  value = {
    for k, q in var.sqs_queues : k => {
      queue_name        = q.name
      dlq_key           = lookup(q, "dlq_key", null)
      dlq_arn           = lookup(q, "dlq_key", null) != null ? aws_sqs_queue.dlq[q.dlq_key].arn : null
      dlq_name          = lookup(q, "dlq_key", null) != null ? var.sqs_queues[q.dlq_key].name : null
      max_receive_count = lookup(q, "max_receive_count", null)
    } if lookup(q, "dlq_key", null) != null
  }
}

output "rds_endpoints" {
  value = [for db in aws_rds_cluster_instance.this : db.endpoint]
}

# Cluster endpoint (tự động route write operations đến writer instance)
output "rds_cluster_endpoint" {
  value = { for k, cluster in aws_rds_cluster.this : k => cluster.endpoint }
}

# Reader endpoint (endpoint của reader instance)
output "rds_reader_endpoint" {
  value = [for k, instance in aws_rds_cluster_instance.this : instance.endpoint if k == "wdr_reader_1"]
}

output "website_url" {
  value = aws_s3_bucket_website_configuration.website_config["bucket3"].website_endpoint
}

output "s3_bucket_arns" {
  value = { for k, v in aws_s3_bucket.this : k => v.arn }
}

output "s3_bucket_ids" {
  value = { for k, b in aws_s3_bucket.this : k => b.id }
}

