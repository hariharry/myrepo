resource "aws_lb" "3elb" {
  name               = "3elb"
  load_balancer_type = "application"
  subnets            =[ "${aws_subnet.public_subnets.*.id}"]
  security_groups    =[ "${aws_security_group.elb-sg.id}"]
  internal           = false

  
 tags {
   name ="3elb"
 }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = "${aws_lb.3elb.arn}"
  port              = "80"
  protocol          = "HTTP"
 default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.web-tg.arn}"
  }
}

