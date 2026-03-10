# =====================
# CloudFront Distribution với Origin Access Control (OAC) cho S3 Private Bucket
# =====================

# Response Headers Policy cho FE với Custom Response Headers
resource "aws_cloudfront_response_headers_policy" "fe_security_policy" {
  name    = "prod-wdr-fe-response-header-security-policy-fe"
  comment = "Response headers policy for FE with custom headers"

  security_headers_config {
    strict_transport_security {
      access_control_max_age_sec = 31536000
      include_subdomains         = true
      preload                    = true
      override                   = true
    }
    frame_options {
      frame_option = "SAMEORIGIN"
      override     = true
    }
  }

  remove_headers_config {
    items {
      header = "server"
    }
  }
}

# Response Headers Policy cho BE với CORS và Security headers
resource "aws_cloudfront_response_headers_policy" "be_security_policy" {
  name    = "prod-wdr-be-response-header-security-policy"
  comment = "Response headers policy for BE with security headers (CORS disabled)"


  security_headers_config {
    strict_transport_security {
      access_control_max_age_sec = 31536000
      include_subdomains         = true
      preload                    = true
      override                   = true
    }
    content_type_options {
      override = true
    }
    frame_options {
      frame_option = "DENY"
      override     = false
    }
    xss_protection {
      mode_block = false
      protection = true
      override   = true
    }
    content_security_policy {
      content_security_policy = "default-sre 'self'; script-src, 'self'; style-src, 'self'; object-src 'none'; base-uxi 'self'; frame-ancestors 'none';"
      override = true
    }
  }

  remove_headers_config {
    items {
      header = "server"
    }
  }

}


# Tạo Origin Access Control cho S3 buckets - ENABLED (imported from manual setup)
resource "aws_cloudfront_origin_access_control" "s3_oac" {
  for_each = var.enable_oac_for_fe ? { for k, v in var.cloudfront_distributions : k => v if lookup(v, "origin_type", "s3") == "s3" } : {}
  
  name                              = "prod-wdr-maritimeapps-deploy-lambda-fe-source6.s3"
  description                       = "Origin Access Control for fe_site S3 bucket"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
  
  lifecycle {
    ignore_changes = [id]
  }
}

