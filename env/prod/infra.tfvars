region       = "us-east-2"
owner        = "Vule"
application  = "Vuletest"
environment  = "PROD"
project_name = "PROD-Vule-Vuletest"
account_id   = "797233058645" #change account id of customer

# ========================================
# DUMMY LAMBDA CODE (for infra-only Lambda creation)
# ========================================
# Upload to S3: aws s3 cp lambda-placeholder.zip s3://prod-wdr-maritimeapps-deploy-store-lambdasources/dummy/lambda-placeholder.zip
dummy_lambda_code_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
dummy_lambda_code_key    = "placeholder-files/lambda-placeholder.zip"



#LAMBDA FUNCTIONS
lambda_definitions = {
  lambda_1 = {
    function_name = "prod-wdr-maritimeapps-deploy-ld-job-get-all-supervisors"
    runtime       = "nodejs22.x"
    handler       = "index.handler"
    timeout       = 60
    memory_size   = 128
    env_vars = {
      STAGE = "prod"
      JWT_SECRET = "wdr-default-secret-key"
    }
    # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
    # s3_key = "prod/release2.0/09222025/wdr-job-get-all-supervisors.zip"
    layers = ["connect_db_v35", "models_v35","common_utils", "error_codes_v35", "AWS-Parameters-and-Secrets-Lambda-Extension"]
  },
  lambda_2 = {
    function_name = "prod-wdr-maritimeapps-deploy-ld-job-get-all-trade-sections"
    runtime       = "nodejs22.x"
    handler       = "index.handler"
    timeout       = 60
    memory_size   = 128
    env_vars = {
      STAGE = "prod"
      BUCKET_NAME = "prod-wdr-maritimeapps-deploy-stores-lambdasources"
      
    }
    # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
    # s3_key = "prod/release1.0/07222025/job-get-all-trade-sections.zip"
    layers = ["connect_db_v35", "models_v35", "AWS-Parameters-and-Secrets-Lambda-Extension"]
  }
}

