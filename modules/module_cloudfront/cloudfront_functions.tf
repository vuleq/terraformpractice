# CloudFront Functions for FE and BE
# Replaces Lambda@Edge with CloudFront Functions for better performance and lower cost

locals {
  # CSP config for FE
  fe_csp_config_code = <<-CSP
  const CONFIG = {
    API_CLOUDFRONT_DOMAIN: '${var.csp_config.api_cloudfront_domain}',
    COGNITO_REGION: '${var.csp_config.cognito_region}',
    COGNITO_USER_POOL_ID: '${var.csp_config.cognito_user_pool_id}',
    S3_ASSETS_BUCKET: '${var.csp_config.s3_assets_bucket}',
    S3_REGION: '${var.csp_config.s3_region}',
    ADDITIONAL_CONNECT_SRC: '${var.csp_config.additional_connect_src}',
    ADDITIONAL_IMG_SRC: '${var.csp_config.additional_img_src}'
  };
CSP

  # FE Function: Based on lambda_templates/fe/index.mjs
  # Note: Cannot inject nonce or read S3 (CloudFront Functions limitation)
  fe_function_code = <<-FE_CODE
function handler(event) {
    var request = event.request;
    var response = event.response;
    var headers = response.headers;
    var objectKey = request.uri.substring(1) || 'index.html';

    // ADD CSP HEADERS FOR INDEX.HTML
    // Check: objectKey.endsWith('index.html') || request.uri === '/'
    var isIndexHtml = (objectKey.indexOf('index.html') === objectKey.length - 10) || request.uri === '/';
    
    if (isIndexHtml) {
        ${local.fe_csp_config_code}
        
        var connectSrcDomains = [
            'https://' + CONFIG.API_CLOUDFRONT_DOMAIN,
            'https://cognito-idp.' + CONFIG.COGNITO_REGION + '.amazonaws.com',
            'https://' + CONFIG.COGNITO_USER_POOL_ID + '.auth.' + CONFIG.COGNITO_REGION + '.amazoncognito.com',
            'https://cognito-identity.' + CONFIG.COGNITO_REGION + '.amazonaws.com',
            'https://' + CONFIG.S3_ASSETS_BUCKET + '.s3.' + CONFIG.S3_REGION + '.amazonaws.com',
            'https://*.googleapis.com',
            'wss://*.execute-api.' + CONFIG.S3_REGION + '.amazonaws.com',
            'http://localhost:*',
            'http://127.0.0.1:*'
        ];
        
        if (CONFIG.ADDITIONAL_CONNECT_SRC) {
            var additionalDomains = CONFIG.ADDITIONAL_CONNECT_SRC.split(',').map(function(d) {
                return d.trim();
            }).filter(function(d) {
                return d.length > 0;
            });
            connectSrcDomains = connectSrcDomains.concat(additionalDomains);
        }
        
        var imgSrcDomains = [
            'https://' + CONFIG.S3_ASSETS_BUCKET + '.s3.' + CONFIG.S3_REGION + '.amazonaws.com'
        ];
        
        if (CONFIG.ADDITIONAL_IMG_SRC) {
            var additionalImgDomains = CONFIG.ADDITIONAL_IMG_SRC.split(',').map(function(d) {
                return d.trim();
            }).filter(function(d) {
                return d.length > 0;
            });
            imgSrcDomains = imgSrcDomains.concat(additionalImgDomains);
        }
        
        // Note: Cannot use nonce in CloudFront Functions, using 'unsafe-inline' instead
        var cspValue = [
            "default-src 'none'",
            "script-src 'self' 'unsafe-inline'",
            "style-src 'self' 'unsafe-inline' https://fonts.googleapis.com",
            "object-src 'none'",
            "base-uri 'self'",
            "connect-src 'self' " + connectSrcDomains.join(' '),
            "img-src 'self' data: blob: " + imgSrcDomains.join(' '),
            "manifest-src 'self'",
            "font-src 'self' https://fonts.googleapis.com https://fonts.gstatic.com",
            "frame-ancestors 'none'",
            "form-action 'self'"
        ].join('; ');
        
        headers['content-security-policy'] = { value: cspValue };
        headers['cache-control'] = { value: 'no-cache, no-store, must-revalidate' };
    }
    
    return response;
}
FE_CODE

  # BE Function: CORS headers with origin validation
  be_function_code = <<-BE_CODE
function handler(event) {
    var request = event.request;
    var response = event.response;
    var headers = response.headers;

    // Configuration: Allowed Origins
    var ALLOWED_EXACT = [
        'https://d2o32ci9a5hhym.cloudfront.net',
        'https://wdr.paxocean.com',
        'https://dmwji128fkqvu.cloudfront.net',
        'http://localhost:4200',
        'http://localhost:8100',
        'http://localhost:8101',
        'http://localhost:*',
        'http://127.0.0.1:*',
        'https://prod-wdr-maritimeapps-deploy-lambda-fe-source6.s3.ap-southeast-1.amazonaws.com',
        'https://prod-wdr-maritimeapps-deploy-lambda-fe-source6.s3.amazonaws.com',
        'https://prod-wdr-maritimeapps-deploy-lambda-assets6.s3.ap-southeast-1.amazonaws.com',
        'https://prod-wdr-maritimeapps-deploy-lambda-assets6.s3.amazonaws.com',
        'http://prod-wdr-maritimeapps-deploy-lambda-fe-source6.s3-website-ap-southeast-1.amazonaws.com',
        'http://prod-wdr-maritimeapps-deploy-lambda-assets6.s3-website-ap-southeast-1.amazonaws.com'
    ];

    // Get the request origin
    var requestOrigin = (request.headers.origin) ? request.headers.origin.value : undefined;

    // Helper to validate origin
    function isOriginAllowed(origin) {
        if (!origin) return false;

        // 1. Check exact matches
        if (ALLOWED_EXACT.indexOf(origin) !== -1) {
            return true;
        }

        // 2. Check Wildcards (Manual Regex for performance in CFF)
        
        // Check localhost with any port: http://localhost:*
        // Regex: ^http:\/\/localhost:\d+$
        if (/^http:\/\/localhost:\d+$/.test(origin)) {
            return true;
        }
        
        // Check local IP with any port: http://127.0.0.1:*
        if (/^http:\/\/127\.0\.0\.1:\d+$/.test(origin)) {
            return true;
        }

        // Check generic subdomains: https://*.dc17-products.com.vn
        // Regex: ^https:\/\/.*\.dc17-products\.com\.vn$
        // Note: Using a stricter check to avoid security risks (e.g., evil-dc17-products...)
        if (/^https:\/\/([a-zA-Z0-9-]+\.)?dc17-products\.com\.vn$/.test(origin)) {
            return true;
        }

        return false;
    }

    // Apply Headers if Allowed
    if (requestOrigin && isOriginAllowed(requestOrigin)) {
        headers['access-control-allow-origin'] = { value: requestOrigin };
        headers['vary'] = { value: 'Origin' };
        headers['access-control-allow-methods'] = { value: 'GET, HEAD, OPTIONS, POST, PUT, DELETE, PATCH' };
        headers['access-control-allow-headers'] = { value: 'Content-Type,Authorization' };
        headers['access-control-allow-credentials'] = { value: 'true' };
    }

    return response;
}
BE_CODE
}

# FE Function - COMMENT LẠI vì chỉ dùng BE function
# resource "aws_cloudfront_function" "fe_function" {
#   name    = "prod-wdr-cloudfront-function-FE"
#   runtime = "cloudfront-js-2.0"
#   comment = "CloudFront Function for FE - CSP headers only (based on lambda_templates/fe/index.mjs)"
#   code    = local.fe_function_code
#   publish = true
# }

resource "aws_cloudfront_function" "be_function" {
  name    = "prod-wdr-cloudfront-function-BE"
  runtime = "cloudfront-js-2.0"
  comment = "CloudFront Function for BE - CORS headers"
  code    = local.be_function_code
  publish = true
}