resource "aws_cloudfront_distribution" "this" {
  for_each = var.cloudfront_distributions

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  comment             = lookup(each.value, "name", "CloudFront Distribution for ${each.key}")

  lifecycle {
    ignore_changes = [
      default_cache_behavior[0].lambda_function_association, 
      # default_cache_behavior[0].function_association,  
      # ordered_cache_behavior,
      origin,
      web_acl_id,
      aliases,
      viewer_certificate
    ]

  }

  # Origin configuration
  origin {
    domain_name = each.value.origin_domain_name
    origin_id   = "${each.key}_origin"
    origin_path = lookup(each.value, "origin_path", null)

    # Origin configuration cho FE và BE
    # Sử dụng s3_origin_config cho FE (S3) và custom_origin_config cho BE (API Gateway)
    origin_access_control_id = var.enable_oac_for_fe && lookup(each.value, "origin_type", "s3") == "s3" ? aws_cloudfront_origin_access_control.s3_oac[each.key].id : null
    
    # S3 Origin Config cho FE (khi dùng OAC)
    dynamic "s3_origin_config" {
      for_each = var.enable_oac_for_fe && lookup(each.value, "origin_type", "s3") == "s3" ? [1] : []
      content {
        origin_access_identity = ""
      }
    }
    
    # Custom Origin Config cho BE (API Gateway) hoặc FE (khi không dùng OAC)
    dynamic "custom_origin_config" {
      for_each = (!var.enable_oac_for_fe && lookup(each.value, "origin_type", "s3") == "s3") || lookup(each.value, "origin_type", "s3") != "s3" ? [1] : []
      content {
        http_port              = 80
        https_port             = 443
        origin_protocol_policy = "https-only"
        origin_ssl_protocols   = ["TLSv1.2"]
      }
    }
  }

  # Cognito Origins - chỉ thêm cho FE distribution
  # dynamic "origin" {
  #   for_each = lookup(each.value, "origin_type", "s3") == "s3" && var.enable_cognito_proxy ? [1] : []
  #   content {
  #     domain_name = "cognito-idp.ap-southeast-1.amazonaws.com"
  #     origin_id   = "cognito-idp"

  #     custom_origin_config {
  #       http_port              = 80
  #       https_port             = 443
  #       origin_protocol_policy = "https-only"
  #       origin_ssl_protocols   = ["TLSv1.2"]
  #     }

  #     custom_header {
  #       name  = "X-Origin-Type"
  #       value = "cognito-idp"
  #     }
  #   }
  # }

  # dynamic "origin" {
  #   for_each = lookup(each.value, "origin_type", "s3") == "s3" && var.enable_cognito_proxy ? [1] : []
  #   content {
  #     domain_name = "cognito-identity.ap-southeast-1.amazonaws.com"
  #     origin_id   = "cognito-identity"

  #     custom_origin_config {
  #       http_port              = 80
  #       https_port             = 443
  #       origin_protocol_policy = "https-only"
  #       origin_ssl_protocols   = ["TLSv1.2"]
  #     }

  #     custom_header {
  #       name  = "X-Origin-Type"
  #       value = "cognito-identity"
  #     }
  #   }
  # }

  # S3 Assets Origin - chỉ thêm cho FE distribution khi có config
  dynamic "origin" {
    for_each = lookup(each.value, "origin_type", "s3") == "s3" && lookup(each.value, "s3_assets_bucket_domain", null) != null ? [1] : []
    content {
      domain_name = each.value.s3_assets_bucket_domain
      origin_id   = "s3-assets"

      custom_origin_config {
        http_port              = 80
        https_port             = 443
        origin_protocol_policy = "https-only"
        origin_ssl_protocols   = ["TLSv1.2"]
      }
    }
  }

  # Default cache behavior - áp dụng cho cả FE và BE với setup khác nhau
  default_cache_behavior {
    target_origin_id       = "${each.key}_origin"
    # FE và BE: HTTPS only
    viewer_protocol_policy = "https-only"

    # FE: GET, HEAD, OPTIONS only, BE: All methods
    allowed_methods  = each.value.origin_type == "s3" ? ["GET", "HEAD", "OPTIONS"] : ["GET", "HEAD", "OPTIONS", "POST", "PUT", "PATCH", "DELETE"]
    cached_methods   = ["GET", "HEAD"]
    compress         = true
    default_ttl      = 0
    max_ttl          = 0
    min_ttl          = 0
    
    # Sử dụng Cache Policy và Origin Request Policy khác nhau cho FE và BE
    # FE (S3): CachingOptimized, BE (API Gateway): CachingDisabled
    cache_policy_id = lookup(each.value, "origin_type", "s3") == "s3" ? "658327ea-f89d-4fab-a63d-7e88639e58f6" : "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"
    
    # Origin Request Policy chỉ áp dụng cho BE (API Gateway), FE không có
    origin_request_policy_id = lookup(each.value, "origin_type", "s3") == "s3" ? null : "b689b0a8-53d0-40ab-baf2-68738e2966ac"
    
    # Response Headers Policy: FE dùng security policy, BE dùng CORS + security policy
    response_headers_policy_id = lookup(each.value, "origin_type", "s3") == "s3" ? aws_cloudfront_response_headers_policy.fe_security_policy.id : aws_cloudfront_response_headers_policy.be_security_policy.id
    
    # CloudFront Function Associations với viewer-response event
    # FE Function - COMMENT LẠI vì chỉ dùng BE function
    # dynamic "function_association" {
    #   for_each = lookup(each.value, "origin_type", "s3") == "s3" ? [1] : []
    #   content {
    #     event_type   = "viewer-response"
    #     function_arn = aws_cloudfront_function.fe_function.arn
    #   }
    # }
    
    # BE (API Gateway): Use BE function
    dynamic "function_association" {
      for_each = lookup(each.value, "origin_type", "s3") != "s3" ? [1] : []
      content {
        event_type   = "viewer-response"
        function_arn = aws_cloudfront_function.be_function.arn
      }
    }
    
    # Lambda@Edge Function Associations - COMMENT LẠI vì không dùng Lambda@Edge nữa
    # dynamic "lambda_function_association" {
    #   for_each = lookup(each.value, "lambda_edge_functions", [])
    #   content {
    #     event_type = lambda_function_association.value.event_type
    #     lambda_arn = lambda_function_association.value.function_arn
    #   }
    # }
  }

  # Cognito Cache Behaviors - chỉ thêm cho FE distribution
  # Behavior cho /identity path - route đến cognito-identity
  # dynamic "ordered_cache_behavior" {
  #   for_each = lookup(each.value, "origin_type", "s3") == "s3" && var.enable_cognito_proxy ? [1] : []
  #   content {
  #     path_pattern     = "/identity"
  #     target_origin_id = "cognito-identity"
  #     viewer_protocol_policy = "redirect-to-https"

  #     allowed_methods  = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
  #     cached_methods   = ["GET", "HEAD"]
  #     compress         = true
  #     default_ttl      = 0
  #     max_ttl          = 0
  #     min_ttl          = 0

  #     # Use CachingDisabled policy cho Cognito services
  #     cache_policy_id = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"  # Managed-CachingDisabled
  #   }
  # }

  # Behavior cho /idp path - route đến cognito-idp
  # dynamic "ordered_cache_behavior" {
  #   for_each = lookup(each.value, "origin_type", "s3") == "s3" && var.enable_cognito_proxy ? [1] : []
  #   content {
  #     path_pattern     = "/idp"
  #     target_origin_id = "cognito-idp"
  #     viewer_protocol_policy = "redirect-to-https"

  #     allowed_methods  = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
  #     cached_methods   = ["GET", "HEAD"]
  #     compress         = true
  #     default_ttl      = 0
  #     max_ttl          = 0
  #     min_ttl          = 0

  #     # Use CachingDisabled policy cho Cognito services
  #     cache_policy_id = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"  # Managed-CachingDisabled
  #   }
  # }

  # Behavior cho /s3assets/* path - route đến S3 assets bucket
  # dynamic "ordered_cache_behavior" {
  #   for_each = lookup(each.value, "origin_type", "s3") == "s3" && lookup(each.value, "s3_assets_bucket_domain", null) != null ? [1] : []
  #   content {
  #     path_pattern     = "/s3assets/*"
  #     target_origin_id = "s3-assets"
  #     viewer_protocol_policy = "https-only"

  #     allowed_methods  = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
  #     cached_methods   = ["GET", "HEAD"]
  #     compress         = true
  #     default_ttl      = 3600
  #     max_ttl          = 86400
  #     min_ttl          = 0

  #     # Use CachingOptimized policy cho S3 assets
  #     cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6"  # Managed-CachingOptimized (Recommended for S3)
  #   }
  # }

  # Custom cache behavior cho BE (API Gateway) - COMMENT LẠI vì BE đã dùng default với setup riêng
  # dynamic "ordered_cache_behavior" {
  #   for_each = lookup(each.value, "origin_type", "s3") == "api_gateway" ? [1] : []
  #   content {
  #     path_pattern     = "*"  # Áp dụng cho tất cả paths của BE
  #     target_origin_id = "${each.key}_origin"
  #     viewer_protocol_policy = "allow-all"  # HTTP and HTTPS

  #     allowed_methods  = ["GET", "HEAD", "OPTIONS", "POST", "PUT", "DELETE", "PATCH"]
  #     cached_methods   = ["GET", "HEAD"]
  #     compress         = true
  #     default_ttl      = 0
  #     max_ttl          = 0
  #     min_ttl          = 0
      
  #     # Sử dụng Cache Policy và Origin Request Policy (recommended) cho BE
  #     cache_policy_id          = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"  # Managed-CachingDisabled (Recommended for API Gateway)
  #     origin_request_policy_id = "b689b0a8-53d0-40ab-baf2-68738e2966ac"  # Managed-AllViewerExceptHostHeader (Recommended for API Gateway)
  #   }
  # }

  # Error pages cho Angular routing - chỉ áp dụng cho S3 origins
  # UNCOMMENT KHI CẦN: Nếu FE app cần handle 404/403 errors và redirect về index.html
  # dynamic "custom_error_response" {
  #   for_each = lookup(each.value, "origin_type", "s3") == "s3" ? [403, 404] : []
  #   content {
  #     error_code            = custom_error_response.value
  #     response_code         = "200"
  #     response_page_path    = "/index.html"
  #     error_caching_min_ttl = 0
  #   }
  # }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }


  
}

