# Hướng Dẫn Setup State Machine với Lambda Functions

## Tổng Quan

Bạn đã tạo 7 lambda functions mới (lambda_185 đến lambda_191) và muốn sử dụng chúng trong State Machine. Module đã được cấu hình để tự động map ARN từ các lambda functions này.

## Các Lambda Functions

- **lambda_185**: `prod-wdr-mapps-project-export-metadata`
- **lambda_186**: `prod-wdr-mapps-project-export-joblist`
- **lambda_187**: `prod-wdr-mapps-project-get-jobs-for-export`
- **lambda_188**: `prod-wdr-mapps-project-copy-job-export-resource`
- **lambda_189**: `prod-wdr-mapps-pdf-generator`
- **lambda_190**: `prod-wdr-mapps-project-combine-exports`
- **lambda_191**: `prod-wdr-mapps-project-update-database`

## Các Bước Setup

### Cách 1: Tạo bằng Terraform Code (KHUYẾN NGHỊ - Infrastructure as Code)

**Ưu điểm:**
- ✅ An toàn: Tất cả config trong code, có version control
- ✅ Dễ maintain: Thay đổi workflow chỉ cần update code
- ✅ Reproducible: Có thể deploy lại ở bất kỳ môi trường nào
- ✅ Review được: Team có thể review code trước khi apply

**Cách làm:**

Viết definition trực tiếp trong `infra.tfvars` sử dụng `definition_json`:

```hcl
state_machines = {
  "project_export_workflow" = {
    state_machine_name = "prod-wdr-project-export-workflow"
    
    # Viết definition trực tiếp trong Terraform (khuyến nghị)
    definition_json = jsonencode({
      Comment = "Project Export Workflow - Export metadata, jobs, and generate PDFs"
      StartAt = "ParallelExports"
      States = {
        ParallelExports = {
          Type = "Parallel"
          Branches = [
            {
              StartAt = "ExportMetadata"
              States = {
                ExportMetadata = {
                  Type = "Task"
                  Resource = "arn:aws:lambda:ap-southeast-1:797233058645:function:prod-wdr-mapps-project-export-metadata"
                  End = true
                }
              }
            },
            {
              StartAt = "ExportJobList"
              States = {
                ExportJobList = {
                  Type = "Task"
                  Resource = "arn:aws:lambda:ap-southeast-1:797233058645:function:prod-wdr-mapps-project-export-joblist"
                  End = true
                }
              }
            },
            {
              StartAt = "GetJobsForExport"
              States = {
                GetJobsForExport = {
                  Type = "Task"
                  Resource = "arn:aws:lambda:ap-southeast-1:797233058645:function:prod-wdr-mapps-project-get-jobs-for-export"
                  Next = "ProcessJobsMap"
                },
                ProcessJobsMap = {
                  Type = "Map"
                  ItemsPath = "$.jobs"
                  MaxConcurrency = 10
                  Iterator = {
                    StartAt = "ParallelJobProcessing"
                    States = {
                      ParallelJobProcessing = {
                        Type = "Parallel"
                        Branches = [
                          {
                            StartAt = "CopyJobResource"
                            States = {
                              CopyJobResource = {
                                Type = "Task"
                                Resource = "arn:aws:lambda:ap-southeast-1:797233058645:function:prod-wdr-mapps-project-copy-job-export-resource"
                                End = true
                              }
                            }
                          },
                          {
                            StartAt = "ExportReportPDF"
                            States = {
                              ExportReportPDF = {
                                Type = "Task"
                                Resource = "arn:aws:lambda:ap-southeast-1:797233058645:function:prod-wdr-mapps-pdf-generator"
                                End = true
                              }
                            }
                          }
                        ]
                        End = true
                      }
                    }
                  }
                  End = true
                }
              }
            }
          ]
          Next = "CombineExports"
        },
        CombineExports = {
          Type = "Task"
          Resource = "arn:aws:lambda:ap-southeast-1:797233058645:function:prod-wdr-mapps-project-combine-exports"
          Next = "ClearAndUpdateDatabase"
        },
        ClearAndUpdateDatabase = {
          Type = "Task"
          Resource = "arn:aws:lambda:ap-southeast-1:797233058645:function:prod-wdr-mapps-project-update-database"
          End = true
        }
      }
    })
    
    # IAM Policy - cho phép invoke các lambda functions
    iam_policy_statements = [
      {
        Effect = "Allow"
        Action = [
          "lambda:InvokeFunction"
        ]
        Resource = [
          "arn:aws:lambda:ap-southeast-1:797233058645:function:prod-wdr-mapps-*"
        ]
      }
    ]
    
    # Optional: CloudWatch Logging
    enable_logging = true
    log_group_arn = "arn:aws:logs:ap-southeast-1:797233058645:log-group:/aws/vendedlogs/states/prod-wdr-project-export-workflow"
    include_execution_data = true
    log_level = "ALL"
    
    # Optional: X-Ray Tracing
    enable_tracing = true
    
    additional_tags = {
      Purpose = "Project Export Workflow"
    }
  }
}
```

### Cách 2: Tạo trên AWS Console rồi Import (Tùy chọn)

Nếu bạn muốn design workflow trên UI trước:

