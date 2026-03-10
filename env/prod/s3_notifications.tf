# # S3 Notifications - được tách riêng để tránh circular dependency và dễ quản lý
# # Lưu ý: File này phải được load SAU khi main.tf đã tạo xong các modules
# 
# # Lambda Permission cho create-thumbnail function
# resource "aws_lambda_permission" "s3_create_thumbnail" {
#   statement_id  = "AllowS3InvokeCreateThumbnail"
#   action        = "lambda:InvokeFunction"
#   function_name = module.lambda_functions["lambda_56"].function_name
#   principal     = "s3.amazonaws.com"
#   source_arn    = module.core_resources.s3_bucket_arns["bucket1"]  # Sử dụng key "bucket1"
#   
#   # QUAN TRỌNG: depends_on để đảm bảo thứ tự tạo
#   depends_on = [
#     module.core_resources,
#     module.lambda_functions
#   ]
# }
# 
# # Lambda Permission cho add-quotation function
# resource "aws_lambda_permission" "s3_add_quotation" {
#   statement_id  = "AllowS3InvokeAddQuotation"
#   action        = "lambda:InvokeFunction"
#   function_name = module.lambda_functions["lambda_57"].function_name
#   principal     = "s3.amazonaws.com"
#   source_arn    = module.core_resources.s3_bucket_arns["bucket1"]  # Sử dụng key "bucket1"
#   
#   # QUAN TRỌNG: depends_on để đảm bảo thứ tự tạo
#   depends_on = [
#     module.core_resources,
#     module.lambda_functions
#   ]
# }
# 
# # S3 Bucket Notification cho bucket1 (assets bucket)
# resource "aws_s3_bucket_notification" "bucket1_notification" {
#   bucket = module.core_resources.s3_bucket_ids["bucket1"]  # Sử dụng bucket ID thay vì name
# 
#   # Enable EventBridge notifications for all S3 events
#   eventbridge = true
# 
#   # # Notification cho Lambda create-thumbnail (image files)
#   # lambda_function {
#   #   lambda_function_arn = module.lambda_functions["lambda_56"].arn
#   #   events              = ["s3:ObjectCreated:*"]
#   #   filter_prefix       = "originals/"
#   #   filter_suffix       = ".JPEG"
#   # }
#   # lambda_function {
#   #   lambda_function_arn = module.lambda_functions["lambda_56"].arn
#   #   events              = ["s3:ObjectCreated:*"]
#   #   filter_prefix       = "originals/"
#   #   filter_suffix       = ".jpeg"
#   # }
#   # lambda_function {
#   #   lambda_function_arn = module.lambda_functions["lambda_56"].arn
#   #   events              = ["s3:ObjectCreated:*"]
#   #   filter_prefix       = "originals/"
#   #   filter_suffix       = ".jpg"
#   # }
#   # lambda_function {
#   #   lambda_function_arn = module.lambda_functions["lambda_56"].arn
#   #   events              = ["s3:ObjectCreated:*"]
#   #   filter_prefix       = "originals/"
#   #   filter_suffix       = ".JPG"
#   # }
#   # lambda_function {
#   #   lambda_function_arn = module.lambda_functions["lambda_56"].arn
#   #   events              = ["s3:ObjectCreated:*"]
#   #   filter_prefix       = "originals/"
#   #   filter_suffix       = ".WEBP"
#   # }
#   # lambda_function {
#   #   lambda_function_arn = module.lambda_functions["lambda_56"].arn
#   #   events              = ["s3:ObjectCreated:*"]
#   #   filter_prefix       = "originals/"
#   #   filter_suffix       = ".webp"
#   # }
#   # lambda_function {
#   #   lambda_function_arn = module.lambda_functions["lambda_56"].arn
#   #   events              = ["s3:ObjectCreated:*"]
#   #   filter_prefix       = "originals/"
#   #   filter_suffix       = ".PNG"
#   # }
#   # lambda_function {
#   #   lambda_function_arn = module.lambda_functions["lambda_56"].arn
#   #   events              = ["s3:ObjectCreated:*"]
#   #   filter_prefix       = "originals/"
#   #   filter_suffix       = ".png"
#   # }
#   
#   # Notification cho Lambda add-quotation (Excel files)
#   lambda_function {
#     lambda_function_arn = module.lambda_functions["lambda_57"].arn
#     events              = ["s3:ObjectCreated:*"]
#     filter_prefix       = "originals/"
#     filter_suffix       = ".xlsx"
#   }
#   lambda_function {
#     lambda_function_arn = module.lambda_functions["lambda_57"].arn
#     events              = ["s3:ObjectCreated:*"]
#     filter_prefix       = "originals/"
#     filter_suffix       = ".xls"
#   }
#   lambda_function {
#     lambda_function_arn = module.lambda_functions["lambda_57"].arn
#     events              = ["s3:ObjectCreated:*"]
#     filter_prefix       = "originals/"
#     filter_suffix       = ".XLSX"
#   }
#   lambda_function {
#     lambda_function_arn = module.lambda_functions["lambda_57"].arn
#     events              = ["s3:ObjectCreated:*"]
#     filter_prefix       = "originals/"
#     filter_suffix       = ".XLS"
#   }
# 
#   # QUAN TRỌNG: depends_on để đảm bảo thứ tự tạo
#   depends_on = [
#     aws_lambda_permission.s3_create_thumbnail,
#     aws_lambda_permission.s3_add_quotation,
#     module.core_resources,
#     module.lambda_functions
#   ]
# 
#   
#   lifecycle {
#     ignore_changes = [
#       eventbridge
#     ]
#   }
# } 