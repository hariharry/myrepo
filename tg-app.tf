resource "aws_lb_target_group" "app-tg" {
  name     = "app-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.myvpc.id}"
  health_check {
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = 200
  }
}

