output "private_subnet_ids" { 
  value = ["${aws_subnet.private_subnets.*.id}"] 
}

output "web-instance-ids" {
  value = ["$aws_instance.web.*.id}"]
}
