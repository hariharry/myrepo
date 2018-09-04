resource "aws_instance" "web" {
  count	 	  = "${length(var.web_ec2_count)}"
  ami             = "${data.aws_ami.ubuntu.id}"
  instance_type   = "t2.micro"
  subnet_id       = "${ element(aws_subnet.public_subnets.*.id,count.index) }"
  key_name        = "${var.key_value}"
  associate_public_ip_address = true
  security_groups = [ "${aws_security_group.web.id}"]
 
 tags {
    Name = "web-${count.index +1} "
  }
}
