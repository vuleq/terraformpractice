# Hướng Dẫn Tạo State Machine Mới

## Tổng Quan

Để tạo một State Machine mới, bạn cần:
1. ✅ Đảm bảo Lambda functions đã được định nghĩa trong `infra.tfvars`
2. ✅ Tạo template file hoặc viết definition JSON
3. ✅ Thêm config vào `infra.tfvars`
4. ✅ Chạy Terraform

---

## Các Bước Chi Tiết

### Bước 1: Kiểm tra Lambda Functions

Đảm bảo các Lambda functions bạn muốn dùng đã được định nghĩa trong `infra.tfvars`:

```hcl
lambda_definitions = {
  lambda_xxx = {
    function_name = "prod-wdr-your-function-name"
    # ... config khác
  }
  # ...
}
```

**Lưu ý:** Ghi nhớ `function_name` của các Lambda để dùng trong State Machine definition.

---

### Bước 2: Tạo State Machine Definition

Có **2 cách** để tạo definition:

#### **Cách 1: Sử dụng Template File (KHUYẾN NGHỊ)**

**Ưu điểm:** ARN tự động lấy từ Lambda functions, không cần hardcode

**Các bước:**

1. **Tạo template file** trong `devops/env/prod/state-machines/`:
   - Tên file: `your-workflow-name.tpl.json`
   - Sử dụng placeholders: `${lambda_arn_1}`, `${lambda_arn_2}`, ...

**Ví dụ:** `state-machines/my-new-workflow.tpl.json`
```json
{
  "Comment": "My New Workflow",
  "StartAt": "StartState",
  "States": {
    "StartState": {
      "Type": "Task",
      "Resource": "${my_lambda_arn}",
      "End": true
    }
  }
}
```

2. **Cập nhật `main.tf`** để map ARN vào template (nếu cần Lambda mới):
   - Tìm phần `templatefile()` trong `module "state_machines"`
   - Thêm mapping cho Lambda mới:
   ```hcl
   templatefile(
     "${path.module}/${each.value.template_file}",
     {
       my_lambda_arn = local.lambda_name_to_arn["prod-wdr-your-function-name"]
       # ... các Lambda khác
     }
   )
   ```

#### **Cách 2: Viết Definition Trực Tiếp**

**Ưu điểm:** Không cần tạo file riêng, viết trực tiếp trong `infra.tfvars`

**Ví dụ:**
```hcl
definition_json = jsonencode({
  Comment = "My New Workflow"
  StartAt = "StartState"
  States = {
    StartState = {
      Type = "Task"
      Resource = "arn:aws:lambda:ap-southeast-1:797233058645:function:prod-wdr-your-function-name"
      End = true
    }
  }
})
```

**Lưu ý:** Với cách này, bạn cần hardcode ARN hoặc dùng `local.lambda_name_to_arn` trong Terraform expression (phức tạp hơn).

---

### Bước 3: Thêm Config vào `infra.tfvars`

Thêm entry mới vào `state_machines` trong `infra.tfvars`:

```hcl
state_machines = {
  # State Machine hiện có
  "project_export_workflow" = {
    # ... config hiện có
  }
  
  # State Machine mới của bạn
  "my_new_workflow" = {
    state_machine_name = "prod-wdr-my-new-workflow"
    
    # Option 1: Dùng template file (khuyến nghị)
    template_file = "state-machines/my-new-workflow.tpl.json"
    
    # Option 2: Hoặc viết definition trực tiếp
    # definition_json = jsonencode({ ... })
    
    # IAM Policy - cho phép State Machine invoke Lambda
    iam_policy_statements = [
      {
        Effect = "Allow"
        Action = ["lambda:InvokeFunction"]
        Resource = [
          "arn:aws:lambda:ap-southeast-1:797233058645:function:prod-wdr-*"
        ]
      }
    ]
    
    # Optional: CloudWatch Logging
    enable_logging = true
    log_group_arn = "arn:aws:logs:ap-southeast-1:797233058645:log-group:/aws/vendedlogs/states/prod-wdr-my-new-workflow"
    include_execution_data = true
    log_level = "ALL"
    
    # Optional: X-Ray Tracing
    enable_tracing = true
    
    # Optional: Additional tags
    additional_tags = {
      Purpose = "My New Workflow"
    }
  }
}
```

