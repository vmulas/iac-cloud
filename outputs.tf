output "elb_dns" {
  value = "${aws_elb.web.dns_name}"
}

output "instance_ip" {
  value = "${join(",", aws_instance.web.*.public_ip)}"
}

output "instance_lan_ip" {
  value = "${join(",", aws_instance.web.*.private_ip)}"
}
