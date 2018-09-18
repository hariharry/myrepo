resource "aws_autoscaling_group" "web-asg" {
  name                      = "web-asg"
  max_size                  = 5
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 2
  force_delete              = true
  launch_configuration      = "${aws_launch_configuration.web-lc.name}"
  vpc_zone_identifier       = ["${aws_subnet.public_subnets.*.id}"]
  target_group_arns	    = ["${aws_lb_target_group.web-tg.arn}"]
}

