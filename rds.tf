resource "aws_db_subnet_group" "main" {
  name       = "main"
  subnet_ids = [aws_subnet.private_a.id, aws_subnet.private_b.id]

  tags = {
    Name = "main_db_subnet_group"
  }
}

# resource "aws_db_instance" "main2" {
#   identifier           = "wordpress-db"
#   allocated_storage    = 20
#   storage_type         = "gp2"
#   engine               = "mysql"
#   engine_version       = "8.0"
#   instance_class       = "db.t3.micro"
#   username             = "admin"
#   password             = "password"
#   db_subnet_group_name = aws_db_subnet_group.main.id
#   multi_az             = true
#   publicly_accessible  = false
#   skip_final_snapshot  = true

#   tags = {
#     Name = "wordpress-db"
#   }
# }
