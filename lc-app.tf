resource "aws_launch_configuration" "app-lc" {
  name           = "web-lc"
  image_id       = "${data.aws_ami.ubuntu.id}"
  instance_type  = "t2.micro"
  key_name       = "${var.key_value}"
  security_groups= [ "${aws_security_group.app.id}"]
 # user_data      = "${file("userdata.sh")}"
}
