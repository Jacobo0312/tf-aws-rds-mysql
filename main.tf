provider "aws" {
  region     = "us-west-2"
  access_key = var.access_key
  secret_key = var.secret_key
}

# Security Group
resource "aws_security_group" "sg_mysql" {
  name        = "sg_mysql"
  description = "Allow MySQL inbound traffic"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# RDS Instance - MySQL

resource "aws_db_instance" "mysql" {
  engine            = "mysql"
  engine_version    = "5.7"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  storage_type      = "gp2"
  identifier        = "mysql-instance"
  db_name           = "test"


  username = "admin"
  password = "92V0w1Mn0n3g"

  skip_final_snapshot          = true
  multi_az                     = false
  backup_retention_period      = 0
  delete_automated_backups     = true
  publicly_accessible          = true
  performance_insights_enabled = false

  vpc_security_group_ids = [aws_security_group.sg_mysql.id]


  tags = {
    project = "tf-aws-rds-mysql"
    created_by = "Jacobo"
  }


}

