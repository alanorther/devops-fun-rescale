resource "aws_db_instance" "postgres_rds" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgres"
  backup_retention_period   = 5
  engine_version       = "9.6"
  instance_class       = "db.t2.micro"
  name                 = "rescale"
  identifier           = "rescale"
  username             = "postgres"
  password             = var.db_password
  apply_immediately         = true
  final_snapshot_identifier = "rescale-postgres-backup"
  skip_final_snapshot  = true
}