1. Vào AWS Step Functions Console
2. Tạo State Machine mới
3. Design workflow với các Lambda functions
4. Export definition (JSON format)
5. Fix ARN bằng script helper (xem bước 2 bên dưới)
6. Sử dụng `definition_file` trong Terraform

### Bước 2: Fix ARN trong Definition File (Chỉ cần nếu dùng Cách 2)

**Chỉ cần bước này nếu bạn export từ AWS Console**

Khi export từ AWS Console, các Resource ARN có thể không đúng format. Sử dụng script helper để fix:

```powershell
cd vule_tma_prod_1_0_4\devops\env\prod

.\..\..\scripts\fix-state-machine-arns.ps1 `
  -DefinitionFile "state-machines/project-export-workflow.json" `
  -OutputFile "state-machines/project-export-workflow-fixed.json" `
  -AccountId "797233058645" `
  -Region "ap-southeast-1"
```

Script sẽ:
- Tự động replace các placeholder (REGION, ACCOUNT)
- Tạo ARN từ function name nếu chưa có ARN
- Giữ nguyên ARN đã đúng format

### Bước 3: Cấu hình trong `infra.tfvars`

Uncomment và cập nhật phần `state_machines`:

```hcl
state_machines = {
  "project_export_workflow" = {
    state_machine_name = "prod-wdr-project-export-workflow"
    
    # Sử dụng file definition đã fix
    definition_file = "devops/env/prod/state-machines/project-export-workflow-fixed.json"
    
    # IAM Policy - cho phép invoke các lambda functions
    iam_policy_statements = [
      {
        Effect = "Allow"
        Action = [
          "lambda:InvokeFunction"
        ]
        Resource = [
          "arn:aws:lambda:ap-southeast-1:797233058645:function:prod-wdr-mapps-*"
        ]
      }
    ]
    
    # Optional: CloudWatch Logging
    enable_logging = true
    log_group_arn = "arn:aws:logs:ap-southeast-1:797233058645:log-group:/aws/vendedlogs/states/prod-wdr-project-export-workflow"
    include_execution_data = true
    log_level = "ALL"
    
    # Optional: X-Ray Tracing
    enable_tracing = true
    
    additional_tags = {
      Purpose = "Project Export Workflow"
    }
  }
}
```

### Bước 4: Chạy Terraform

```bash
# Init (nếu chưa)
terraform init

# Plan để kiểm tra
terraform plan -var-file="infra.tfvars"

# Apply
terraform apply -var-file="infra.tfvars"
```

## Tính An Toàn và Best Practices

### ✅ Tại sao viết bằng Terraform code an toàn hơn?

1. **Version Control**: Tất cả config trong Git, có thể track changes
2. **Review Process**: Team có thể review code trước khi apply
3. **Reproducible**: Có thể deploy lại ở bất kỳ môi trường nào
4. **Rollback**: Dễ dàng rollback về version cũ
5. **Documentation**: Code là documentation tốt nhất
6. **CI/CD Integration**: Có thể integrate vào pipeline tự động

### ⚠️ Lưu ý khi tạo trên Web UI

- Không có version control
- Khó track changes
- Không thể review trước khi apply
- Khó reproduce ở môi trường khác

**Khuyến nghị**: Chỉ dùng Web UI để design/prototype, sau đó copy definition vào Terraform code.

## Lưu Ý Quan Trọng

### ARN Format

Trong definition (dù là `definition_json` hay `definition_file`), Resource ARN phải đúng format:
```
arn:aws:lambda:ap-southeast-1:797233058645:function:FUNCTION_NAME
```

**KHÔNG** sử dụng:
- Function name đơn giản: `prod-wdr-mapps-project-export-metadata` ❌
- Placeholder: `arn:aws:lambda:REGION:ACCOUNT:function:name` ❌
- Lambda key: `lambda_185` ❌

**PHẢI** sử dụng:
- Full ARN: `arn:aws:lambda:ap-southeast-1:797233058645:function:prod-wdr-mapps-project-export-metadata` ✅

### Auto ARN Mapping

Module tự động tạo mapping từ:
- Lambda key → ARN (ví dụ: `lambda_185` → ARN)
- Function name → ARN (ví dụ: `prod-wdr-mapps-project-export-metadata` → ARN)

Tuy nhiên, trong definition, bạn vẫn cần sử dụng **full ARN**.

## Troubleshooting

### Lỗi: "Value is not a valid resource ARN"

**Nguyên nhân**: ARN trong definition không đúng format

**Giải pháp**:
1. Kiểm tra tất cả `Resource` fields trong definition
2. Đảm bảo ARN đúng format: `arn:aws:lambda:REGION:ACCOUNT:function:NAME`
3. Sử dụng script helper để fix tự động

### Lỗi: "Lambda function not found"

**Nguyên nhân**: Lambda function chưa được tạo hoặc tên không đúng

**Giải pháp**:
1. Chạy `terraform apply` để tạo lambda functions trước
2. Kiểm tra function names trong `infra.tfvars`
3. Đảm bảo ARN trong definition match với function names

## Ví Dụ Definition File

Xem file `infra.tfvars` phần `state_machines` để có ví dụ definition JSON đầy đủ.

