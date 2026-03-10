# # root/modules/module_lambda/outputs.tf

# output "lambda_function_arns" {
#   description = "Map of Lambda function ARNs"
#   value = {
#     for k, lambda in aws_lambda_function.lambda_functions : k => lambda.arn
#   }
# }

# output "lambda_function_names" {
#   description = "Map of Lambda function names"
#   value = {
#     for k, lambda in aws_lambda_function.lambda_functions : k => lambda.function_name
#   }
# }

# output "invoke_arns" {
#   description = "Map of Lambda function invoke ARNs"
#   value = {
#     for k, lambda in aws_lambda_function.lambda_functions : lambda.function_name => lambda.invoke_arn
#   }
# }

# output "lambda_functions" {
#   description = "Map of Lambda function details"
#   value = {
#     for k, v in aws_lambda_function.lambda_functions : k => {
#       arn           = v.arn
#       function_name = v.function_name
#       invoke_arn    = v.invoke_arn
#     }
#   }
# }

output "arn" {
  description = "ARN of the Lambda function"
  value       = aws_lambda_function.this.arn
}

output "function_name" {
  description = "Name of the Lambda function"
  value       = aws_lambda_function.this.function_name
}

output "invoke_arn" {
  description = "Invoke ARN of the Lambda function"
  value       = aws_lambda_function.this.invoke_arn
}


