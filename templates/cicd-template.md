# CI/CD Template for Lambda Projects

## 🎯 Overview

This template provides a reusable CI/CD setup for Lambda functions and layers deployment. It can be adapted for any project with similar structure.

## 📁 Project Structure

```
PROJECT_NAME/
├── .github/workflows/
│   └── lambda-deploy.yml          # GitHub Actions workflow
├── devops/
│   ├── scripts/
│   │   └── deploy-lambda.sh       # Deployment script
│   ├── buildspec.yml              # CodeBuild configuration
│   └── env/
│       ├── prod/                  # Production environment
│       └── uat/                   # UAT environment
├── BE_sourceCodes/
│   └── backend-services/          # Lambda source code
│       ├── functions/             # Lambda functions
│       └── layers/                # Lambda layers
└── templates/
    └── cicd-template.md          # This template
```

## 🔧 Setup Instructions

### **1. Copy Template Files**

```bash
# Copy the template files to your project
cp templates/cicd-template.md ../YOUR_PROJECT/devops/
cp .github/workflows/lambda-deploy.yml ../YOUR_PROJECT/devops/.github/workflows/
cp scripts/deploy-lambda.sh ../YOUR_PROJECT/devops/scripts/
cp buildspec.yml ../YOUR_PROJECT/devops/
```

### **2. Customize for Your Project**

#### **Update GitHub Actions Workflow**

Replace these variables in `.github/workflows/lambda-deploy.yml`:

```yaml
# Change these paths to match your project structure
paths:
  - 'YOUR_PROJECT/BE_sourceCodes/backend-services/functions/**'
  - 'YOUR_PROJECT/BE_sourceCodes/backend-services/layers/**'
  - 'YOUR_PROJECT/devops/**'

# Update project name
env:
  PROJECT_NAME: 'YOUR_PROJECT'
```

#### **Update Deployment Script**

Replace these variables in `scripts/deploy-lambda.sh`:

```bash
# Update project name
PROJECT_NAME="YOUR_PROJECT"

# Update default paths
BACKEND_SERVICES_PATH="../BE_sourceCodes/backend-services"
OUTPUT_PATH="../../zipped-functions-layers-YOURPROJECT"
```

#### **Update CodeBuild Configuration**

Replace these variables in `buildspec.yml`:

```bash
# Update project name
export PROJECT_NAME="YOUR_PROJECT"

# Update output directory
mkdir -p ../../zipped-functions-layers-YOURPROJECT/layers
```

### **3. Configure Environment Variables**

#### **GitHub Actions Secrets**

Add these secrets to your GitHub repository:

```bash
AWS_ACCESS_KEY_ID=your_aws_access_key
AWS_SECRET_ACCESS_KEY=your_aws_secret_key
S3_BUCKET=your-s3-bucket-name
```

#### **CodeBuild Environment Variables**

Add these environment variables to your CodeBuild project:

```bash
ENVIRONMENT=prod
S3_BUCKET=your-s3-bucket-name
DEPLOY_FUNCTIONS=function1,function2
DEPLOY_LAYERS=layer1,layer2
APPLY_CHANGES=true
```

### **4. Test the Setup**

```bash
# Test local deployment
cd YOUR_PROJECT/devops
chmod +x scripts/deploy-lambda.sh
./scripts/deploy-lambda.sh --bucket your-bucket --functions "test-function" --no-apply
```

## 🚀 Usage Examples

### **GitHub Actions**

**Automatic Deployment:**
```bash
# Push changes to trigger deployment
git add .
git commit -m "Update lambda function"
git push origin main
```

**Manual Deployment:**
1. Go to GitHub → Actions → "Lambda Deployment"
2. Click "Run workflow"
3. Select environment and targets

### **CodeBuild**

```bash
# Start build manually
aws codebuild start-build --project-name your-project-lambda-deployment

# Start build with specific functions
aws codebuild start-build \
  --project-name your-project-lambda-deployment \
  --environment-variables-override \
    name=DEPLOY_FUNCTIONS,value="function1,function2"
```

### **Local Script**

```bash
# Deploy specific functions
./scripts/deploy-lambda.sh \
  --bucket your-bucket \
  --functions "function1,function2"

# Deploy to UAT
./scripts/deploy-lambda.sh \
  --environment uat \
  --bucket your-uat-bucket \
  --functions "function1"
```

## 📋 Customization Options

### **File Naming Convention**

Customize the naming convention in all files:

```bash
# Functions
# Source: backend-services/functions/{function-name}/
# Zip: {prefix}-{function-name}.zip
# S3: {environment}/release2.0/{date}/{prefix}-{function-name}.zip

# Layers  
# Source: backend-services/layers/{layer-name}/
# Zip: {prefix}-{layer-name}-layer.zip
# S3: {environment}/release2.0/{date}/layers/{prefix}-{layer-name}-layer.zip
```

### **Terraform Integration**

Update the Terraform configuration update logic in:

1. **GitHub Actions workflow** (step: "Update Terraform configuration")
2. **Deployment script** (section: "Update Terraform configuration")
3. **CodeBuild buildspec** (post_build phase)

### **S3 Path Structure**

Customize S3 path structure:

```bash
# Default: {environment}/release2.0/{date}/
# Custom: {environment}/{project}/{version}/{date}/
```

## 🔍 Monitoring & Troubleshooting

### **Common Issues**

1. **Path Mismatch**: Ensure all paths match your project structure
2. **Permission Issues**: Check AWS credentials and S3 bucket permissions
3. **Terraform Errors**: Validate terraform configuration manually
4. **Build Failures**: Check function dependencies and Node.js version

### **Debug Commands**

```bash
# Check AWS credentials
aws sts get-caller-identity

# Validate Terraform
cd YOUR_PROJECT/devops/env/prod
terraform validate

# Test local build
./scripts/deploy-lambda.sh --bucket test-bucket --functions "test-function" --no-apply
```

## 📊 Benefits

- ✅ **Reusable**: Easy to adapt for any project
- ✅ **Consistent**: Same structure across all projects
- ✅ **Maintainable**: Centralized configuration
- ✅ **Flexible**: Multiple deployment options
- ✅ **Scalable**: Works for small and large projects

## 🆘 Support

### **Template Variables**

Replace these placeholders in your project:

| Placeholder | Description | Example |
|-------------|-------------|---------|
| `YOUR_PROJECT` | Project name | `KSL_PROD`, `TMA_UAT` |
| `your-bucket` | S3 bucket name | `my-lambda-bucket` |
| `your-aws-key` | AWS access key | `AKIA...` |
| `your-aws-secret` | AWS secret key | `wJalr...` |

### **Validation Checklist**

- [ ] All paths updated to match project structure
- [ ] Project name updated in all files
- [ ] S3 bucket name configured
- [ ] AWS credentials set up
- [ ] Terraform configuration validated
- [ ] Test deployment successful

---

**Need help?** Check the troubleshooting section or review the logs for specific error messages.