# S3 Bucket Policy cho CloudFront OAC - ENABLED (imported from manual setup)
resource "aws_s3_bucket_policy" "cloudfront_oac" {
  for_each = var.enable_oac_for_fe ? { for k, v in var.cloudfront_distributions : k => v if lookup(v, "origin_type", "s3") == "s3" } : {}
  
  bucket = split(".s3.", each.value.origin_domain_name)[0]

  policy = jsonencode({
    Version = "2008-10-17"
    Id      = "PolicyForCloudFrontPrivateContent"
    Statement = [
      {
        Sid       = "AllowCloudFrontServicePrincipal"
        Effect    = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action   = "s3:GetObject"
        Resource = "arn:aws:s3:::${split(".s3.", each.value.origin_domain_name)[0]}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = aws_cloudfront_distribution.this[each.key].arn
          }
        }
      }
    ]
  })

  lifecycle {
    # ignore_changes = [policy]
  }
}

# S3 Bucket Policy cho Assets Bucket - Cho phép CloudFront truy cập
# Assets bucket: prod-wdr-maritimeapps-deploy-lambda-assets6
# Assets bucket dùng custom_origin_config, cần policy riêng
resource "aws_s3_bucket_policy" "cloudfront_access_assets" {
  for_each = var.enable_oac_for_fe ? { 
    for k, v in var.cloudfront_distributions : k => v 
    if lookup(v, "origin_type", "s3") == "s3" && lookup(v, "s3_assets_bucket_domain", null) != null 
  } : {}
  
  bucket = split(".s3.", each.value.s3_assets_bucket_domain)[0]

  policy = jsonencode({
    Version = "2008-10-17"
    Id      = "PolicyForCloudFrontPrivateContent"
    Statement = [
      {
        Sid       = "AllowCloudFrontServicePrincipal"
        Effect    = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ]
        Resource = "arn:aws:s3:::${split(".s3.", each.value.s3_assets_bucket_domain)[0]}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = aws_cloudfront_distribution.this[each.key].arn
          }
        }
      },
      {
        Sid    = "EnforceSSLRequestsOnly"
        Effect = "Deny"
        Principal = "*"
        Action = "s3:*"
        Resource = [
          "arn:aws:s3:::${split(".s3.", each.value.s3_assets_bucket_domain)[0]}",
          "arn:aws:s3:::${split(".s3.", each.value.s3_assets_bucket_domain)[0]}/*"
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      }
    ]
  })

  lifecycle {
    # ignore_changes = [policy]  # Uncomment nếu muốn update manual trên Console
  }
}

