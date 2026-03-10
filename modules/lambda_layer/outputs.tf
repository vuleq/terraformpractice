# Latest version ARN từ AWS (cho CICD-managed layers)
# Khi CICD publish version mới, output này sẽ trả về version mới nhất
# Dùng output này trong available_layers để Lambda tự động dùng latest version
output "layer_arn_latest" {
  description = "Latest layer version ARN from AWS. Use this for CICD-managed layers to auto-update to latest version."
  value       = local.latest_layer_arn
} 