resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = [aws_subnet.public_subnet_az1.id, aws_subnet.public_subnet_az2.id]

  tags = {
    Name = "RDS Subnet Group"
  }
}


resource "aws_db_instance" "ecommerce_mysql" {
  identifier              = "ecommerce-db"
  allocated_storage       = 20
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  db_name                 = "ecommercedb"
  username                = "admin"
  password                = "YourSecurePassword123" # Store this in Secrets Manager ideally
  parameter_group_name    = "default.mysql8.0"
  skip_final_snapshot     = true
  publicly_accessible     = false
  db_subnet_group_name    = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.webserver_security_group.id]

  tags = {
    Name = "ecommerce-db"
  }
}