#  lambda_3 = {
#     function_name = "prod-wdr-maritimeapps-deploy-ld-project-get-dashboard-data"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
# 
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-project-get-dashboard-data.zip"
#     layers = ["connect_db_v35", "models_v35","common_utils", "error_codes_v35", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_4 = {
#     function_name = "prod-wdr-maritimeapps-deploy-ld-pro-get-history-by-pro-id"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/09222025/wdr-project-get-history.zip"
#     layers = ["connect_db_v35", "models_v35","common_utils", "error_codes_v35", "AWS-Parameters-and-Secrets-Lambda-Extension"] #khong co code update code trong uat-2.0.1
#   },
#   lambda_5 = {
#     function_name = "prod-wdr-mapps-sync-job"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       JWT_SECRET = "wdr-default-secret-key"
#       LOG_LEVEL = "debug"
#       NODE_OPTIONS = "--enable-source-maps"
# 
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release1.0/07222025/project-change-status.zip"
#     layers = ["connect_db_v35", "common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"] 
#   },
#   lambda_6 = {
#     function_name = "prod-wdr-maritimeapps-deploy-ld-report-search-report"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 65
#     memory_size   = 1024
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-report-search-report.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"] 
#   },
#   lambda_7 = {
#     function_name = "prod-wdr-maritimeapps-deploy-ld-trade-section-create"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-trade-section-create.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"] 
#   },
#   lambda_8 = {
#     function_name = "prod-wdr-maritimeapps-deploy-ld-trade-section-delete-by-id"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-trade-section-delete-by-id.zip"
#     layers = ["connect_db_v35", "models_v35","common_utils", "error_codes_v35", "AWS-Parameters-and-Secrets-Lambda-Extension"] 
#   },
#   lambda_9 = {
#     function_name = "prod-wdr-maritimeapps-deploy-ld-trade-section-get-all"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-trade-section-get-all.zip"
#     layers = ["connect_db_v35", "models_v35","common_utils", "error_codes_v35", "AWS-Parameters-and-Secrets-Lambda-Extension"] 
#   },
#   lambda_10 = {
#     function_name = "prod-wdr-maritimeapps-deploy-ld-trade-section-get-by-id"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-trade-section-get-by-id.zip"
#     layers = ["connect_db_v35", "models_v35","common_utils", "error_codes_v35", "AWS-Parameters-and-Secrets-Lambda-Extension"] 
#   },
#   lambda_11 = {
#     function_name = "prod-wdr-maritimeapps-deploy-ld-trade-section-search-by-params"
#     runtime     = "nodejs22.x"
#     handler     = "index.handler"
#     timeout     = 60
#     memory_size = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-trade-section-search.zip"
#     layers = ["connect_db_v35", "models_v35","common_utils", "error_codes_v35", "AWS-Parameters-and-Secrets-Lambda-Extension"] 
#   },
#   lambda_12 = {
#     function_name = "prod-wdr-maritimeapps-deploy-ld-trade-section-update-by-id"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-trade-section-update-by-id.zip"
#     layers = ["connect_db_v35", "models_v35","common_utils", "error_codes_v35", "AWS-Parameters-and-Secrets-Lambda-Extension"] 
#   },
#   lambda_13 = {
#     function_name = "prod-wdr-maritimeapps-deploy-ld-get-project-temp"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/09222025/wdr-get-project-temp.zip"
#     layers = ["connect_db_v35", "models_v35","common_utils", "error_codes_v35", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
#   
#   lambda_14 = {
#     function_name = "prod-wdr-maritimeapps-deploy-ld-user-get-user-by-id"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-users-get-by-id.zip"
#     layers = ["connect_db_v35", "models_v35","common_utils", "error_codes_v35", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_15 = {
#     function_name = "prod-wdr-maritimeapps-deploy-ld-user-search-users-by-param"
#     runtime     = "nodejs22.x"
#     handler     = "index.handler"
#     timeout     = 60
#     memory_size = 128
#     env_vars = {
#       STAGE = "prod"
# 
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-user-search.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"] 
#   },
#   lambda_16 = {
#     function_name = "prod-wdr-maritimeapps-deploy-ld-project-get-all"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-project-get-all.zip"
#     layers = ["connect_db_v35", "models_v35","common_utils", "error_codes_v35", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_17 = {
#     function_name = "prod-wdr-maritimeapps-deploy-ld-project-get-by-id"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-project-get-by-id.zip"
#     layers = ["connect_db_v35", "models_v35","common_utils", "error_codes_v35", "AWS-Parameters-and-Secrets-Lambda-Extension"] 
#   },
#   lambda_18 = {
#     function_name = "prod-wdr-maritimeapps-deploy-ld-project-update-by-id"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-project-update-by-id.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"] 
#   },
#   lambda_19 = {
#     function_name = "prod-wdr-maritimeapps-deploy-ld-project-get-all-srm-user"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-project-get-all-srm-user.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"] 
#   },
#   lambda_20 = {
#     function_name = "prod-wdr-maritimeapps-deploy-ld-job-get-all"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wbs-job-get-all.zip"
#     layers = ["connect_db_v35", "models_v35", "error_codes_v35", "common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"] 
#   },
#   lambda_21 = {
#     function_name = "prod-wdr-maritimeapps-deploy-ld-job-create"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 300
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#       # BUCKET_CREATE_FOLDER_FUNCTION_NAME = "prod-wdr-maritimeapps-depl-ld-bucket-create-folder"
#       DESTINATION_BUCKET = "prod-wdr-maritimeapps-deploy-lambda-assets6"
#       NODE_OPTIONS = "--enable-source-maps"
# 
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-job-create.zip"
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35", "common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"] 
#   },
#   lambda_22 = {
#     function_name = "prod-wdr-maritimeapps-deploy-ld-job-get-by-id"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-job-get-by-id.zip"
#     layers = ["connect_db_v35", "models_v35","common_utils", "error_codes_v35", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_23 = {
#     function_name = "prod-wdr-maritimeapps-deploy-ld-job-update-by-id"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#       NODE_OPTIONS = "--enable-source-maps"
# 
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-job-update-by-id.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_24 = {
#     function_name = "prod-wdr-maritimeapps-deploy-ld-job-search-by-params"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-job-search-by-params.zip"
#     layers = ["connect_db_v35", "models_v35", "error_codes_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_25 = {
#     function_name = "prod-wdr-maritimeapps-deploy-ld-project-search-by-param"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#      
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-project-search-by-parameters.zip"
#     layers = ["connect_db_v35", "models_v35", "error_codes_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_26 = {
#     function_name = "prod-wdr-maritimeapps-deploy-ld-project-create"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 300
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#       # BUCKET_CREATE_FOLDER_FUNCTION_NAME = "prod-wdr-maritimeapps-depl-ld-bucket-create-folder"
#       DESTINATION_BUCKET = "prod-wdr-maritimeapps-deploy-lambda-assets6"
#       SAP_SECRET_NAME = "arn:aws:secretsmanager:us-east-2:797233058645:secret:prod-wdr-secretmanager-SAP-rxY8IX"
#       SAP_LINK = "/RESTAdapter/WDR/"
#       SAP_WBS = "GetWbs"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-project-create.zip"
#     layers = ["models_v35", "connect_db_v35", "common_utils", "connect_external", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_27 = {
#     function_name = "prod-wdr-maritimeapps-deploy-ld-project-get-all-status"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-project-get-all-status.zip"
#     layers = ["connect_db_v35", "models_v35","common_utils", "error_codes_v35", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_28 = {
#     function_name = "prod-wdr-maritimeapps-deploy-ld-project-sync-from-SAP"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 300
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#       SAP_LINK = "/RESTAdapter/WDR/"
#       SAP_PROJECT = "GetProject"
#       SAP_WBS = "GetWbs"
#       SAP_SECRET_NAME = "arn:aws:secretsmanager:us-east-2:797233058645:secret:prod-wdr-secretmanager-SAP-rxY8IX"
#      
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-project-sync-from-sap.zip"
#     layers = ["models_v35", "connect_db_v35", "common_utils", "connect_external", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_29 = {
#     function_name = "prod-wdr-maritimeapps-deploy-ld-report-delete-report-by-id"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-report-delete-by-id.zip"
#     layers = ["connect_db_v35", "models_v35","common_utils", "error_codes_v35", "AWS-Parameters-and-Secrets-Lambda-Extension"] 
#   },
#   lambda_30 = {
#     function_name = "prod-wdr-maritimeapps-deploy-ld-report-get-report-by-id"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-report-get-by-id.zip"
#     layers = ["connect_db_v35", "models_v35","common_utils", "error_codes_v35", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_31 = {
#     function_name = "prod-wdr-maritimeapps-deploy-ld-global-settings-update-by-id"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-global-settings-update-by-id.zip"
#     layers = ["connect_db_v35", "models_v35", "error_codes_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_32 = {
#     function_name = "prod-wdr-maritimeapps-deploy-ld-report-update-report-by-id"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-report-update.zip"
#     layers = ["connect_db_v35", "models_v35", "common_utils", "error_codes_v35", "AWS-Parameters-and-Secrets-Lambda-Extension"] 
#   },
#   lambda_33 = {
#     function_name = "prod-wdr-maritimeapps-deploy-ld-report-lock-by-id"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       JWT_SECRET = "wdr-default-secret-key"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-report-lock-by-id.zip"
#     layers = ["connect_db_v35", "models_v35", "common_utils", "error_codes_v35", "AWS-Parameters-and-Secrets-Lambda-Extension"] 
#   },
#   lambda_34 = {
#     function_name = "prod-wdr-maritimeapps-deploy-ld-report-refresh-lock-by-id"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-report-refresh-lock-by-id.zip"
#     layers = ["connect_db_v35", "models_v35", "common_utils", "error_codes_v35", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
#   lambda_35 = {
#     function_name = "prod-wdr-maritimeapps-deploy-ld-report-unlock-by-id"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-report-unlock-by-id.zip"
#     layers = ["connect_db_v35", "models_v35", "common_utils", "error_codes_v35", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
#   lambda_36 = {
#     function_name = "prod-wdr-maritimeapps-deploy-ld-report-count-report"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-report-count-report.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_37 = {
#     function_name = "prod-wdr-maritimeapps-deploy-ld-report-search-report-paging"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-report-search-paging.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_38 = {
#     function_name = "prod-wdr-maritimeapps-deploy-ld-global-settings-get-all"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-global-settings-get-all.zip"
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_39 = {
#     function_name = "prod-wdr-maritimeapps-deploy-ld-report-create-report-template"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-report-create-report-template.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_40 = {
#     function_name = "prod-wdr-maritimeapps-deploy-ld-role-search"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-role-search.zip"
#       layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_41 = {
#     function_name = "prod-wdr-maritimeapps-deploy-ld-sub-code-get-all-by-project"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-sub-code-get-all.zip"
#     layers = ["connect_db_v35", "models_v35","common_utils", "error_codes_v35", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_42 = {
#     function_name = "prod-wdr-maritimeapps-deploy-ld-job-get-all-status"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#      
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-job-get-all-status.zip"
#     layers = ["connect_db_v35", "models_v35","common_utils", "error_codes_v35", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_43 = {
#     function_name = "prod-wdr-maritimeapps-deploy-ld-sub-code-create"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 300
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#       SAP_LINK = "/RESTAdapter/WDR/"
#       SAP_CREATE_WBS_ACTIVITY = "CreateActivity"
#       SAP_CREATE_WBS = "CreateWbs"
#       SAP_SECRET_NAME = "arn:aws:secretsmanager:us-east-2:797233058645:secret:prod-wdr-secretmanager-SAP-rxY8IX"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-sub-code-create.zip"
#     layers = ["models_v35", "connect_db_v35", "common_utils", "connect_external", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_44 = {
#     function_name = "prod-wdr-maritimeapps-deploy-ld-sub-code-get-id"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-sub-code-get-id.zip"
#     layers = ["connect_db_v35", "models_v35","common_utils", "error_codes_v35", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_45 = {
#     function_name = "prod-wdr-maritimeapps-deploy-ld-sub-code-search-by-params"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-sub-code-search-by-params.zip"
#     layers = ["connect_db_v35", "models_v35", "error_codes_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_46 = {
#     function_name = "prod-wdr-maritimeapps-deploy-ld-user-find-by-role"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-user-find-by-role.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },  
#   lambda_47 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-global-settings-get-all-by-group"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-global-settings-get-all-by-group.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_48 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-report-create-new-report"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-report-create-new-report.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_49 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-pre-defined-get-all"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-pre-defined-get-all.zip"
#     layers = ["connect_db_v35", "models_v35", "common_utils", "error_codes_v35", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_50 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-pre-defined-create"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-pre-defined-create.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_51 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-pre-defined-delete-by-id"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-pre-defined-delete-by-id.zip"
#     layers = ["connect_db_v35", "models_v35","common_utils", "error_codes_v35", "AWS-Parameters-and-Secrets-Lambda-Extension"] 
#   },
#   lambda_52 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-pre-defined-get-by-id"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-pre-defined-get-by-id.zip"
#     layers = ["connect_db_v35", "models_v35","common_utils", "error_codes_v35", "AWS-Parameters-and-Secrets-Lambda-Extension"] 
#   },
#   lambda_53 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-pre-defined-update-by-id"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-pre-defined-update-by-id.zip"
#     layers = ["connect_db_v35", "models_v35","common_utils", "error_codes_v35", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_54 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-pre-defined-search-by-params"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-pre-defined-search-by-params.zip"
#     layers = ["connect_db_v35", "models_v35", "error_codes_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_55 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-content-xml-to-pdf"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-content-xml-to-pdf.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35", "pdf_utils_layer","AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_56 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-bucket-create-thumbnail"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#       DESTINATION_BUCKET = "prod-wdr-maritimeapps-deploy-lambda-assets6"
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-bucket-create-thumbnail.zip"
#     layers = ["connect_db_v35", "sharp","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_57 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-project-add-quotation"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#       DESTINATION_BUCKET = "prod-wdr-maritimeapps-deploy-lambda-assets6"
#       NODE_OPTIONS = "--enable-source-maps"
#       JWT_SECRET = "wdr-default-secret-key"
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-project-add-quotation.zip"
#     layers = ["connect_db_v35", "exceljs","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"] 
#   },
#   lambda_58 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-deploy-database"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#       BUCKET_NAME = "prod-wdr-maritimeapps-deploy-store-lambdasources"      
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/09222025/wdr-deploy-database.zip"
#     layers = ["connect_db_v35", "csv_parse", "models_v35", "common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
#   # lambda_59 = {
#   #   function_name = "prod-wdr-maritimeapps-depl-ld-bucket-create-folder"
#   #   runtime       = "nodejs22.x"
#   #   handler       = "index.handler"
#   #   timeout       = 60
#   #   memory_size   = 128
#   #   env_vars = {
#   #     STAGE = "prod"
#       
#   #     DESTINATION_BUCKET = "prod-wdr-maritimeapps-deploy-lambda-assets6"
#   #   }
#   #   # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#   #   # s3_key = "prod/release2.0/10282025/wdr-bucket-create-folder.zip"
#   #   layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   # },
#   lambda_60 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-count-rpt-by-range-date"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-count-report-by-range-date.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_61 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-prelogin-trigger"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       SERVICE_APP_CLIENT_ID = "7k0eaar0v1jom2llqjuhbf3f5g"
#      
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release1.0/09172025/prelogin-trigger.zip"
#     layers = ["connect_db_v35","common_utils","error_codes_v35","models_v35", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
#   lambda_62 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-update-database-schema"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 300
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#       S3_BUCKET = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/09222025/wdr-update-database-schema.zip"
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
#   lambda_63 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-view-database-schema"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/09222025/wdr-view-database-schema.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
#   lambda_64 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-user-login-history-get-all"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-user-login-log-get-all.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_65 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-dynamic-wf-report-get"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 300
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod" 
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-dynamic-wf-report-get.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_66 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-dynamic-values-create"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#       DB_SSL = "false"
#       NODE_OPTIONS = "--enable-source-maps"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-dynamic-values-create.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_67 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-dynamic-values-get-by-id"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#       DB_SSL = "false"
#       NODE_OPTIONS = "--enable-source-maps"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-dynamic-values-get-by-id.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_68 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-dynamic-values-search"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#       DB_SSL = "false"
#       NODE_OPTIONS = "--enable-source-maps"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-dynamic-values-search.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_69 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-get-all-errors-log"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#       DB_SSL = "false"
#       NODE_OPTIONS = "--enable-source-maps"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-get-all-errors-log.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_70 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-pro-getasgnusr-bytrdsec"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#       DB_SSL = "false"
#       NODE_OPTIONS = "--enable-source-maps"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-project-get-assign-user-by-trade-section.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_71 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-report-get-by-id"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#       DB_SSL = "false"
#       NODE_OPTIONS = "--enable-source-maps"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-report-get-by-id.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_72 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-trd-sec-get-assign-usr"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#       DB_SSL = "false"
#       NODE_OPTIONS = "--enable-source-maps"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-trade-section-get-assign-user.zip"
#      layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]    
#   },
#   lambda_73 = {
#     function_name = "prod-wdr-maritimeapps-deploy-databasenew"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#       BUCKET_NAME = "prod-wdr-maritimeapps-deploy-store-lambdasources"      
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/09222025/wdr-deploy-database.zip"
#     layers = ["connect_db_v35", "csv_parse", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  #khong co code update code trong uat-2.0.1
#   },
#   lambda_74 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-app-settings-get-all"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-app-settings-get-all.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
#   lambda_75 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-app-settings-delete-by-id"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-app-settings-delete-by-id.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
#   lambda_76 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-app-settings-update-by-id"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#       COGNITO_USER_POOL_ID = "us-east-2_8h0ZVkQbm"
#       COGNITO_WEB_CLIENT_ID = "1kre7uqpl7vad739btuaftf9b4"
#       COGNITO_MOBILE_CLIENT_ID = "9443b004rov63tt1fvj6s1v8a"
#       DORMANT_USER_SCHEDULE_NAME = "prod-wdr-maritimeapps-lock-dormant-users-scheduler"
#       TARGET_DORMANT_USER_FUNCTION_ARN = "arn:aws:lambda:us-east-2:797233058645:function:prod-wdr-mapps-lock-dormant-users"
#       REPORT_NOTIFICATION_SCHEDULE_NAME = "prod-wdr-mapps-report-update-silent-noti-scheduler"
#       TARGET_REPORT_NOTIFICATION_FUNCTION_ARN = "arn:aws:lambda:us-east-2:797233058645:function:prod-wdr-mapps-report-update-silent-notification"
#       PROJECT_SCHEDULE_NAME = "prod-wdr-maritimeapps-project-daily-fetch-scheduler"
#       TARGET_PROJECT_FUNCTION_ARN = "arn:aws:lambda:us-east-2:797233058645:function:prod-wdr-maritimeapps-depl-ld-project-daily-fetch"
#       SCHEDULE_GROUP_NAME = "prod-wdr-maritimeapps-schedulers"
#       SCHEDULE_ROLE_ARN = "arn:aws:iam::797233058645:role/prod_wdr_maritimeapps_deploy_app_lambda"
#       ENTITY_CHANGE_LOG_NOTIFICATION_SCHEDULE_NAME = "prod-wdr-maritimeapps-changes-silent-noti-schedule"
#       TARGET_ENTITY_CHANGE_LOG_NOTIFICATION_FUNCTION_ARN= "arn:aws:lambda:us-east-2:797233058645:prod-wdr-maritimeapps-changes-silent-noti-schedule"
#       COGNITO_API_CLIENT_ID ="7k0eaar0v1jom2llqjuhbf3f5g"
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-app-settings-update-by-id.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
#   lambda_77 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-app-settings-get-by-code"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-app-settings-get-by-code.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_78 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-glb-set-pro-sche-update"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#       SCHEDULE_NAME ="prod-wdr-maritimeapps-project-daily-fetch-schedule"
#       SCHEDULE_ROLE_ARN = "arn:aws:iam::797233058645:role/wdr-lambda-function-role"
#       TARGET_FUNCTION_ARN = "arn:aws:lambda:us-east-2:797233058645:function:prod-wdr-maritimeapps-depl-ld-project-daily-fetch"
#       # SAP_SECRET_NAME = "arn:aws:secretsmanager:us-east-2:797233058645:secret:prod-wdr-secretmanager-SAP-rxY8IX"
# 
#     }
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35", "common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_79 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-project-daily-fetch"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 300
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#       SAP_LINK = "/RESTAdapter/WDR/"
#       SAP_PROJECT = "GetProject"
#       SAP_SECRET_NAME = "arn:aws:secretsmanager:us-east-2:797233058645:secret:prod-wdr-secretmanager-SAP-rxY8IX"
#       SAP_USER_NAME = "wdr.service"
#       SAP_PASSWORD = "xYTfQAAW5S+hHCK"
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-project-daily-fetch.zip"
#     layers = ["connect_db_v35", "connect_external","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_80 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-job-change-status"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#       REPORT_CREATE_FUNCTION_NAME = "prod-wdr-maritimeapps-depl-ld-report-create-new-report"
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-job-change-status.zip"
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35", "common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_81 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-job-attachment-delete"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-job-attachment-delete.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_82 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-job-attachment-upload"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-job-attachment-upload.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_83 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-job-delete"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       DESTINATION_BUCKET = "prod-wdr-maritimeapps-deploy-lambda-assets6"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-job-delete.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
#   lambda_84 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-job-export-excel"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 300
#     memory_size   = 1536
#     env_vars = {
#       STAGE = "prod"
#       
#       FILE_KEY = "masterdata/template_worklist.xlsx"
#       EXPORT_BUCKET = "prod-wdr-maritimeapps-deploy-lambda-assets6"
#       JOB_SEARCH_FUNCTION_NAME = "prod-wdr-maritimeapps-deploy-ld-job-search-by-params"
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-job-export-excel.zip"
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_85 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-job-attachment-getall-byid"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#       # BUCKET_CREATE_FOLDER_FUNCTION_NAME ="prod-wdr-maritimeapps-depl-ld-bucket-create-folder"     
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-job-attachment-get-all-by-id.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_86 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-job-photo-getall-byid"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-job-photo-get-all-by-id.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_87 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-job-merge"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#       # BUCKET_CREATE_FOLDER_FUNCTION_NAME = "prod-wdr-maritimeapps-depl-ld-bucket-create-folder"
#       # BUCKET_DELETE_FOLDER_FUNCTION_NAME = "prod-wdr-maritimeapps-depl-ld-bucket-delete-folder"
#       DESTINATION_BUCKET = "prod-wdr-maritimeapps-deploy-lambda-assets6"
#       DB_SSL = "false"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-job-merge.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_88 = {
#     function_name = "prod-wdr-mapps-sync-report"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#       LOG_LEVEL = "ERROR"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release1.0/07222025/project-change-status.zip"
#     layers = ["connect_db_v35", "common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"] 
#   },
#   lambda_89 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-job-photo-delete"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-job-photo-delete.zip"
#       layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#     },
#   lambda_90 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-job-update-multi"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-job-update-multi.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_91 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-permission-get-all"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-permission-get-all.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_92 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-dynamic-values-get-values"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-dynamic-values-get-values.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_93 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-project-assign-user"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-project-assign-user.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_94 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-role-create"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-role-create.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_95 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-sub-code-sync"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 300
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#       SAP_LINK = "/RESTAdapter/WDR/"
#       SAP_WBS = "GetWbs"
#       SAP_SECRET_NAME = "arn:aws:secretsmanager:us-east-2:797233058645:secret:prod-wdr-secretmanager-SAP-rxY8IX"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-sub-code-sync.zip"
#     layers = ["models_v35", "connect_db_v35", "common_utils", "connect_external", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_96 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-project-update-feedback"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-project-update-feedback.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_97 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-get-list-report-combine"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-get-list-report-combine.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"] 
#   },
#   lambda_98 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-role-delete"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-role-delete.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_99 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-role-get-by-id"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-role-get-by-id.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_100 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-role-update"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-role-update.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_101 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-users-get-all"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#             
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-users-get-all.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_102 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-create-users-dev"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#       COGNITO_USER_POOL_ID = "us-east-2_8h0ZVkQbm"
#       DEFAULT_PASSWORD = "12345678x@X"
#       AZURE_CLIENT_ID = "c2dcb06b-f92b-4947-ac78-543702397aad"
#       AZURE_CLIENT_SECRET	 = "YOUR_AZURE_CLIENT_SECRET_HERE"
#       AZURE_GROUP_ID = "af86df0a-1aa7-4266-a72c-3a94d43d7964"
#       AZURE_TENANT_ID = "afd79c27-0409-470b-9f2f-daf6122000c3"
#       PROVIDER_NAME = "Azure"
#       USE_WORKATO = false
#       WORKATO_SECRET_NAME = "arn:aws:secretsmanager:us-east-2:797233058645:secret:prod-wdr-secretmanager-workato-0p0fG9"
#       WORKATO_TOKEN_LINK = "/oauth2/token"
#       WORKATO_ADD_LINK = "/aadgrp-v1/wdr"
#       # WORKATO_CLIENT_ID = "a64c7dd9316c9a59fbd94a4beca4fb42bc1190de1cef6af1a5a92db0ae98fdd7"
#       # WORKATO_CLIENT_SECRET = "18f22ca771284ef393134401c5473fd90d47cb3b6a54da86d8f6e83effdf4b48"
#       SES_SOURCE_EMAIL = "noreply@dngioi.website"
#       SERVICE_USER_EMAIL_DOMAIN = "wdr.serviceacc.com"
# 
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-create-users.zip"
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35", "common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_103 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-update-users-dev"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#       COGNITO_USER_POOL_ID = "us-east-2_8h0ZVkQbm"
#       AZURE_CLIENT_ID = "c2dcb06b-f92b-4947-ac78-543702397aad"
#       AZURE_CLIENT_SECRET	 = "YOUR_AZURE_CLIENT_SECRET_HERE"
#       AZURE_GROUP_ID = "af86df0a-1aa7-4266-a72c-3a94d43d7964"
#       AZURE_TENANT_ID = "afd79c27-0409-470b-9f2f-daf6122000c3"
#       PROVIDER_NAME = "Azure"
#       USE_WORKATO = false
#       WORKATO_SECRET_NAME = "arn:aws:secretsmanager:us-east-2:797233058645:secret:prod-wdr-secretmanager-workato-0p0fG9"
#       WORKATO_TOKEN_LINK = "/oauth2/token"
#       WORKATO_ADD_LINK = "/aadgrp-v1/wdr"
#       # WORKATO_CLIENT_ID = "a64c7dd9316c9a59fbd94a4beca4fb42bc1190de1cef6af1a5a92db0ae98fdd7"
#       # WORKATO_CLIENT_SECRET = "18f22ca771284ef393134401c5473fd90d47cb3b6a54da86d8f6e83effdf4b48"
#       SES_SOURCE_EMAIL = "noreply@dngioi.website"
#       SERVICE_USER_EMAIL_DOMAIN = "wdr.serviceacc.com"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-update-users.zip"
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35", "common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_104 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-toggle-user-status-dev"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#       COGNITO_USER_POOL_ID = "us-east-2_8h0ZVkQbm"
#       SES_SOURCE_EMAIL = "noreply@dngioi.website"
#       AZURE_CLIENT_ID = "c2dcb06b-f92b-4947-ac78-543702397aad"
#       AZURE_CLIENT_SECRET	 = "YOUR_AZURE_CLIENT_SECRET_HERE"
#       AZURE_GROUP_ID = "af86df0a-1aa7-4266-a72c-3a94d43d7964"
#       AZURE_TENANT_ID = "afd79c27-0409-470b-9f2f-daf6122000c3"
#       PROVIDER_NAME = "Azure"
#       USE_WORKATO = false
#       WORKATO_SECRET_NAME = "arn:aws:secretsmanager:us-east-2:797233058645:secret:prod-wdr-secretmanager-workato-0p0fG9"
#       WORKATO_TOKEN_LINK = "/oauth2/token"
#       WORKATO_ADD_LINK = "/aadgrp-v1/wdr"
#       SERVICE_USER_EMAIL_DOMAIN = "wdr.serviceacc.com"
#       # WORKATO_CLIENT_ID = "a64c7dd9316c9a59fbd94a4beca4fb42bc1190de1cef6af1a5a92db0ae98fdd7"
#       # WORKATO_CLIENT_SECRET = "18f22ca771284ef393134401c5473fd90d47cb3b6a54da86d8f6e83effdf4b48"
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-toggle-user-status.zip"
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35", "common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"] 
#   },
#   lambda_105 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-job-attach-check-and-process"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 300
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#       DESTINATION_BUCKET = "prod-wdr-maritimeapps-deploy-lambda-assets6"
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-job-attachment-check-and-proccess.zip"
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35", "common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#    lambda_106 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-job-photo-check-n-process"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 300
#     memory_size   = 2048
#     env_vars = {
#       STAGE = "prod"
#       
#       DESTINATION_BUCKET = "prod-wdr-maritimeapps-deploy-lambda-assets6"
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-job-photo-check-and-proccess.zip"
#     layers = ["models_v35", "connect_db_v35", "common_utils", "sharp", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_107 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-role-get-all"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-role-get-all.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_108 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-change-user-type-login"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-user-change-login-type.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_109 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-user-get-my-role-dev"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-users-get-my-role.zip"
#     layers = ["connect_db_v35", "error_codes_v35", "models_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   # lambda_110 = {
#   #   function_name = "prod-wdr-maritimeapps-depl-ld-bucket-delete-folder"
#   #   runtime       = "nodejs22.x"
#   #   handler       = "index.handler"
#   #   timeout       = 60
#   #   memory_size   = 128
#   #   env_vars = {
#   #     STAGE = "prod"
#       
#   #     DESTINATION_BUCKET = "prod-wdr-maritimeapps-deploy-lambda-assets6"
#   #   }
#   #   # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#   #   # s3_key = "prod/release2.0/10282025/wdr-bucket-delete-folder.zip"
#   #   layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   # },
#   lambda_111 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-get-step-wf-history"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-get-step-wf-history.zip"
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   
#   lambda_112 = {
#     function_name = "prod-wdr-mapps-get-all-old-version-report"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#   }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/09222025/wdr-get-all-old-version-report.zip"
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_113 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-approve-step-wf-history"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-approve-step-wf-history.zip"
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_114 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-get-next-approver"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-get-next-approver.zip"
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_115 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-reject-step-wf-history"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-reject-step-wf-history.zip"
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   
#   lambda_116 = {
#     function_name = "prod-wdr-mapps-reopen-complete-report"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/09222025/wdr-reopen-complete-report.zip"
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   
#   lambda_117 = {
#     function_name = "prod-wdr-mapps-get-replace-processing-approver"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/09222025/wdr-get-replace-processing-approver.zip"
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   
#   lambda_118 = {
#     function_name = "prod-wdr-mapps-replace-processing-approver"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/09222025/wdr-replace-processing-approver.zip"
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_119 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-submit-review-report"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-submit-review-report.zip"
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_120 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-dynamic-wf-report-update"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-dynamic-wf-report-update.zip"
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   
#   lambda_121 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-job-update-multi-jobs-data"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-job-update-multi-jobs-data.zip"
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   
#   lambda_122 = {
#     function_name = "prod-wdr-mapps-notification-get-all"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-notification-get-all.zip"
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   
#   lambda_123 = {
#     function_name = "prod-wdr-mapps-notification-get-unread-count"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-notification-get-unread-count.zip"
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   
#   lambda_124 = {
#     function_name = "prod-wdr-mapps-notification-mark-read"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/09222025/wdr-notification-mark-read.zip"
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   
#   lambda_125 = {
#     function_name = "prod-wdr-mapps-notification-mark-read-all"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#       # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#       # s3_key = "prod/release2.0/09222025/wdr-notification-mark-read-all.zip"
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   
#   lambda_126 = {
#     function_name = "prod-wdr-mapps-notification-delete"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/09222025/wdr-notification-delete.zip"
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   
#   lambda_127 = {
#     function_name = "prod-wdr-mapps-notification-register-device"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/09222025/wdr-notification-register-device.zip"
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   
#   lambda_128 = {
#     function_name = "prod-wdr-mapps-notification-unregister-device"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/09222025/wdr-notification-unregister-device.zip"
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   
#   lambda_129 = {
#     function_name = "prod-wdr-mapps-notification-send"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/09222025/wdr-notification-send.zip"
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   
#   lambda_130 = {
#     function_name = "prod-wdr-mapps-notification-processor"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#       FIREBASE_SERVICE_ACCOUNT = "arn:aws:secretsmanager:us-east-2:797233058645:secret:prod-wdr-maritimeapps-firebase-service-account-4qbequ"
#       SES_SOURCE_EMAIL = "noreply@dngioi.website"
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/09222025/wdr-notification-processor.zip"
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   
#   lambda_131 = {
#     function_name = "prod-wdr-mapps-notification-silent-processor"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#       FIREBASE_SERVICE_ACCOUNT = "arn:aws:secretsmanager:us-east-2:797233058645:secret:prod-wdr-maritimeapps-firebase-service-account-4qbequ"
#     }
#     
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   
#   lambda_132 = {
#     function_name = "prod-wdr-mapps-notification-settings-get"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#     
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   
#   lambda_133 = {
#     function_name = "prod-wdr-mapps-notification-settings-update"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#     
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   
#   lambda_134 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-revoke-token"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-revoke-token.zip"
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   
#   lambda_135 = {
#     function_name = "prod-wdr-mapps-notification-template-get-all"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/09222025/wdr-notification-template-get-all.zip"
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   
#   lambda_136 = {
#     function_name = "prod-wdr-mapps-notification-template-get-by-id"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/09222025/wdr-notification-template-get-by-id.zip"
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   
#   lambda_137 = {
#     function_name = "prod-wdr-mapps-notification-template-update-by-id"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/09222025/wdr-notification-template-update-by-id.zip"
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_138 = {
#     function_name = "prod-wdr-mapps-project-last-update-time"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/09222025/wdr-notification-template-update-by-id.zip"
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
# 
#   # lambda_139 = {
#   #   function_name = "prod-wdr-mapps-sync-database-s3"
#   #   runtime       = "nodejs22.x"
#   #   handler       = "index.handler"
#   #   timeout       = 60
#   #   memory_size   = 128
#   #   env_vars = {
#   #     STAGE = "prod"
#   #     LOG_LEVEL = "ERROR"
#   #     JWT_SECRET = "wdr-default-secret-key"
#   #     NODE_OPTIONS = "--enable-source-maps"
#   #     SOURCE_BUCKET = "prod-wdr-maritimeapps-deploy-lambda-assets6"
#   #     SOURCE_REGION = "us-east-2"
#   #     SOURCE_DB_SECRET_ARN = "arn:aws:secretsmanager:us-east-2:797233058645:secret:prod-wdr-maritimeapps-secretmanager-tmaprod-93zYv3"
#   #     TARGET_BUCKET = "prod-wdr-maritimeapps-deploy-lambda-assets6"
#   #     TARGET_REGION = "ap-southeast-2"
#   #     TARGET_DB_SECRET_ARN = "arn:aws:secretsmanager:us-east-2:797233058645:secret:prod-wdr-maritimeapps-secretmanager-tmaprod-93zYv3"
#       
#   #   }
#   #   # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#   #   # s3_key = "prod/release2.0/09222025/wdr-notification-template-update-by-id.zip"
#   #   layers = ["models_v35", "connect_db_v35", "common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   # },
# 
#   lambda_140 = {
#     function_name = "prod-wdr-maritimeapps-depl-ld-clean-expired-tokens"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release2.0/10282025/wdr-clean-expired-tokens.zip"
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#      
#   lambda_141 = {
#     function_name = "prod-wdr-mapps-app-settings-update-bulk"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#       COGNITO_USER_POOL_ID = "us-east-2_8h0ZVkQbm"
#       COGNITO_WEB_CLIENT_ID = "1kre7uqpl7vad739btuaftf9b4"
#       COGNITO_MOBILE_CLIENT_ID = "9443b004rov63tt1fvj6s1v8a"
#       SCHEDULE_GROUP_NAME = "prod-wdr-maritimeapps-schedulers"
#       SCHEDULE_ROLE_ARN = "arn:aws:iam::797233058645:role/prod_wdr_maritimeapps_deploy_app_lambda"
#       PROJECT_SCHEDULE_NAME = "prod-wdr-maritimeapps-project-daily-fetch-scheduler"
#       TARGET_PROJECT_FUNCTION_ARN = "arn:aws:lambda:us-east-2:797233058645:function:prod-wdr-maritimeapps-depl-ld-project-daily-fetch"
#       REPORT_NOTIFICATION_SCHEDULE_NAME = "prod-wdr-mapps-report-update-silent-noti-scheduler"
#       TARGET_REPORT_NOTIFICATION_FUNCTION_ARN = "arn:aws:lambda:us-east-2:797233058645:function:prod-wdr-mapps-report-update-silent-notification"
#       DORMANT_USER_SCHEDULE_NAME = "prod-wdr-maritimeapps-lock-dormant-users-scheduler"    
#       TARGET_DORMANT_USER_FUNCTION_ARN = "arn:aws:lambda:us-east-2:797233058645:function:prod-wdr-mapps-lock-dormant-users"
#       ENTITY_CHANGE_LOG_NOTIFICATION_SCHEDULE_NAME = "prod-wdr-maritimeapps-changes-silent-noti-schedule"
#       TARGET_ENTITY_CHANGE_LOG_NOTIFICATION_FUNCTION_ARN= "arn:aws:lambda:us-east-2:797233058645:prod-wdr-maritimeapps-changes-silent-noti-schedule"
#       COGNITO_API_CLIENT_ID ="7k0eaar0v1jom2llqjuhbf3f5g"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release3.0/websocket/wdr-app-settings-update-bulk.zip"
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
#   
#   lambda_143 = {
#     function_name = "prod-wdr-mapps-app-settings-get-password-policy"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release3.0/sqs/wdr-app-settings-get-password-policy.zip"
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_144 = {
#     function_name = "prod-wdr-mapps-websocket-connect"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#       
#     }
#     # s3_bucket = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#     # s3_key = "prod/release3.0/sqs/wdr-websocket-connect.zip"
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_145 = {
#     function_name = "prod-wdr-mapps-websocket-disconnect"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"]  
#   },
#   lambda_146 = {
#     function_name = "prod-wdr-mapps-pre-token-generation-trigger"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#       COGNITO_WEB_CLIENT_ID = "1kre7uqpl7vad739btuaftf9b4"
#       COGNITO_MOBILE_CLIENT_ID = "9443b004rov63tt1fvj6s1v8a"
#       COGNITO_API_CLIENT_ID = "7k0eaar0v1jom2llqjuhbf3f5g"
#     }
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"] 
#   },
#   lambda_147 = {
#     function_name = "prod-wdr-mapps-reset-password-user"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#       COGNITO_USER_POOL_ID = "us-east-2_8h0ZVkQbm"
#       SES_SOURCE_EMAIL = "noreply@dngioi.website"
#     }
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"] 
#   },
#   lambda_148 = {
#     function_name = "prod-wdr-mapps-user-get-my-role-project"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"] 
#   },
#   lambda_149 = {
#     function_name = "prod-wdr-mapps-revoke-token-logout"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#       COGNITO_USER_POOL_ID = "us-east-2_8h0ZVkQbm"
#     }
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"] 
#   },
#   lambda_150 = {
#     function_name = "prod-wdr-mapps-user-signature-check-and-proccess"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#       DESTINATION_BUCKET = "prod-wdr-maritimeapps-deploy-lambda-assets6"
#     }
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"] 
#   },
#   lambda_151 = {
#     function_name = "prod-wdr-mapps-user-signature-delete"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"] 
#   },
#   lambda_152 = {
#     function_name = "prod-wdr-mapps-project-history-processor"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"] 
#   },
#   
#   lambda_153 = {
#     function_name = "prod-wdr-mapps-role-update-permission"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"] 
#   },
#   lambda_154 = {
#     function_name = "prod-wdr-mapps-get-report-with-previous-version"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"] 
#   },
#   lambda_155 = {
#     function_name = "prod-wdr-mapps-awrf-raised-stats"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"] 
#   },
#   lambda_156 = {
#     function_name = "prod-wdr-mapps-dashboard-get"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"] 
#   },
#   lambda_157 = {
#     function_name = "prod-wdr-mapps-project-progress-list"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"] 
#   },
#   # lambda_158 = {
#   #   function_name = "prod-wdr-mapps-project-get-all-data-offline"
#   #   runtime       = "nodejs22.x"
#   #   handler       = "index.handler"
#   #   timeout       = 60
#   #   memory_size   = 128
#   #   env_vars = {
#   #     STAGE = "prod"
#   #     LOG_LEVEL = "ERROR"
#   #     JWT_SECRET = "wdr-default-secret-key"
#   #     NODE_OPTIONS = "--enable-source-maps"
#   #   }
#   #   layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"] 
#   # },
#   lambda_159 = {
#     function_name = "prod-wdr-mapps-project-search-by-parameters-export"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#     layers = ["models_v35", "connect_db_v35", "error_codes_v35","common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"] 
#   },
#   lambda_160 = {
#     function_name = "prod-wdr-mapps-project-get-all-data-offline-v2"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 1024
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#       DESTINATION_BUCKET = "prod-wdr-maritimeapps-deploy-lambda-assets6"
#     }
#     layers = ["connect_db_v35", "common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"] 
#   },
#   lambda_161 = {
#     function_name = "prod-wdr-mapps-report-update-silent-notification"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 1024
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#     layers = ["connect_db_v35", "common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"] 
#   },
#   lambda_162 = {
#     function_name = "prod-wdr-mapps-lock-dormant-users"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 900
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"      
#       COGNITO_USER_POOL_ID = "us-east-2_8h0ZVkQbm"
#       AZURE_TENANT_ID = "afd79c27-0409-470b-9f2f-daf6122000c3"
#       AZURE_CLIENT_ID = "c2dcb06b-f92b-4947-ac78-543702397aad"
#       AZURE_CLIENT_SECRET	 = "YOUR_AZURE_CLIENT_SECRET_HERE"
#       AZURE_GROUP_ID = "af86df0a-1aa7-4266-a72c-3a94d43d7964"
#       SES_SOURCE_EMAIL = "noreply@dngioi.website"
#       USE_WORKATO = false
#       WORKATO_SECRET_NAME = "arn:aws:secretsmanager:us-east-2:797233058645:secret:prod-wdr-secretmanager-workato-0p0fG9"
#       WORKATO_TOKEN_LINK = "/oauth2/token"
#       WORKATO_ADD_LINK = "/aadgrp-v1/wdr"
#       SERVICE_USER_EMAIL_DOMAIN = "wdr.serviceacc.com"
#       # WORKATO_CLIENT_ID = "a64c7dd9316c9a59fbd94a4beca4fb42bc1190de1cef6af1a5a92db0ae98fdd7"
#       # WORKATO_CLIENT_SECRET = "18f22ca771284ef393134401c5473fd90d47cb3b6a54da86d8f6e83effdf4b48"
#     }
#     layers = ["connect_db_v35", "common_utils","AWS-Parameters-and-Secrets-Lambda-Extension"] 
#   },
#   lambda_163 = {
#     function_name = "prod-wdr-mapps-lambda-ping-schedule"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 1024
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#       PING_TARGETS_BUCKET = "prod-wdr-maritimeapps-deploy-lambda-assets6"
#       PING_TARGETS_KEY = "lambda-ping-targets-prod.json"
#     }
# 
#     layer = ["AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
#   lambda_164 = {
#     function_name = "prod-wdr-mapps-login-service-user"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 1024
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#       COGNITO_USER_POOL_ID = "us-east-2_8h0ZVkQbm"
#       SERVICE_APP_CLIENT_ID = "7k0eaar0v1jom2llqjuhbf3f5g"
#       SERVICE_USER_EMAIL_DOMAIN = "wdr.serviceacc.com"
#     }
#    
#   layers =  ["models_v35", "connect_db_v35", "common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
# 
#   lambda_165 = {
#     function_name = "prod-wdr-mapps-change-password-service-user"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 1024
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#       COGNITO_USER_POOL_ID = "us-east-2_8h0ZVkQbm"
#       SERVICE_USER_EMAIL_DOMAIN = "wdr.serviceacc.com"
#     }
#    
#   layers =  ["models_v35", "connect_db_v35", "common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
# 
#   lambda_166 = {
#     function_name = "prod-wdr-mapps-track-password-changed"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 1024
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#       COGNITO_USER_POOL_ID = "us-east-2_8h0ZVkQbm"
#       SERVICE_USER_EMAIL_DOMAIN = "wdr.serviceacc.com"
#     }
#    
#   layers =  ["models_v35", "connect_db_v35", "common_utils", "error_codes_v35", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
#   
#   lambda_167 = {
#     function_name = "prod-wdr-mapps-register-silent-notifications"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 1024
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
# 
#     }
#    
#   layers =  ["models_v35","connect_db_v35", "common_utils", "error_codes_v35", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
# 
#   lambda_168 = {
#     function_name = "prod-wdr-mapps-app-settings-get-limit-editor"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 1024
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
# 
#     }
#    
#   layers =  ["models_v35","connect_db_v35", "common_utils", "error_codes_v35", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
# 
#   lambda_169 = {
#     function_name = "prod-wdr-mapps-app-settings-reset-to-default"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 1024
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
# 
#     }
#    
#   layers =  ["models_v35","connect_db_v35", "common_utils", "error_codes_v35", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
# 
#   lambda_170 = {
#     function_name = "prod-wdr-mapps-user-export"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 1024
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#    
#   layers =  ["exceljs", "connect_db_v35", "common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
# 
#   lambda_171 = {
#     function_name = "prod-wdr-mapps-role-export"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 1024
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#    
#   layers =  ["exceljs", "connect_db_v35", "common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
# 
#   lambda_172 = {
#     function_name = "prod-wdr-mapps-changes-update-silent-notification"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 1024
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#    
#   layers =  ["connect_db_v35", "common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
# 
#   lambda_173 = {
#     function_name = "prod-wdr-mapps-submit-and-approve-report"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 1024
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
# 
#     }
#    
#   layers =  ["models_v35","connect_db_v35", "common_utils", "error_codes_v35", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
# 
#   lambda_174 = {
#     function_name = "prod-wdr-mapps-get-history-step-by-number"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 1024
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
# 
#     }
#    
#   layers =  ["models_v35","connect_db_v35", "common_utils", "error_codes_v35", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   }
# 
#   lambda_175 = {
#     function_name = "prod-wdr-mapps-multi-cognito-sync"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 1024
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#       PROVIDER_NAME = "Azure"
#     }
#    
#   layers =  ["models_v35","connect_db_v35", "common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
# 
#   lambda_176 = {
#     function_name = "prod-wdr-mapps-multi-cognito-create"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 1024
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#    
#   layers =  ["models_v35","connect_db_v35", "common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
# 
#   lambda_177 = {
#     function_name = "prod-wdr-mapps-multi-cognito-update-by-id"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 1024
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#    
#   layers =  ["models_v35","connect_db_v35", "common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
# 
#   lambda_178 = {
#     function_name = "prod-wdr-mapps-multi-cognito-delete-by-id"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 1024
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#    
#   layers =  ["models_v35","connect_db_v35", "common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
# 
#   lambda_179 = {
#     function_name = "prod-wdr-mapps-multi-cognito-find-all"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 1024
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#     }
#    
#   layers =  ["models_v35","connect_db_v35", "common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
# 
#   lambda_180 = {
#     function_name = "prod-wdr-mapps-multi-cognito-auto-sync"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 1024
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#       SYNC_FUNCTION_NAME = "prod-wdr-mapps-multi-cognito-sync"
#     }
#    
#   layers =  ["models_v35","connect_db_v35", "common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
# 
#   lambda_181 = {
#     function_name = "prod-wdr-mapps-multi-cognito-sync-global-user-id"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 1024
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#       COGNITO_REGION = "us-east-2"
#       DRY_RUN = "false"
# 
#     }
#    
#   layers =  ["models_v35","connect_db_v35", "common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
# 
#   lambda_182 = {
#     function_name = "prod-wdr-mapps-multi-cognito-reset-pwd"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 1024
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#       SES_SOURCE_EMAIL = "noreply@dngioi.website"
# 
#     }
#    
#   layers =  ["models_v35","connect_db_v35", "common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
# 
#   lambda_183 = {
#     function_name = "prod-wdr-mapps-get-usage-analytics"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 1024
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
# 
#     }
#    
#   layers =  ["models_v35","connect_db_v35", "common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
# 
#   lambda_184 = {
#     function_name = "prod-wdr-mapps-create-usage-analytics"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 1024
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
# 
#     }
#    
#   layers =  ["models_v35","connect_db_v35", "common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
# 
#   lambda_185 = {
#     function_name = "prod-wdr-mapps-project-export-metadata"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 1024
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#       DESTINATION_BUCKET = "prod-wdr-maritimeapps-deploy-lambda-assets6"
# 
#     }
#    
#   layers =  ["connect_db_v35", "common_utils", "exceljs", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
# 
#   lambda_186 = {
#     function_name = "prod-wdr-mapps-project-export-joblist"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 1024
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#       DESTINATION_BUCKET = "prod-wdr-maritimeapps-deploy-lambda-assets6"
#       FILE_KEY = "masterdata/template_worklist.xlsx"
# 
#     }
#    
#   layers =  ["connect_db_v35", "common_utils", "exceljs", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
# 
#   lambda_187 = {
#     function_name = "prod-wdr-mapps-project-get-jobs-for-export"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 1024
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#       DESTINATION_BUCKET = "prod-wdr-maritimeapps-deploy-lambda-assets6"
# 
#     }
#    
#   layers =  ["connect_db_v35", "common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
# 
#   lambda_188 = {
#     function_name = "prod-wdr-mapps-project-copy-job-export-resource"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 1024
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#       DESTINATION_BUCKET = "prod-wdr-maritimeapps-deploy-lambda-assets6"
# 
#     }
#    
#   layers =  ["connect_db_v35", "common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
# 
#   lambda_189 = {
#     function_name = "prod-wdr-mapps-pdf-generator"
#     runtime       = "nodejs18.x"
#     handler       = "index.handler"
#     timeout       = 300
#     memory_size   = 1024
#     env_vars = {
#       STAGE = "prod"
#       CHROMIUM_EXECUTABLE_PATH = "/opt/chromium"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#       DESTINATION_BUCKET = "prod-wdr-maritimeapps-deploy-lambda-assets6"
#       EXPORT_REPORT_ACCOUNT_ARN = "arn:aws:secretsmanager:us-east-2:797233058645:secret:prod-wdr-maritimeapps-secretmanager-system-user-ExUIG6"
# 
#     }
#    
#   layers =  ["connect_db_v35", "common_utils", "chrome-aws-lambda", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
# 
#   lambda_190 = {
#     function_name = "prod-wdr-mapps-project-combine-exports"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 300
#     memory_size   = 1024
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#       DESTINATION_BUCKET = "prod-wdr-maritimeapps-deploy-lambda-assets6"
# 
#     }
#    
#   layers =  ["common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
# 
#   lambda_191 = {
#     function_name = "prod-wdr-mapps-project-update-database"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 1024
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#       DESTINATION_BUCKET = "prod-wdr-maritimeapps-deploy-lambda-assets6"
# 
#     }
#    
#   layers =  ["connect_db_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
# 
#   lambda_192 = {
#     function_name = "prod-wdr-mapps-project-export-trigger"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 1024
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#       STATE_MACHINE_ARN = "arn:aws:states:us-east-2:797233058645:stateMachine:prod-wdr-mapps-project-export-workflow" # STATE_MACHINE_ARN: Hardcode ARN đầy đủ, Format: arn:aws:states:REGION:ACCOUNT_ID:stateMachine:STATE_MACHINE_NAME
#        
#     }
#    
#   layers =  ["connect_db_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
# 
#   lambda_193 = {
#     function_name = "prod-wdr-mapps-cleanup-old-records"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 1024
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#       EXPORT_BUCKET = "prod-wdr-maritimeapps-deploy-lambda-assets6"      
#        
#     }
#    
#   layers =  ["connect_db_v35", "models_v35", "common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
# 
#   lambda_194 = {
#     function_name = "prod-wdr-mapps-user-login-log-export"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 300
#     memory_size   = 1024
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"      
#        
#     }
#    
#   layers =  ["connect_db_v35", "common_utils", "exceljs", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
# 
#   lambda_195 = {
#     function_name = "prod-wdr-mapps-project-export-notification"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 300
#     memory_size   = 1024
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#       DESTINATION_BUCKET = "prod-wdr-maritimeapps-deploy-lambda-assets6"      
#        
#     }
#    
#   layers =  ["connect_db_v35", "common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
# 
#   lambda_196 = {
#     function_name = "prod-wdr-mapps-project-delete"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 300
#     memory_size   = 1024
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#       DESTINATION_BUCKET = "prod-wdr-maritimeapps-deploy-lambda-assets6"      
#        
#     }
#    
#   layers =  ["connect_db_v35", "common_utils", "models_v35","AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
# 
#   lambda_197 = {
#     function_name = "prod-wdr-mapps-project-delete-quotation"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 300
#     memory_size   = 1024
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#       DESTINATION_BUCKET = "prod-wdr-maritimeapps-deploy-lambda-assets6"
#        
#     }
#    
#   layers =  ["connect_db_v35", "common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
# 
#   lambda_198 = {
#     function_name = "prod-wdr-mapps-project-get-feedback"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 300
#     memory_size   = 1024
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#        
#     }
#    
#   layers =  ["connect_db_v35", "common_utils", "models_v35", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
# 
#   lambda_199 = {
#     function_name = "prod-wdr-mapps-summarize-usage-analytics"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 1024
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#        
#     }
#    
#   layers =  ["connect_db_v35", "common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
# 
#   lambda_200 = {
#     function_name = "prod-wdr-mapps-network-health-check"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#     }  
#   
#   layers =  ["common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
# 
#   lambda_201 = {
#     function_name = "prod-wdr-mapps-multi-cognito-process-pending-syncs"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#       SES_SOURCE_EMAIL = "noreply@dngioi.website"
#     }  
#   
#   layers =  ["connect_db_v35","common_utils", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
# 
#   lambda_202 = {
#     function_name = "prod-wdr-mapps-service-users-get-all"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#       
#     }  
#   
#   layers =  ["connect_db_v35","common_utils", "models_v35", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
# 
#   lambda_203 = {
#     function_name = "prod-wdr-mapps-assign-projects-to-user"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 128
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#       
#     }  
#   
#   layers =  ["connect_db_v35","common_utils", "models_v35", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   },
#   
#   lambda_204 = {
#     function_name = "prod-wdr-mapps-track-login-failed"
#     runtime       = "nodejs22.x"
#     handler       = "index.handler"
#     timeout       = 60
#     memory_size   = 1024
#     env_vars = {
#       STAGE = "prod"
#       LOG_LEVEL = "ERROR"
#       JWT_SECRET = "wdr-default-secret-key"
#       NODE_OPTIONS = "--enable-source-maps"
#       
#     }  
#   
#   layers =  ["connect_db_v35","common_utils", "models_v35", "AWS-Parameters-and-Secrets-Lambda-Extension"]
#   }
# 
#   }
# #SQS_S3 and DB
s3_buckets = {
  bucket1 = {
    name = "vule-assets-bucket"
  }
  bucket3 = {
    name = "vule-fe-source-bucket"
  }
}

# ========================================
# SQS QUEUES
# ========================================
sqs_queues = {
  notification_processing = {
    name                      = "prod-wdr-notification-processing"
    delay_seconds             = 0
    retention_seconds         = 345600  # 4 days
    visibility_timeout        = 60
    receive_wait_time         = 0  # Short polling (0 = immediate return, >0 = long polling)
    lambda_keys               = ["lambda_130"]  
    batch_size                = 10
    batching_window           = 0
    # max_retry_attempts        = 5  # Unlimited retries
    enabled                   = true
  },
  silent_notification_processing = {
    name                      = "prod-wdr-notification-silent-processing"
    delay_seconds             = 0
    retention_seconds         = 345600  # 4 days
    visibility_timeout        = 60
    receive_wait_time         = 0  # Short polling (0 = immediate return, >0 = long polling)
    lambda_keys               = ["lambda_131"]  
    batch_size                = 10
    batching_window           = 0
    # max_retry_attempts        = 5  # Unlimited retries
    enabled                   = true
  },
  project_tasks_dlq = {
    name                      = "prod-wdr-project-tasks-dlq"
    delay_seconds             = 0
    retention_seconds         = 345600  # 4 days
    visibility_timeout        = 60
    receive_wait_time         = 0  # Short polling (0 = immediate return, >0 = long polling)
    # No lambda_keys - DLQ không có lambda trigger
  },
  project_tasks = {
    name                      = "prod-wdr-project-tasks"
    delay_seconds             = 0
    retention_seconds         = 1209600   # 14 days
    visibility_timeout        = 300
    receive_wait_time         = 20  # Long polling (0 = immediate return, >0 = long polling)
    lambda_keys               = ["lambda_152"]  
    batch_size                = 10
    batching_window           = 0
    enabled                   = true
    dlq_key                   = "project_tasks_dlq"  # DLQ là project_tasks_dlq
    max_receive_count         = 5  # Max receive count trước khi gửi vào DLQ
  }
}

# Cognito Proxy CloudFront Distribution
cognito_proxy_distribution = {
  enabled = true
  certificate_arn = ""
}

# Enable Origin Access Control for FE S3 buckets
enable_oac_for_fe = true  # ENABLED - OAC imported from manual setup
fe_bucket_domain_name = "vule-fe-source-bucket.s3.us-east-2.amazonaws.com"

rds_clusters = {

  wdr = {
    cluster_identifier     = "prod-wdr-maritimeapps-deploy-aurora-cluster6"
    engine                 = "aurora-postgresql"
    engine_version         = "17.5"
    master_username        = "postgres"
    master_password        = "dl8!RHGiz0Qek![J$5u0.dvYJ_7_"
    database_name          = "wdr"
    vpc_security_group_ids = ["sg-0caf0321f7180ceba"]  # OLD VPC Security Group
    db_subnet_group_name   = "prod-wdr-subnetgroup"  # Subnet group cũ
    deletion_protection    = true  # Bảo vệ cluster khỏi bị xóa
  }

}

# ========================================
# AURORA INSTANCES - CẢ 2 CLUSTERS (CŨ VÀ MỚI)
# ========================================
rds_instances = {
  # Aurora Instance CŨ - VPC cũ (wdr) - GIỮ NGUYÊN
  wdr_writer = {
    cluster_identifier = "prod-wdr-maritimeapps-deploy-aurora-cluster6"
    instance_class     = "db.serverless"
    identifier         = "prod-wdr-maritimeapps-deploy-aurora-instance-1"
  }

  # wdr_reader = {
  #   cluster_identifier = "prod-wdr-maritimeapps-deploy-aurora-cluster6"
  #   instance_class     = "db.serverless"
  #   identifier         = "prod-wdr-maritimeapps-deploy-aurora-instance-2"
  # }

}

# ========================================
# DB SUBNET GROUP - VPC MỚI
# ========================================


# ========================================
# RDS CLUSTERS CŨ - ĐÃ CHUYỂN LÊN TRÊN (COMMENTED)
# ========================================
# rds_clusters = {
#   wdr = {
#     cluster_identifier     = "prod-wdr-maritimeapps-deploy-aurora-cluster6"
#     engine                 = "aurora-postgresql"
#     engine_version         = "17.5"
#     master_username        = "postgres"
#     master_password        = "dl8!RHGiz0Qek![J$5u0.dvYJ_7_"
#     database_name          = "wdr"
#     # vpc_security_group_ids = ["sg-04dc8e16173899f34"]       #vpc of region Sydney
#     vpc_security_group_ids = ["sg-02075d1c9a946c549"]         #vpc of region Singapre new for prod
#   }
# }

# rds_instances = {
#   wdr_writer = {
#     cluster_identifier = "prod-wdr-maritimeapps-deploy-aurora-cluster6"
#     identifier         = "prod-wdr-maritimeapps-deploy-aurora-instance-1"
#     instance_class     = "db.serverless"
#   }

#  wdr_reader_1 = {
#     cluster_identifier = "prod-wdr-maritimeapps-deploy-aurora-cluster6"
#     identifier         = "prod-wdr-maritimeapps-deploy-aurora-instance-2"
#     instance_class     = "db.serverless"
#   }
  # wdr_reader_2 = {
  #   cluster_identifier = "prod-wdr-maritimeapps-deploy-aurora-cluster"
  #   identifier         = "prod-wdr-maritimeapps-deploy-aurora-instance-3"
  #   instance_class     = "db.serverless"
  # }
# }

# ========================================
# DB SUBNET GROUP CŨ - ĐÃ CHUYỂN LÊN TRÊN (COMMENTED)
# ========================================

db_subnet_group_name            = "tma-prod-subnetgroup-new-vpc"
db_cluster_parameter_group_name = "prod-wdr-maritimeapps-aurora17-nonssl"



#REST API GATEWAY
apis = {
  wdr_prod_auth = {
    api_name = "prod-wdr-maritimeapps-deploy-lambda-gw"
    api_paths = {
      # global_settings = {
      #   parent_path     = "global-settings"
      #   child_path      = ""
      #   grandchild_path = ""
      #   http_methods = [
      #     {
      #       method     = "GET"
      #       lambda_key = "lambda_38" # wdr-global-settings-get-all
      #     },
      #     {
      #       method     = "OPTIONS"
      #       lambda_key = ""
      #     }
      #   ]
      # },
      # global_settings_id = {
      #   parent_path     = "global-settings"
      #   child_path      = "{id}"
      #   grandchild_path = ""
      #   http_methods = [
      #     {
      #       method     = "PUT"
      #       lambda_key = "lambda_31" # global-settings-update-by-id
      #     },
      #     {
      #       method     = "OPTIONS"
      #       lambda_key = ""
      #     }
      #   ]
      # },
      # global_settings_group_groups = {
      #   parent_path     = "global-settings"
      #   child_path      = "group"
      #   grandchild_path = "{group}"
      #   http_methods = [
      #     {
      #       method     = "GET"
      #       lambda_key = "lambda_47" # wdr-global-settings-get-all-by-group
      #     },
      #     {
      #       method     = "OPTIONS"
      #       lambda_key = ""
      #     }
      #   ]
      # },
      job = {
        parent_path     = "job"
        child_path      = ""
        grandchild_path = ""
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_20" # wdr-job-get-all

          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          },
          {
            method     = "POST"
            lambda_key = "lambda_21" # wdr-job-create
            
          }
        ]
      },
      job_id = {
        parent_path     = "job"
        child_path      = "{id}"
        grandchild_path = ""
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_22" # wdr-job-get-by-id
            
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          },
          {
            method     = "PUT"
            lambda_key = "lambda_23" # wdr-job-update-by-id
            
          }
        ]
      },
      job_id_changetatus = {
        parent_path     = "job"
        child_path      = "{id}"
        grandchild_path = "change-status"
        http_methods = [
          {
            method     = "OPTIONS"
            lambda_key = ""
          },
          {
            method     = "PUT"
            lambda_key = "lambda_80" # wdr-job-change-status cho ban

          }
        ]
      },
      job_attachment_check = {
        parent_path     = "job"
        child_path      = "attachment-check"
        grandchild_path = ""
        http_methods = [
          {
            method     = "OPTIONS"
            lambda_key = ""
          },
          {
            method     = "POST"
            lambda_key = "lambda_105" # wdr-job-attachment-check-and-proccess
            
          }
        ]
      },
      job_attachment_upload = {
        parent_path     = "job"
        child_path      = "attachment-upload"
        grandchild_path = ""
        http_methods = [
          {
            method     = "DELETE"
            lambda_key = "lambda_81" # wdr-delete-job-attachment
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          },
          {
            method     = "POST"
            lambda_key = "lambda_82" # wdr-job-attachment-upload
           
          }
        ]
      },
      job_delete = {
        parent_path     = "job"
        child_path      = "delete"
        grandchild_path = ""
        http_methods = [
          {
            method     = "DELETE"
            lambda_key = "lambda_83" # wdr-job-delete
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          }
        ]
      },
      job_export_excel = {
        parent_path     = "job"
        child_path      = "export-excel"
        grandchild_path = ""
        http_methods = [
          {
            method     = "OPTIONS"
            lambda_key = ""
          },
          {
            method     = "POST"
            lambda_key = "lambda_84" # wdr-job-export-excel
          }
        ]
      },
      job_get_all_attachment_by_id = {
        parent_path     = "job"
        child_path      = "get-all-attachment-by-id"
        grandchild_path = ""
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_85" # wdr-job-attachment-getall-byid
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          }
          
        ]
      },
      job_get_all_photo_by_id = {
        parent_path     = "job"
        child_path      = "get-all-photo-by-id"
        grandchild_path = ""
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_86" # wdr-job-photo-getall-byid
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          }
          
        ]
      },
      job_getsupervisors = {
        parent_path     = "job"
        child_path      = "get-supervisors"
        grandchild_path = ""
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_1" # wdr-job-get-all-supervisors
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          }
        ]
      },
      job_gettradesections = {
        parent_path     = "job"
        child_path      = "get-trade-sections"
        grandchild_path = ""
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_2" # wdr-job-get-all-trade-sections
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          }
        ]
      },
      job_merge = {
        parent_path     = "job"
        child_path      = "merge"
        grandchild_path = ""
        http_methods = [
          {
            method     = "OPTIONS"
            lambda_key = ""
          },
          {
            method     = "POST"
            lambda_key = "lambda_87" # wdr-job-merge
          }
          
        ]
      },      
      job_photo_check = {
        parent_path     = "job"
        child_path      = "photo-check"
        grandchild_path = ""
        http_methods = [
          
          {
            method     = "OPTIONS"
            lambda_key = ""
          },
          {
            method     = "POST"
            lambda_key = "lambda_106" # wdr-job-photo-check-and-proccess
          }
        ]
      },
      job_photo_upload = {
        parent_path     = "job"
        child_path      = "photo-upload"
        grandchild_path = ""
        http_methods = [
          {
            method     = "DELETE"
            lambda_key = "lambda_89" # wdr-job-photo-delete
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          }
        ]
      },
      job_search = {
        parent_path     = "job"
        child_path      = "search"
        grandchild_path = ""
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_24" # job-search-by-params
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          }
        ]
      },
      job_status = {
        parent_path     = "job"
        child_path      = "status"
        grandchild_path = ""
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_42" # job-get-all-status
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          }
        ]
      },
      job_update_multi= {
        parent_path     = "job"
        child_path      = "update-multi"
        grandchild_path = ""
        http_methods = [
          {
            method     = "OPTIONS"
            lambda_key = ""
          },
          {
            method     = "PUT"
            lambda_key = "lambda_90" # wdr-job-update-multi
          }          
        ]
      },
      job_update_multidata= {
        parent_path     = "job"
        child_path      = "update-multi-data"
        grandchild_path = ""
        http_methods = [
          {
            method     = "OPTIONS"
            lambda_key = ""
          },
          {
            method     = "PUT"
            lambda_key = "lambda_121" # wdr-job-update-multi-jobs-data
          }          
        ]
      },
      # multicognito= {
      #   parent_path     = "multi-cognito"
      #   child_path      = ""
      #   grandchild_path = ""
      #   http_methods = [
      #     {
      #       method     = "GET"
      #       lambda_key = "lambda_174" # wdr-multi-cognito-find-all
      #     },
      #     {
      #       method     = "OPTIONS"
      #       lambda_key = ""
      #     },
      #     {
      #       method     = "POST"
      #       lambda_key = "lambda_171" # wdr-multi-cognito-create
      #     }          
      #   ]
      # },
      # multicognito_id= {
      #   parent_path     = "multi-cognito"
      #   child_path      = "{id}"
      #   grandchild_path = ""
      #   http_methods = [
      #     {
      #       method     = "DELETE"
      #       lambda_key = "lambda_173" # wdr-multi-cognito-delete-by-id
      #     },
      #     {
      #       method     = "OPTIONS"
      #       lambda_key = ""
      #     },
      #     {
      #       method     = "PUT"
      #       lambda_key = "lambda_172" # wdr-multi-cognito-update-by-id
      #     }          
      #   ]
      # },
      # multicognito_resetpwd= {
      #   parent_path     = "multi-cognito"
      #   child_path      = "reset-pwd"
      #   grandchild_path = ""
      #   http_methods = [
      #     {
      #       method     = "OPTIONS"
      #       lambda_key = ""
      #     },
      #     {
      #       method     = "POST"
      #       lambda_key = "lambda_177" # wdr-multi-cognito-reset-pwd
      #     }          
      #   ]
      # },
      # multicognito_sync= {
      #   parent_path     = "multi-cognito"
      #   child_path      = "sync"
      #   grandchild_path = ""
      #   http_methods = [
      #     {
      #       method     = "OPTIONS"
      #       lambda_key = ""
      #     },
      #     {
      #       method     = "POST"
      #       lambda_key = "lambda_170" # wdr-multi-cognito-sync
      #     }          
      #   ]
      # },
      permission= {
        parent_path     = "permission"
        child_path      = ""
        grandchild_path = ""
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_91" # wdr-permission-get-all
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          }
        ]
      },
      pre_defined = {
        parent_path     = "pre-defined"
        child_path      = ""
        grandchild_path = ""
        http_methods = [
          {
            method        = "GET"
            lambda_key    = "lambda_49" # wdr-pre-defined-get-all
            
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          },
          {
            method     = "POST"
            lambda_key = "lambda_50" # wdr-pre-defined-create
           
          }
        ]
      },
      pre_defined_id = {
        parent_path     = "pre-defined"
        child_path      = "{id}"
        grandchild_path = ""
        http_methods = [
          {
            method     = "DELETE"
            lambda_key = "lambda_51" # wdr-pre-defined-delete-by-id
           
          },
          {
            method     = "GET"
            lambda_key = "lambda_52" # wdr-pre-defined-get-by-id
           
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          },
          {
            method     = "PUT"
            lambda_key = "lambda_53" # wdr-pre-defined-update-by-id
            
          }
          
        ]
      },
      pre_defined_dynamic_values = {
        parent_path     = "pre-defined"
        child_path      = "dynamic-values"
        grandchild_path = ""
        http_methods = [
          {
            method     = "OPTIONS"
            lambda_key = ""
          },
          {
            method     = "POST"
            lambda_key = "lambda_92" # wdr-dynamic-values-get-values
            
          }
        ]
      },
      pre_defined_search = {
        parent_path     = "pre-defined"
        child_path      = "search"
        grandchild_path = ""
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_54" # wdr-pre-defined-search-by-params
            
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          }
        ]
      },
      projects = {
        parent_path     = "projects"
        child_path      = ""
        grandchild_path = ""
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_16" # wdr-project-get-all
            
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          },
          {
            method     = "POST"
            lambda_key = "lambda_26" # wdr-project-create
           
          }
        ]
      },
      projects_id = {
        parent_path     = "projects"
        child_path      = "{id}"
        grandchild_path = ""
        http_methods = [
          {
            method     = "DELETE"
            lambda_key = "lambda_196" # wdr-project-delete
            
          },
          {
            method     = "GET"
            lambda_key = "lambda_17" # wdr-project-get-by-id
            
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          },
          {
            method     = "PUT"
            lambda_key = "lambda_18" # wdr-project-update-by-id
            
          }
        ]
      },
      projects_id_assign_user = {
        parent_path     = "projects"
        child_path      = "{id}"
        grandchild_path = "assign-user"
        http_methods = [
          {
            method     = "OPTIONS"
            lambda_key = ""
          },
          {
            method     = "PUT"
            lambda_key = "lambda_93" # wdr-project-assign-user
            
          }
          
        ]
      },
      projects_id_dashboard = {
        parent_path     = "projects"
        child_path      = "{id}"
        grandchild_path = "dash-board"
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_3" # wdr-project-get-dashboard-data
            
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          }
        ]
      },
      projects_id_export = {
        parent_path     = "projects"
        child_path      = "{id}"
        grandchild_path = "export"
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_192" # wdr-project-export-trigger
            
          },
          {
            method     = "OPTIONS"
            lambda_key = "" 
            
          }
        ]
      },
      projects_id_feedback = {
        parent_path     = "projects"
        child_path      = "{id}"
        grandchild_path = "feedback"
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_198" # wdr-project-get-feedback
            
          },
          {
            method     = "OPTIONS"
            lambda_key = "" 
            
          }
        ]
      },
      projects_id_quotation = {
        parent_path     = "projects"
        child_path      = "{id}"
        grandchild_path = "quotation"
        http_methods = [
          {
            method     = "DELETE"
            lambda_key = "lambda_197" # wdr-project-delete-quotation
            
          },
          {
            method     = "OPTIONS"
            lambda_key = "" 
            
          }
        ]
      },
      projects_id_get_assign_user_in_trade_section = {
        parent_path     = "projects"
        child_path      = "{id}"
        grandchild_path = "get-assign-user-in-trade-section"
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_70" # wdr-project-get-assign-user-by-trade-section
            
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          }
        ]
      },
      # projects_id_history = {
      #   parent_path     = "projects"
      #   child_path      = "{id}"
      #   grandchild_path = "history"
      #   http_methods = [
      #     {
      #       method     = "GET"
      #       lambda_key = "lambda_4" # wdr-project-get-history-by-project-id
           
      #     },
      #     {
      #       method     = "OPTIONS"
      #       lambda_key = ""
      #     }
      #   ]
      # },
      projects_id_sync_wbs = {
        parent_path     = "projects"
        child_path      = "{id}"
        grandchild_path = "sync-wbs"
        http_methods = [
          {
            method     = "OPTIONS"
            lambda_key = ""
          },
          {
            method     = "POST"
            lambda_key = "lambda_95" # wdr-sub-code-sync
           
          }
          
        ]
      },  
      projects_id_updatefeedback = {
        parent_path     = "projects"
        child_path      = "{id}"
        grandchild_path = "update-feedback"
        http_methods = [
          {
            method     = "OPTIONS"
            lambda_key = "" 
          },
          {
            method     = "PUT"
            lambda_key = "lambda_96" # wdr-project-update-feedback
            
          }
        ]
      },
      projects_getprojecttemp = {
        parent_path     = "projects"
        child_path      = "get-project-temp"
        grandchild_path = ""
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_13" #wdr-get-project-temp
            
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          }
        ]
      },
      projects_getsrm = {
        parent_path     = "projects"
        child_path      = "get-srm"
        grandchild_path = ""
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_19" # wdr-project-get-all-srm-user
            
          },
          {
            method     = "OPTIONS"
            lambda_key = "" 
          }          
        ]
      },
      projects_search = {
        parent_path     = "projects"
        child_path      = "search"
        grandchild_path = ""
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_25" # wdr-project-search-by-parameters
            
          },
          {
            method     = "OPTIONS"
            lambda_key = "" 
          }          
        ]
      },
      projects_searchexport = {
        parent_path     = "projects"
        child_path      = "search-export"
        grandchild_path = ""
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_159" # wdr-project-search-by-parameters-export
            
          },
          {
            method     = "OPTIONS"
            lambda_key = "" 
          }          
        ]
      },
      projects_status = {
        parent_path     = "projects"
        child_path      = "status"
        grandchild_path = ""
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_27" # wdr-project-get-all-status
            
          },
          {
            method     = "OPTIONS"
            lambda_key = "" 
          }          
        ]
      },
      projects_sync = {
        parent_path     = "projects"
        child_path      = "sync"
        grandchild_path = ""
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_28" # wdr-project-sync-from-SAP
            
          },
          {
            method     = "OPTIONS"
            lambda_key = "" 
          }          
        ]
      },
      report = {
        parent_path     = "report"
        child_path      = ""
        grandchild_path = ""
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_6" # wdr-report-search-report
            
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          },
          {
            method     = "POST"
            lambda_key = "lambda_48" # wdr-report-create-new-report
          },
        ]
      },
      report_reportid = {
        parent_path     = "report"
        child_path      = "{reportId}"
        grandchild_path = ""
        http_methods    = [
          {
            method     = "DELETE"
            lambda_key = "lambda_29" # wdr-report-delete-report-by-id
          },
          {
            method     = "GET"
            lambda_key = "lambda_71" # wdr-report-get-by-id
          },
          {
            method     = "OPTIONS"
            lambda_key = "" 
          },
          {
            method     = "PUT"
            lambda_key = "lambda_32" # wdr-report-update
          },
        ]
      },
      report_reportid_lock = {
        parent_path     = "report"
        child_path      = "{reportId}"
        grandchild_path = "lock"
        http_methods    = [
          {
            method     = "OPTIONS"
            lambda_key = "" 
          },
          {
            method     = "PUT"
            lambda_key = "lambda_33" # wdr-report-lock-by-id
            
          },
        ]
      },
      report_reportid_pdf = {
        parent_path     = "report"
        child_path      = "{reportId}"
        grandchild_path = "pdf"
        http_methods    = [          
          {
            method     = "GET"
            lambda_key = "lambda_55" # wdr-content-xml-to-pdf
            
          }
        ]
      },
      report_reportid_refreshlock = {
        parent_path     = "report"
        child_path      = "{reportId}"
        grandchild_path = "refresh-lock"
        http_methods    = [
          {
            method     = "OPTIONS"
            lambda_key = "" 
          },
          {
            method     = "PUT"
            lambda_key = "lambda_34" # wdr-report-refresh-lock-by-id
           
          },
        ]
      },
      report_reportid_unlock = {
        parent_path     = "report"
        child_path      = "{reportId}"
        grandchild_path = "unlock"
        http_methods    = [
          {
            method     = "OPTIONS"
            lambda_key = "" 
          },
          {
            method     = "PUT"
            lambda_key = "lambda_35" # wdr-report-unlock-by-id
            
          },
        ]
      },
      report_count = {
        parent_path     = "report"
        child_path      = "count"
        grandchild_path = ""
        http_methods    = [
          {
            method     = "GET"
            lambda_key = "lambda_36" # wdr-report-count-report
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          }
        ]
      },
      report_count_report = {
        parent_path     = "report"
        child_path      = "count"
        grandchild_path = "report"
        http_methods    = [
          {
            method     = "GET"
            lambda_key = "lambda_60" # wdr-count-report-by-range-date
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          }
        ]
      },
      report_list = {
        parent_path     = "report"
        child_path      = "list"
        grandchild_path = ""
        http_methods    = [
          {
            method     = "GET"
            lambda_key = "lambda_97" # wdr-get-list-report-combine
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          }
        ]
      },
      report_paging = {
        parent_path     = "report"
        child_path      = "paging"
        grandchild_path = ""
        http_methods    = [
          {
            method     = "GET"
            lambda_key = "lambda_37" # wdr-report-search-paging
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          }
        ]
      },
      report_template = {
        parent_path     = "report"
        child_path      = "template"
        grandchild_path = ""
        http_methods    = [
          {
            method     = "OPTIONS"
            lambda_key = ""
          },
          {
            method     = "POST"
            lambda_key = "lambda_39" # report-create-report-template
          }
        ]
      },
      role = {
        parent_path     = "role"
        child_path      = ""
        grandchild_path = ""
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_107" # wdr-role-get-all
            
          },
          {
            method     = "OPTIONS"
            lambda_key = "" 
          },
          {
            method     = "POST"
            lambda_key = "lambda_94" # wdr-role-create
          }
        ]
      },
      role_id = {
        parent_path     = "role"
        child_path      = "{id}"
        grandchild_path = ""
        http_methods = [
          {
            method     = "DELETE"
            lambda_key = "lambda_98" # wdr-role-delete
           
          },
          {
            method     = "GET"
            lambda_key = "lambda_99" # wdr-role-get-by-id
            
          },
          {
            method     = "OPTIONS"
            lambda_key = "" 
          },
          {
            method     = "PUT"
            lambda_key = "lambda_100" # wdr-role-update
          }
        ]
      },
      role_id_permission = {
        parent_path     = "role"
        child_path      = "{id}"
        grandchild_path = "permission"
        http_methods = [
          {
            method     = "OPTIONS"
            lambda_key = "" 
          },
          {
            method     = "PUT"
            lambda_key = "lambda_153" # wdr-role-update-permission
          }
        ]
      },
      role_export = {
        parent_path     = "role"
        child_path      = "export"
        grandchild_path = ""
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_171" # wdr-role-export
          },
          {
            method     = "OPTIONS"
            lambda_key = "" 
          }          
        ]
      },
      sub_code = {
        parent_path     = "sub-code"
        child_path      = ""
        grandchild_path = ""
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_41" # sub-code-get-all
            
          },
          {
            method     = "OPTIONS"
            lambda_key = "" 
          },
          {
            method     = "POST"
            lambda_key = "lambda_43" # wdr-sub-code-create
            
          }
        ]
      },
      sub_code_id = {
        parent_path     = "sub-code"
        child_path      = "{id}"
        grandchild_path = ""
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_44" # wdr-sub-code-get-id
            
          },
          {
            method     = "OPTIONS"
            lambda_key = "" 
          }
        ]
      },
      sub_code_search = {
        parent_path     = "sub-code"
        child_path      = "search"
        grandchild_path = ""
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_45" # wdr-sub-code-search-by-params
            
          },
          {
            method     = "OPTIONS"
            lambda_key = "" 
          }
        ]
      },
      trade_sections = {
        parent_path     = "trade-sections"
        child_path      = ""
        grandchild_path = ""
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_9" # trade-section-get-all
            
          },
          {
            method     = "OPTIONS"
            lambda_key = "" 
          },
          {
            method     = "POST"
            lambda_key = "lambda_7" # wdr-trade-section-create
            
          }
        ]
      },
      trade_sections_id1 = {
        parent_path     = "trade-sections"
        child_path      = "{id}"
        grandchild_path = ""
        http_methods = [
          {
            method     = "DELETE"
            lambda_key = "lambda_8" # wdr-trade-section-delete-by-id
            
          },
          {
            method     = "GET"
            lambda_key = "lambda_10" # wdr-trade-section-get-by-id
            
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          },
          {
            method     = "PUT"
            lambda_key = "lambda_12" # wdr-trade-section-update-by-id
            
          }
        ]
      },
      trade_sections_id1_get_assign_user = {
        parent_path     = "trade-sections"
        child_path      = "{id}"
        grandchild_path = "get-assign-user"
        http_methods = [          
          {
            method     = "GET"
            lambda_key = "lambda_72" # wdr-trade-section-get-assign-user
            
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          }         
        ]
      },
      # trade_section_create = {
      #   parent_path     = "trade-sections"
      #   child_path      = "create"
      #   grandchild_path = ""
      #   http_methods = [
      #     {
      #       method     = "POST"
      #       lambda_key = "lambda_7" # wdr-trade-section-create
            
      #     },
      #     {
      #       method     = "OPTIONS"
      #       lambda_key = ""
      #     }
      #   ]
      # },
      trade_section_search = {
        parent_path     = "trade-sections"
        child_path      = "search"
        grandchild_path = ""
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_11" # wdr-trade-section-search-by-params
            
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          }
        ]
      },
      user_login_history = {
        parent_path     = "user-login-history"
        child_path      = ""
        grandchild_path = ""
        http_methods    = [
          {
            method     = "GET"
            lambda_key = "lambda_64" # wdr-user-login-log-get-all
            
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          }
        ]
      },
      user_login_history_export = {
        parent_path     = "user-login-history"
        child_path      = "export"
        grandchild_path = ""
        http_methods    = [
          {
            method     = "GET"
            lambda_key = "lambda_194" # wdr-user-login-log-export
            
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          }
        ]
      },
      user_login_history_trackfailed = {
        parent_path     = "user-login-history"
        child_path      = "track-failed"
        grandchild_path = ""
        http_methods    = [
          {
            method     = "OPTIONS"
            lambda_key = ""
          },
          
          {
            method     = "POST"
            lambda_key = "lambda_204" # wdr-track-login-failed
            enable_auth = false
            
          },
        ]
      },
      users = {
        parent_path     = "users"
        child_path      = ""
        grandchild_path = ""
        http_methods    = [
          {
            method     = "GET"
            lambda_key = "lambda_101" # wdr-users-get-all
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          },
          {
            method     = "POST"
            lambda_key = "lambda_102" #wdr-create-users-dev check again (bdthang_testfunction)
          }
        ]
      },
      user_id = {
        parent_path     = "users"
        child_path      = "{userId}"
        grandchild_path = ""
        http_methods = [
          # {
          #   method     = "DELETE"
          #   lambda_key = "lambda_161" # wdr-delete-users, chua co lambda nay
          # },
          {
            method     = "GET"
            lambda_key = "lambda_14" # wdr-user-get-user-by-id
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          },
          {
            method     = "PUT"
            lambda_key = "lambda_103" # wdr-update-user-dev
          }
        ]
      },
      user_userid_projects = {
        parent_path     = "users"
        child_path      = "{userId}"
        grandchild_path = "projects"
        http_methods = [
          {
            method     = "OPTIONS"
            lambda_key = ""
          },
          {
            method     = "PUT"
            lambda_key = "lambda_203" # wdr-assign-projects-to-user
          }
        ]
      },
      user_changelogintype = {
        parent_path     = "users"
        child_path      = "change-login-type"
        grandchild_path = ""
        http_methods = [
          {
            method     = "OPTIONS"
            lambda_key = ""
          },
          {
            method     = "POST"
            lambda_key = "lambda_108" # change-user-type-login
          }
        ]
      },
      user_findbyrole = {
        parent_path     = "users"
        child_path      = "find-by-role"
        grandchild_path = ""
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_46" # wdr-user-find-by-role
            
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          }
        ]
      },
      user_getmyrole = {
        parent_path     = "users"
        child_path      = "get-my-role"
        grandchild_path = ""
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_109" # wdr-users-get-my-role
            
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          }
        ]
      },
      
      user_getmyroleproject = {
        parent_path     = "users"
        child_path      = "get-my-role-project"
        grandchild_path = ""
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_148" # wdr-user-get-my-role-project
            
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          }
        ]
      },
      user_getmyroleprojecttemp = {
        parent_path     = "users"
        child_path      = "get-my-role-project-temp"
        grandchild_path = ""
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_148" # wdr-user-get-my-role-project
            
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          }
        ]
      },
      
      user_resetpassword = {
        parent_path     = "users"
        child_path      = "reset-password"
        grandchild_path = ""
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_147" # wdr-reset-password-user
            
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          }
        ]
      },
      user_search = {
        parent_path     = "users"
        child_path      = "search"
        grandchild_path = ""
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_15" # wdr-user-search
            
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          }
        ]
      },
      user_signaturecheck = {
        parent_path     = "users"
        child_path      = "signature-check"
        grandchild_path = ""
        http_methods = [
          {
            method     = "DELETE"
            lambda_key = "lambda_151" # wdr-user-signature-delele
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          },
          {
            method     = "POST"
            lambda_key = "lambda_150" # wdr-user-signature-check-and-proccess
            
          }
        ]
      },
      user_toggle_status = {
        parent_path     = "users"
        child_path      = "toggle-status"
        grandchild_path = ""
        http_methods = [
          {
            method     = "OPTIONS"
            lambda_key = ""
          },
          {
            method     = "PUT"
            lambda_key = "lambda_104" # wdr-toggle-user-status
           
          }
          
        ]
      },
      
      user_service_login = {
        parent_path     = "users"
        child_path      = "service-login"
        grandchild_path = ""
        http_methods = [
          {
            method     = "OPTIONS"
            lambda_key = ""
          },
          {
            method     = "POST"
            lambda_key = "lambda_164" # wdr-login-service-user
            enable_auth = false
           
          }
          
        ]
      },

      user_services = {
        parent_path     = "users"
        child_path      = "services"
        grandchild_path = ""
        http_methods = [          
          {
            method     = "GET"
            lambda_key = "lambda_202" # wdr-service-users-get-all
          },

          {
            method     = "OPTIONS"
            lambda_key = ""
          }
          
        ]
      },

      user_change_password = {
        parent_path     = "users"
        child_path      = "change-password"
        grandchild_path = ""
        http_methods = [
          {
            method     = "OPTIONS"
            lambda_key = ""
          },
          {
            method     = "POST"
            lambda_key = "lambda_165" # wdr-change-password-service-user
           
          }
          
        ]
      },
      user_track_change_password = {
        parent_path     = "users"
        child_path      = "track-change-password"
        grandchild_path = ""
        http_methods = [
          {
            method     = "OPTIONS"
            lambda_key = ""
          },
          {
            method     = "PUT"
            lambda_key = "lambda_166" # wdr-track-password-changed
           
          }
          
        ]
      },
      user_export = {
        parent_path     = "users"
        child_path      = "export"
        grandchild_path = ""
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_170" # wdr-user-export           
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          }                    
        ]
      },
      usage_analytics = {
        parent_path     = "usage-analytics"
        child_path      = ""
        grandchild_path = ""
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_183" # wdr-get-usage-analytics           
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          },
          {
            method     = "POST"
            lambda_key = "lambda_184" # wdr-create-usage-analytics
          }                    
        ]
      },


      history = {
        parent_path     = "history"
        child_path      = ""
        grandchild_path = ""
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_4" # wdr-project-get-history
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          }
        ]
      },
      app_settings = {
        parent_path     = "app-settings"
        child_path      = ""
        grandchild_path = ""
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_74" # wdr-app-settings-get-all
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          }
        ]
      },
      app_settings_id = {
        parent_path     = "app-settings"
        child_path      = "{id}"
        grandchild_path = ""
        http_methods = [
          {
            method     = "DELETE"
            lambda_key = "lambda_75" # wdr-app-settings-delete-by-id
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          },
          {
            method     = "PUT"
            lambda_key = "lambda_76" # wdr-app-settings-update-by-id
          }
        ]
      },
      app_settings_code = {
        parent_path     = "app-settings"
        child_path      = "code"
        grandchild_path = ""
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_77" # wdr-app-settings-get-by-code-dev
            enable_auth = false
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          }
        ]
      },
      app_settings_limiteditor = {
        parent_path     = "app-settings"
        child_path      = "limit-editor"
        grandchild_path = ""
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_168" # wdr-app-settings-get-limit-editor
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          }
        ]
      },
      app_settings_passwordpolicy = {
        parent_path     = "app-settings"
        child_path      = "password-policy"
        grandchild_path = ""
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_143" # wdr-app-settings-get-password-policy
            enable_auth = false
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          }          
        ]
      },
      app_settings_updatebulk = {
        parent_path     = "app-settings"
        child_path      = "update-bulk"
        grandchild_path = ""
        http_methods = [
          {
            method     = "OPTIONS"
            lambda_key = ""
          },
          {
            method     = "PUT"
            lambda_key = "lambda_141" # wdr-app-settings-update-bulk
          }          
        ]
      },
      app_settings_updateprojectscheduler = {
        parent_path     = "app-settings"
        child_path      = "update-project-scheduler"
        grandchild_path = ""
        http_methods = [
          {
            method     = "OPTIONS"
            lambda_key = ""
          },
          {
            method     = "PUT"
            lambda_key = "lambda_78" # wdr-global-settings-project-schedule-update
          }          
        ]
      },
      app_settings_resetdefault = {
        parent_path     = "app-settings"
        child_path      = "reset-default"
        grandchild_path = ""
        http_methods = [
          {
            method     = "OPTIONS"
            lambda_key = ""
          },
          {
            method     = "PUT"
            lambda_key = "lambda_169" # wdr-app-settings-reset-to-default
          }          
        ]
      },
      
      dashboard = {
        parent_path     = "dashboard"
        child_path      = ""
        grandchild_path = ""
        http_methods = [
          {
            method     = "OPTIONS"
            lambda_key = ""
          }
        ]
      },
      dashboard_awrfraisedstats = {
        parent_path     = "dashboard"
        child_path      = "awrf-raised-stats"
        grandchild_path = ""
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_155" # wdr-awrf-raised-stats
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          }
        ]
      },
      dashboard_dashboardget = {
        parent_path     = "dashboard"
        child_path      = "dashboard-get"
        grandchild_path = ""
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_156" # wdr-dashboard-get
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          }
        ]
      },
      dashboard_projectprogresslist = {
        parent_path     = "dashboard"
        child_path      = "project-progress-list"
        grandchild_path = ""
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_157" # wdr-project-progress-list
          },
          {
            method     = "OPTIONS"
            lambda_key = ""
          }
        ]
      },
      be_error_log = {
        parent_path     = "be-error-log"
        child_path      = ""
        grandchild_path = ""
        http_methods = [
          {
            method     = "OPTIONS"
            lambda_key = ""
          },
          {
            method     = "POST"
            lambda_key = "lambda_69" # wdr-get-all-errors-log
          }          
        ]
      },
      database = {
        parent_path     = "database"
        child_path      = ""
        grandchild_path = ""
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_63" # wdr-view-database-schema
          }          
        ]
      },
      dynamic_values = {
        parent_path     = "dynamic-values"
        child_path      = ""
        grandchild_path = ""
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_68" # wdr-dynamic-values-search
          },
          {
            method     = "OPTIONS"
            lambda_key = "" 
          }          
        ]
      },
      dynamic_workflow  = {
        parent_path     = "dynamic-workflow"
        child_path      = ""
        grandchild_path = ""
        http_methods = [
          {
            method     = "OPTIONS"
            lambda_key = "" 
          }          
        ]
      },
      dynamic_workflow_get_step  = {
        parent_path     = "dynamic-workflow"
        child_path      = "get-step"
        grandchild_path = ""
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_65" #wdr-dynamic-wf-report-get
          },
          {
            method     = "OPTIONS"
            lambda_key = "" 
          }          
        ]
      },
      dynamic_workflow_report  = {
        parent_path     = "dynamic-workflow"
        child_path      = "report"
        grandchild_path = ""
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_111" #wdr-get-step-wf-history
          },
          {
            method     = "OPTIONS"
            lambda_key = "" 
          }          
        ]
      },
      dynamic_workflow_report_allversionhistoryapprover  = {
        parent_path     = "dynamic-workflow"
        child_path      = "report"
        grandchild_path = "all-version-history-approver"
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_112" #wdr-get-all-old-version-report
          },
          {
            method     = "OPTIONS"
            lambda_key = "" 
          }          
        ]
      },
      dynamic_workflow_report_approve  = {
         parent_path     = "dynamic-workflow"
         child_path      = "report"
         grandchild_path = "approve"
         http_methods = [
           {
             method     = "OPTIONS"
             lambda_key = "" 
           }, 
            {
             method     = "POST"
             lambda_key = "lambda_113" #wdr-approve-step-wf-history
           }                    
         ]
       },
       dynamic_workflow_report_compareprevious  = {
         parent_path     = "dynamic-workflow"
         child_path      = "report"
         grandchild_path = "compare-previous"
         http_methods = [
           {
             method     = "GET"
             lambda_key = "lambda_154" #wdr-get-report-with-previous-version
           },
           {
             method     = "OPTIONS"
             lambda_key = "" 
           } 
                                
         ]
       },
       dynamic_workflow_report_getnextapprove  = {
         parent_path     = "dynamic-workflow"
         child_path      = "report"
         grandchild_path = "get-next-approve"
         http_methods = [
           {
             method     = "GET"
             lambda_key = "lambda_114" #wdr-get-next-approver
           },
           {
             method     = "OPTIONS"
             lambda_key = "" 
           }
         ]
       },
       dynamic_workflow_report_reject  = {
         parent_path     = "dynamic-workflow"
         child_path      = "report"
         grandchild_path = "reject"
         http_methods = [
           {
             method     = "OPTIONS"
             lambda_key = "" 
           },
           {
             method     = "POST"
             lambda_key = "lambda_115" #wdr-reject-step-wf-history
           }
         ]
       },
      
       dynamic_workflow_report_reopenreview  = {
         parent_path     = "dynamic-workflow"
         child_path      = "report"
         grandchild_path = "reopen-review"
         http_methods = [
           {
             method     = "OPTIONS"
             lambda_key = "" 
           },
           {
             method     = "POST"
             lambda_key = "lambda_116" #wdr-reopen-complete-report
           }
         ]
       },
      
       dynamic_workflow_report_replaceprocessingapprover  = {
         parent_path     = "dynamic-workflow"
         child_path      = "report"
         grandchild_path = "replace-processing-approver"
         http_methods = [
           {
             method     = "GET"
             lambda_key = "lambda_117" #wdr-get-replace-processing-approver
           },
           {
             method     = "OPTIONS"
             lambda_key = "" 
           },
           {
             method     = "PUT"
             lambda_key = "lambda_118" #wdr-replace-processing-approver
           }
         ]
       },
       dynamic_workflow_report_submit  = {
         parent_path     = "dynamic-workflow"
         child_path      = "report"
         grandchild_path = "submit"
         http_methods = [
           {
             method     = "OPTIONS"
             lambda_key = "" 
           },
           {
             method     = "POST"
             lambda_key = "lambda_119" #wdr-submit-review-report
           }
         ]
       },
       dynamic_workflow_report_getstepbynumber  = {
        parent_path     = "dynamic-workflow"
        child_path      = "report"
        grandchild_path = "get-step-by-number"
        http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_174" # wdr-get-history-step-by-number
          },
          {
            method     = "OPTIONS"
            lambda_key = "" 
          }          
        ]
      },
      dynamic_workflow_report_submitandapprove  = {
        parent_path     = "dynamic-workflow"
        child_path      = "report"
        grandchild_path = "submit-and-approve"
        http_methods = [
          {
            method     = "OPTIONS"
            lambda_key = "" 
          },
          {
            method     = "POST"
            lambda_key = "lambda_173" # wdr-submit-and-approve-report
          }          
        ]
      },
       dynamic_workflow_updatestep  = {
         parent_path     = "dynamic-workflow"
         child_path      = "update-step"
         grandchild_path = ""
         http_methods = [
           {
             method     = "OPTIONS"
             lambda_key = "" 
           },
           {
             method     = "PUT"
             lambda_key = "lambda_120" #wdr-dynamic-wf-report-update
           }
         ]
       },

       health  = {
         parent_path     = "health"
         child_path      = "network"
         grandchild_path = ""
         http_methods = [           
           {
             method     = "GET"
             lambda_key = "lambda_200" #wdr-network-health-check
             enable_auth = false

           },
           {
             method     = "OPTIONS"
             lambda_key = "" 
           }
         ]
       },

       notifications  = {
         parent_path     = "notifications"
         child_path      = ""
         grandchild_path = ""
         http_methods = [
           {
             method     = "GET"
             lambda_key = "lambda_122" #wdr-notification-get-all
           },
           {
             method     = "OPTIONS"
             lambda_key = "" 
           },
           {
             method     = "POST"
             lambda_key = "lambda_129" #wdr-notification-send
           }
         ]
       },
       notifications_id  = {
         parent_path     = "notifications"
         child_path      = "{id}"
         grandchild_path = ""
         http_methods = [
           {
             method     = "DELETE"
             lambda_key = "lambda_126" #wdr-notification-delete
           },
           {
             method     = "OPTIONS"
             lambda_key = "" 
           }
         ]
       },
       notifications_id_read  = {
         parent_path     = "notifications"
         child_path      = "{id}"
         grandchild_path = "read"
         http_methods = [
           {
             method     = "OPTIONS"
             lambda_key = "" 
           },
           {
             method     = "PUT"
             lambda_key = "lambda_124" #wdr-notification-mark-read
           }
         ]
       },
       notifications_devicetokens  = {
         parent_path     = "notifications"
         child_path      = "device-tokens"
         grandchild_path = ""
         http_methods = [
           {
             method     = "OPTIONS"
             lambda_key = "" 
           },
           {
             method     = "POST"
             lambda_key = "lambda_127" #wdr-notification-register-device
           }
         ]
       },
       notifications_devicetokens_token  = {
         parent_path     = "notifications"
         child_path      = "device-tokens"
         grandchild_path = "{token}"
         http_methods = [
           {
             method     = "DELETE"
             lambda_key = "lambda_128" #wdr-notification-unregister-device
           },
           {
             method     = "OPTIONS"
             lambda_key = "" 
           }
         ]
       },
       notifications_readall  = {
         parent_path     = "notifications"
         child_path      = "read-all"
         grandchild_path = ""
         http_methods = [
           {
             method     = "OPTIONS"
             lambda_key = "" 
           },
           {
             method     = "PUT"
             lambda_key = "lambda_125" #wdr-notification-mark-read-all
           }
         ]
       },
       notifications_settings  = {
         parent_path     = "notifications"
         child_path      = "settings"
         grandchild_path = ""
         http_methods = [
           {
             method     = "GET"
             lambda_key = "lambda_132" #wdr-notification-settings-get
           },
           {
             method     = "OPTIONS"
             lambda_key = "" 
           },
           {
             method     = "PUT"
             lambda_key = "lambda_133" #wdr-notification-settings-update
           }
         ]
       },
       notifications_template  = {
         parent_path     = "notifications"
         child_path      = "template"
         grandchild_path = ""
         http_methods = [
           {
             method     = "GET"
             lambda_key = "lambda_135" #wdr-notification-template-get-all
           },
           {
             method     = "OPTIONS"
             lambda_key = "" 
           }
         ]
       },
       notifications_template_id  = {
         parent_path     = "notifications"
         child_path      = "template"
         grandchild_path = "{id}"
         http_methods = [
          {
            method     = "GET"
            lambda_key = "lambda_136"  #wdr-notification-template-get-by-id
          },
          {
            method     = "OPTIONS"
            lambda_key = "" 
          },
           {
             method     = "PUT"
             lambda_key = "lambda_137" #wdr-notification-template-update-by-id
           }           
         ]
       },
       notifications_unreadcount  = {
         parent_path     = "notifications"
         child_path      = "unread-count"
         grandchild_path = ""
         http_methods = [
           {
             method     = "GET"
             lambda_key = "lambda_123" #wdr-notification-get-unread-count
           },
           {
             method     = "OPTIONS"
             lambda_key = "" 
           }
         ]
       },
       offline_mode_notifications  = {
         parent_path     = "offline-mode"
         child_path      = "notifications"
         grandchild_path = ""
         http_methods = [
           {
             method     = "OPTIONS"
             lambda_key = "" 
           },
           {
             method     = "POST"
             lambda_key = "lambda_167" #wdr-register-silent-notifications 
           }
         ]
       },
       offline_mode_project_id  = {
         parent_path     = "offline-mode"
         child_path      = "project"
         grandchild_path = "{id}"
         http_methods = [
           {
             method     = "OPTIONS"
             lambda_key = "" 
           }
         ]
       },
       offline_mode_project_id_getofflinedatav2  = {
         parent_path     = "offline-mode"
         child_path      = "project"
         grandchild_path = "{id}"
         great_grandchild_path = "get-offline-data-v2"
         http_methods = [
           {
             method     = "GET"
             lambda_key = "lambda_160" #wdr-project-get-all-data-offline-v2
           },
           {
             method     = "OPTIONS"
             lambda_key = "" 
           }           
         ]
       },
       offline_mode_project_id_syncjobs  = {
         parent_path     = "offline-mode"
         child_path      = "project"
         grandchild_path = "{id}"
         great_grandchild_path = "sync-jobs"
         http_methods = [
           {
             method     = "OPTIONS"
             lambda_key = "" 
           },
           {
             method     = "PUT"
             lambda_key = "lambda_5" #wdr-sync-job
           }
           
         ]
       },
       offline_mode_project_id_syncreports  = {
         parent_path     = "offline-mode"
         child_path      = "project"
         grandchild_path = "{id}"
         great_grandchild_path = "sync-reports"
         http_methods = [
           {
             method     = "OPTIONS"
             lambda_key = "" 
           },
           {
             method     = "PUT"
             lambda_key = "lambda_88" #wdr-sync-report
           }
           
         ]
       },
       offline_mode_project_getlastupdatetime  = {
         parent_path     = "offline-mode"
         child_path      = "project"
         grandchild_path = "get-last-update-time"
         great_grandchild_path = ""
         http_methods = [
           {
             method     = "GET"
             lambda_key = "lambda_138" #wdr-project-last-update-time
           },
           {
             method     = "OPTIONS"
             lambda_key = "" 
           }                     
         ]
       },
       revoke_token  = {
         parent_path     = "revoke-token"
         child_path      = ""
         grandchild_path = ""
         http_methods = [
           {
             method     = "DELETE"
             lambda_key = "lambda_134" #wdr-revoke-token
           },
           {
             method     = "OPTIONS"
             lambda_key = "" 
           }
         ]
       },
       revoke_token_all  = {
         parent_path     = "revoke-token"
         child_path      = "all"
         grandchild_path = ""
         http_methods = [
           {
             method     = "DELETE"
             lambda_key = "lambda_149" #wdr-revoke-token-logout
           },
           {
             method     = "OPTIONS"
             lambda_key = "" 
           }
         ]
       },
    }
  }
}

