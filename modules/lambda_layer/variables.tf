variable "layer_name" {
  description = "Name of the Lambda Layer"
  type        = string
}

variable "compatible_runtimes" {
  description = "List of runtimes compatible with this layer"
  type        = list(string)
}

variable "filename" {
  description = "Path to the layer zip file"
  type        = string
}

variable "description" {
  description = "Description of the layer"
  type        = string
  default     = ""
}

variable "s3_bucket" {
  description = "S3 bucket chứa file zip layer"
  type        = string
}

variable "s3_key" {
  description = "S3 key của file zip layer"
  type        = string
}

variable "dummy_s3_key" {
  description = "S3 key của dummy.zip layer (dùng khi file thật chưa có trong S3). Nếu null, sẽ tự động dùng 'placeholder-files/layer-placeholder.zip'"
  type        = string
  default     = "placeholder-files/layer-placeholder.zip"  # Default path cho dummy.zip
}

variable "skip_destroy" {
  description = "Skip destroying layer version when updating"
  type        = bool
  default     = false
}

variable "layer_version" {
  description = "Version của layer (optional)"
  type        = string
  default     = "latest"
}

# Removed unused variables: manual_version, include_version_in_name, tags

# Optional: Uncomment nếu muốn Terraform quản lý code (không cho CICD update)
# variable "cicd_managed_code" {
#   description = "If true, CICD will manage layer code updates. Terraform will ignore changes to source_code_hash and s3_key. If false, Terraform will manage code updates."
#   type        = bool
#   default     = true  # Default = true để CICD có thể update code
# }

variable "create_layer" {
  description = "If false, Terraform will not create new layer version. Only use data source to get latest version. Use this when layer already exists and you only want CICD to update code."
  type        = bool
  default     = false
} 