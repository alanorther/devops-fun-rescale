resource "aws_db_instance" "postgres_rds" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "9.6"
  instance_class       = "db.t2.micro"
  name                 = "rescale"
  username             = "postgres"
  password             = var.db_password
}
