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
dummy_lambda_code_bucket = "vule-s3-store-tfstates"
dummy_lambda_code_key    = "dummy/lambda-placeholder.zip"



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
# sqs_queues commented out - chỉ tạo 2 lambda functions để test
sqs_queues = {}

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
apis = {}

# ========================================
# WEBSOCKET API GATEWAY
# ========================================
websocket_apis = {}

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
    