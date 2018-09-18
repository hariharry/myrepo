resource "aws_autoscaling_group" "app-asg" {
  name                      = "web-asg"
  max_size                  = 5
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = 2
  force_delete              = true
  launch_configuration      = "${aws_launch_configuration.app-lc.name}"
  vpc_zone_identifier       = ["${aws_subnet.private_subnets.*.id}"]
  target_group_arns         = ["${aws_lb_target_group.app-tg.arn}"]
}
