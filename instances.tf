############ RDS ##################
resource "aws_db_instance" "default" {
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "dbuser"
  password             = "user1234"
  parameter_group_name = "default.mysql5.7"
  db_subnet_group_name = "${aws_db_subnet_group.dbsubnet.name}"
  skip_final_snapshot  = true
  //security_group_id  = "sg-123456"
  security_group_names = ["${aws_security_group_rule.mysql.id}"]
}
