#phan update moi cho DB
# root/modules/module_sqs_s3_db/db.tf
locals {
  cluster_identifier_to_key = {
    for k, v in var.rds_clusters : v.cluster_identifier => k
  }
}

resource "aws_rds_cluster_parameter_group" "this" {
  name        = var.db_cluster_parameter_group_name != null ? var.db_cluster_parameter_group_name : "${var.environment}-wdr-maritimeapps-aurora17-nonssl"
  family      = "aurora-postgresql17"
  description = "Aurora PostgreSQL 17 non-SSL parameter group for ${var.environment}"

  parameter {
    name  = "rds.force_ssl"
    value = "0"
  }
}

resource "aws_rds_cluster" "this" {
  for_each = var.rds_clusters

  engine                  = each.value.engine
  engine_version          = each.value.engine_version
  master_username         = each.value.master_username
  master_password         = each.value.master_password
  database_name           = each.value.database_name
  cluster_identifier      = each.value.cluster_identifier
  skip_final_snapshot     = true

  # Thêm block này cho Serverless v2
      serverlessv2_scaling_configuration {
      min_capacity = 0.5
      max_capacity = 2.0
    }
  lifecycle {
    prevent_destroy = false
    ignore_changes = all
  }

  # Network configuration
  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = each.value.vpc_security_group_ids
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.this.name
  # tags = {
  #   Name = "${var.owner}_${var.application}_${var.environment}"
  # }
}

resource "aws_rds_cluster_instance" "this" {
  for_each = var.rds_instances

  cluster_identifier = each.value.cluster_identifier
  instance_class     = each.value.instance_class
  identifier         = each.value.identifier
  publicly_accessible = false   # change to true later
  engine             = aws_rds_cluster.this[local.cluster_identifier_to_key[each.value.cluster_identifier]].engine
  engine_version     = aws_rds_cluster.this[local.cluster_identifier_to_key[each.value.cluster_identifier]].engine_version

  depends_on = [aws_rds_cluster.this]
  # tags = {
  #   Name = "${var.owner}_${var.application}_${var.environment}"
  # }
}





#cai nay cu de can revert lai khi can
# locals {
#   cluster_identifier_to_key = {
#     for k, v in var.rds_clusters : v.cluster_identifier => k
#   }
# }

# resource "aws_rds_cluster" "this" {
#   for_each = var.rds_clusters

#   engine                  = each.value.engine
#   engine_version          = each.value.engine_version
# #   allocated_storage       = each.value.storage
#   master_username         = each.value.master_username
#   master_password         = each.value.master_password
#   database_name           = each.value.database_name
#   # vpc_security_group_ids  = each.value.vpc_security_group_ids
#   skip_final_snapshot     = true
#   cluster_identifier      = each.value.cluster_identifier

# }

# resource "aws_rds_cluster_instance" "this" {
#   for_each            = var.rds_instances
#   cluster_identifier  = each.value.cluster_identifier
#   instance_class      = each.value.instance_class
#   identifier          = each.value.identifier
#   engine              = aws_rds_cluster.this[local.cluster_identifier_to_key[each.value.cluster_identifier]].engine
# }






