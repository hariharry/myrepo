resource "aws_elb" "3elb" {
  name               = "3elb"
  subnets            =[ "${aws_subnet.public_subnets.*.id}"]
  security_groups    =[ "${aws_security_group.elb-sg.id}"]
  internal           = false
  instances          = ["${aws_instance.web.*.id}"]
  listener =
    {
      instance_port     = "80"
      instance_protocol = "HTTP"
      lb_port           = "80"
      lb_protocol       = "HTTP"
    }
   health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }
 tags {
   name ="3elb"
 }
}
