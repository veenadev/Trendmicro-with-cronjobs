output "trendmicro-elb" {
  value = "${aws_elb.elb.dns_name}"
}