# CloudFront Distribution cho Cognito Proxy
# resource "aws_cloudfront_distribution" "cognito_proxy" {
#   count = var.enable_cognito_proxy ? 1 : 0
  
#   enabled             = true
#   is_ipv6_enabled     = true
#   comment             = "CloudFront Distribution for Cognito Services Proxy"

#   # Origin 1: Cognito User Pool (cognito-idp)
#   origin {
#     domain_name = "cognito-idp.ap-southeast-1.amazonaws.com"
#     origin_id   = "cognito-idp"

#     custom_origin_config {
#       http_port              = 80
#       https_port             = 443
#       origin_protocol_policy = "https-only"
#       origin_ssl_protocols   = ["TLSv1.2"]
#     }

#     custom_header {
#       name  = "X-Origin-Type"
#       value = "cognito-idp"
#     }
#   }

#   # Origin 2: Cognito Identity (cognito-identity)
#   origin {
#     domain_name = "cognito-identity.ap-southeast-1.amazonaws.com"
#     origin_id   = "cognito-identity"

#     custom_origin_config {
#       http_port              = 80
#       https_port             = 443
#       origin_protocol_policy = "https-only"
#       origin_ssl_protocols   = ["TLSv1.2"]
#     }

#     custom_header {
#       name  = "X-Origin-Type"
#       value = "cognito-identity"
#     }
#   }

#   # Behavior 1: Default (*) - cho cognito-idp
#   default_cache_behavior {
#     target_origin_id       = "cognito-idp"
#     viewer_protocol_policy = "redirect-to-https"

#     allowed_methods  = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
#     cached_methods   = ["GET", "HEAD"]
#     compress         = true
#     default_ttl      = 0
#     max_ttl          = 0
#     min_ttl          = 0

#     # Use CachingDisabled policy cho Cognito services
#     cache_policy_id = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"  # Managed-CachingDisabled
#   }

#   # Behavior 2: /identity - cho cognito-identity
#   ordered_cache_behavior {
#     path_pattern     = "/identity*"
#     target_origin_id = "cognito-identity"
#     viewer_protocol_policy = "redirect-to-https"

#     allowed_methods  = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
#     cached_methods   = ["GET", "HEAD", "OPTIONS"]
#     compress         = true
#     default_ttl      = 0
#     max_ttl          = 0
#     min_ttl          = 0

#     # Use CachingDisabled policy cho Cognito services
#     cache_policy_id = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"  # Managed-CachingDisabled
#   }

#   viewer_certificate {
#     cloudfront_default_certificate = true
#   }

#   restrictions {
#     geo_restriction {
#       restriction_type = "none"
#     }
#   }
# }