---

### Bước 4: Chạy Terraform

```bash
cd vule_tma_prod_1_0_4/devops/env/prod

# Validate config
terraform validate

# Xem plan
terraform plan -var-file="infra.tfvars"

# Apply
terraform apply -var-file="infra.tfvars"
```

---

## Ví Dụ Hoàn Chỉnh

### Ví dụ: Tạo State Machine đơn giản với 2 Lambda

**1. Lambda functions đã có:**
```hcl
lambda_definitions = {
  lambda_100 = {
    function_name = "prod-wdr-step-1"
    # ...
  }
  lambda_101 = {
    function_name = "prod-wdr-step-2"
    # ...
  }
}
```

**2. Tạo template file:** `state-machines/simple-workflow.tpl.json`
```json
{
  "Comment": "Simple Two-Step Workflow",
  "StartAt": "Step1",
  "States": {
    "Step1": {
      "Type": "Task",
      "Resource": "${step1_arn}",
      "Next": "Step2"
    },
    "Step2": {
      "Type": "Task",
      "Resource": "${step2_arn}",
      "End": true
    }
  }
}
```

**3. Cập nhật `main.tf`** (trong `templatefile()`):
```hcl
templatefile(
  "${path.module}/${each.value.template_file}",
  {
    # ... các ARN hiện có
    step1_arn = local.lambda_name_to_arn["prod-wdr-step-1"]
    step2_arn = local.lambda_name_to_arn["prod-wdr-step-2"]
  }
)
```

**4. Thêm vào `infra.tfvars`:**
```hcl
state_machines = {
  "simple_workflow" = {
    state_machine_name = "prod-wdr-simple-workflow"
    template_file = "state-machines/simple-workflow.tpl.json"
    
    iam_policy_statements = [
      {
        Effect = "Allow"
        Action = ["lambda:InvokeFunction"]
        Resource = ["arn:aws:lambda:ap-southeast-1:797233058645:function:prod-wdr-*"]
      }
    ]
    
    enable_logging = true
    enable_tracing = true
  }
}
```

---

## Checklist

Trước khi chạy Terraform, đảm bảo:

- [ ] Lambda functions đã được định nghĩa trong `infra.tfvars`
- [ ] Template file đã được tạo (nếu dùng template) hoặc definition JSON đã viết
- [ ] ARN mapping đã được thêm vào `main.tf` (nếu dùng template với Lambda mới)
- [ ] Config đã được thêm vào `state_machines` trong `infra.tfvars`
- [ ] IAM policy statements đã được cấu hình
- [ ] Log group ARN đã được tạo (nếu enable logging)

---

## Troubleshooting

### Lỗi: "Lambda function not found"
- Kiểm tra `function_name` trong Lambda definition có đúng không
- Đảm bảo Lambda đã được tạo trước khi tạo State Machine

### Lỗi: "Value is not a valid resource ARN"
- Kiểm tra ARN format trong definition
- Nếu dùng template, đảm bảo ARN đã được inject đúng

### Lỗi: "Missing resource instance key"
- Đã được fix trong `outputs.tf`, không cần lo lắng

---

## Tài Liệu Tham Khảo

- Xem `STATE_MACHINE_SETUP_GUIDE.md` để biết chi tiết về setup ban đầu
- Xem `project-export-workflow.tpl.json` để tham khảo template phức tạp
- AWS Step Functions ASL Documentation: https://docs.aws.amazon.com/step-functions/latest/dg/concepts-amazon-states-language.html

