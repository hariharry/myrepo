resource "aws_security_group" "bastion" {
  name        = "bastion"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
########## WEB ###############
resource "aws_security_group" "web" {
  name        = "web"
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    security_groups=["${aws_security_group.bastion.id}"]
  }
}
############# APP ###############
resource "aws_security_group" "app" {
  name        = "app"
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    security_groups=["${aws_security_group.web.id}"]
  }
}

######### RDS SG ###########
resource "aws_security_group_rule" "mysql" {
  type            = "ingress"
  from_port       = 3306
  to_port         = 3306
  protocol        = "tcp"
  security_group_id = "${aws_security_group.app.id}"
}