# ========================================
# WEBSOCKET API GATEWAY
# ========================================
websocket_apis = {
  websocket_api_1 = {
    api_name              = "prod-wdr-maritimeapps-websocket-api"
    connect_lambda_key    = "lambda_144"
    disconnect_lambda_key = "lambda_145"
    route_selection_expression = "$request.body.action"
    stage_name            = "prod"
    enable_access_logs    = false  # CloudWatch logs enabled cho production (dễ debug và monitor). Set false nếu muốn tiết kiệm chi phí.
  }
}

cognito_user_pool_arn = "arn:aws:cognito-idp:us-east-2:797233058645:userpool/us-east-2_8h0ZVkQbm" 
enable_cognito_auth = true 
# ========================================
# LAMBDA@EDGE FUNCTIONS (MARKER-BASED)
# ========================================

# Marker-based Lambda@Edge configuration
cors_origins = [
  "https://d2o32ci9a5hhym.cloudfront.net",  # FE CloudFront domain TMA prod
  "https://dmwji128fkqvu.cloudfront.net",     # BE CloudFront domain (thay bằng domain thực tế)
  "http://localhost:4200",
  "http://localhost:8100",
  "http://localhost:8101",
  "http://localhost:*",
  "http://127.0.0.1:*",
  "https://vule-fe-source-bucket.s3.us-east-2.amazonaws.com",
  "https://vule-fe-source-bucket.s3.amazonaws.com",
  "https://vule-assets-bucket.s3.us-east-2.amazonaws.com",
  "https://vule-assets-bucket.s3.amazonaws.com",
  "http://vule-fe-source-bucket.s3-website-us-east-2.amazonaws.com",
  "http://vule-assets-bucket.s3-website-us-east-2.amazonaws.com"
]

csp_config = {
  s3_bucket_name          = "vule-fe-source-bucket"
  s3_region               = "us-east-2"
  api_cloudfront_domain   = ""
  cognito_region          = "us-east-2"
  cognito_user_pool_id    = "us-east-2_placeholder"
  s3_assets_bucket        = "vule-assets-bucket"
  additional_connect_src  = ""
  additional_img_src      = ""
}

# Lambda@Edge IAM Role ARN - Sử dụng chung role với Lambda functions thông thường
lambda_edge_role_arn = "arn:aws:iam::797233058645:role/prod_wdr_maritimeapps_deploy_app_lambda"

# ========================================
# STEP FUNCTIONS STATE MACHINES
# ========================================
# 


state_machines = {
  "project_export_workflow" = {
    state_machine_name = "prod-wdr-mapps-project-export-workflow"

    template_file = "state-machines/project-export-workflow.tpl.json"
    
    
    # Role này cần có trust policy cho "states.amazonaws.com" và permission "lambda:InvokeFunction"
    # Role đã có permission sẵn, không cần iam_policy_statements (variable có default = [])
    existing_role_arn = "arn:aws:iam::797233058645:role/prod_wdr_maritimeapps_deploy_app_lambda"
    
    # Optional: CloudWatch Logging
    enable_logging = true
    include_execution_data = true
    log_level = "ALL"  # Options: ALL, ERROR, FATAL, OFF
    
    # Optional: X-Ray Tracing
    enable_tracing = true
    
    # Optional: Additional tags
    additional_tags = {
      Purpose = "Project Export Workflow"
    }
  }
 

}
    
    # CÁCH 2: Viết definition trực tiếp (nếu muốn hardcode ARN)
    # definition_json = jsonencode({
  #   #   Comment = "Project Export Workflow"
  #   #   StartAt = "ParallelExports"
  #   #   States = {
  #   #     ParallelExports = {
  #   #       Type = "Parallel"
  #   #       Branches = [
  #   #         {
  #   #           StartAt = "ExportMetadata"
  #   #           States = {
  #   #             ExportMetadata = {
  #   #               Type = "Task"
  #   #               Resource = "arn:aws:lambda:us-east-2:797233058645:function:prod-wdr-mapps-project-export-metadata"
  #   #               End = true
  #   #             }
  #   #           }
  #   #         },
  #   #         {
  #   #           StartAt = "ExportJobList"
  #   #           States = {
  #   #             ExportJobList = {
  #   #               Type = "Task"
  #   #               Resource = "arn:aws:lambda:us-east-2:797233058645:function:prod-wdr-mapps-project-export-joblist"
  #   #               End = true
  #   #             }
  #   #           }
  #   #         },
  #   #         {
  #   #           StartAt = "GetJobsForExport"
  #   #           States = {
  #   #             GetJobsForExport = {
  #   #               Type = "Task"
  #   #               Resource = "arn:aws:lambda:us-east-2:797233058645:function:prod-wdr-mapps-project-get-jobs-for-export"
  #   #               Next = "ProcessJobsMap"
  #   #             },
  #   #             ProcessJobsMap = {
  #   #               Type = "Map"
  #   #               ItemsPath = "$.jobs"
  #   #               Iterator = {
  #   #                 StartAt = "ParallelJobProcessing"
  #   #                 States = {
  #   #                   ParallelJobProcessing = {
  #   #                     Type = "Parallel"
  #   #                     Branches = [
  #   #                       {
  #   #                         StartAt = "CopyJobResource"
  #   #                         States = {
  #   #                           CopyJobResource = {
  #   #                             Type = "Task"
  #   #                             Resource = "arn:aws:lambda:us-east-2:797233058645:function:prod-wdr-mapps-project-copy-job-export-resource"
  #   #                             End = true
  #   #                           }
  #   #                         }
  #   #                       },
  #   #                       {
  #   #                         StartAt = "ExportReportPDF"
  #   #                         States = {
  #   #                           ExportReportPDF = {
  #   #                             Type = "Task"
  #   #                             Resource = "arn:aws:lambda:us-east-2:797233058645:function:prod-wdr-mapps-pdf-generator"
  #   #                             End = true
  #   #                           }
  #   #                         }
  #   #                       }
  #   #                     ]
  #   #                     End = true
  #   #                   }
  #   #                 }
  #   #               }
  #   #               End = true
  #   #             }
  #   #           }
  #   #         }
  #   #       ]
  #   #       Next = "CombineExports"
  #   #     },
  #   #     CombineExports = {
  #   #       Type = "Task"
  #   #       Resource = "arn:aws:lambda:us-east-2:797233058645:function:prod-wdr-mapps-project-combine-exports"
  #   #       Next = "ClearAndUpdateDatabase"
  #   #     },
  #   #     ClearAndUpdateDatabase = {
  #   #       Type = "Task"
  #   #       Resource = "arn:aws:lambda:us-east-2:797233058645:function:prod-wdr-mapps-project-update-database"
  #   #       End = true
  #   #     }
  #   #   }
  #   # })
  #   
  #   # CÁCH 3: Sử dụng file definition (nếu đã export từ AWS Console)
  #   # definition_file = "devops/env/prod/state-machines/project-export-workflow-fixed.json"
    
    # IAM Role Configuration cho State Machine
    # 
    # ⚠️ QUAN TRỌNG: Đây là 2 loại IAM policy KHÁC NHAU:
    #
    # 1. IAM Policy cho USER/ROLE của bạn (acc lqvu2):
    #    - Quyền: states:CreateStateMachine, iam:CreateRole, iam:PutRolePolicy, ...
    #    - Dùng để: Chạy Terraform hoặc tạo state machine trên web UI
    #    - Đã có sẵn trong account của bạn (bạn đã test tạo trên web UI thành công)
    #
    # 2. IAM Policy cho STATE MACHINE ROLE (iam_policy_statements bên dưới):
    #    - Quyền: lambda:InvokeFunction
    #    - Dùng để: State Machine invoke Lambda functions khi chạy workflow
    #    - Đây là policy attach vào role của State Machine (KHÔNG phải role của bạn)
    #
    # Vậy: iam_policy_statements ở đây là policy cho STATE MACHINE ROLE, 
    #      KHÔNG phải policy cho user/role của bạn!
    
    # Option 1: Reuse role đã có từ web UI (nếu bạn đã tạo state machine trên web UI)
    # existing_role_arn = "arn:aws:iam::797233058645:role/prod-wdr-mapps-project-export-workflow-role"
    # (Nếu dùng existing_role_arn, KHÔNG CẦN iam_policy_statements vì role đã có policy rồi)
    
    # Option 2: Tạo role mới cho State Machine (khuyến nghị)
    