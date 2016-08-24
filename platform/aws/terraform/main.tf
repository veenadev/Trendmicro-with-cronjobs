provider "aws" {
  region = "${var.aws_region}"
}

resource "terraform_remote_state" "acct" {
  backend = "s3"
  config {
    bucket = "${var.acct_remote_state_bucket}"
    key = "${var.acct_remote_state_key}"
    region = "${var.aws_region}"
  }
}

resource "terraform_remote_state" "network" {
  backend = "s3"
  config {
    bucket = "${var.network_remote_state_bucket}"
    key = "${var.network_remote_state_key}"
    region = "${var.aws_region}"
  }
}

resource "aws_key_pair" "trendmicro_agent" {
  key_name = "${var.key_pair_name}"
  public_key = "${var.key_pair_public_key}"
}

resource "aws_instance" "trendmicro_agent" {
  ami = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  key_name = "${aws_key_pair.trendmicro_agent.key_name}"
  vpc_security_group_ids = ["${aws_security_group.trendmicro_agent-instance.id}","${terraform_remote_state.network.output.baselinesg}"]
  subnet_id = "${element(split(",", var.subnets), 1)}"
  user_data = "${file("../../../data/templates/userdata.sh.tpl")}"
    tags {
    Name = "${var.product_name}-trendmicro_agent"
    Environment = "${var.environment}"
    Owner = "${var.owner}"
    Product = "${var.product_name}"
  }
}

resource "aws_elb" "elb" {
  name = "trendmicro_agent-elb"
  subnets = ["${split(",", terraform_remote_state.network.output.xelb_subnets)}"]
  security_groups = ["${aws_security_group.trendmicro_agent-elb.id}","${terraform_remote_state.network.output.baselinesg}"]
  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "TCP:80"
    interval = 30
  }
  instances = ["${aws_instance.trendmicro_agent.id}"]
  idle_timeout = 400
    tags {
    Name = "${var.product_name}-trendmicro_agent-ELB"
    Environment = "${var.environment}"
    Owner = "${var.owner}"
    Product = "${var.product_name}"
  }
}

resource "aws_security_group" "trendmicro_agent-elb" {
  name = "trendmicro_agent"
  description = "public trendmicro_agent access for demo"
  vpc_id = "${terraform_remote_state.network.output.VPC}"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["${var.my_ip}"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "${var.product_name}-trendmicro_agent-SG"
    Environment = "${var.environment}"
    Owner = "${var.owner}"
    Product = "${var.product_name}"
  }
}

resource "aws_security_group" "trendmicro_agent-instance" {
  name = "trendmicro_agent"
  description = "public trendmicro_agent access for demo"
  vpc_id = "${terraform_remote_state.network.output.VPC}" 
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = ["${aws_security_group.trendmicro_agent-elb.idi}", "${terraform_remote_state.network.output.baselinesg}"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "${var.product_name}-trendmicro_agent-SG"
    Environment = "${var.environment}"
    Owner = "${var.owner}"
    Product = "${var.product_name}"
  }
}

resource "aws_security_group_rule" "terraform-instance-ssh" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["${terraform_remote_state.network.output.VPC_CIDR}"]
  security_group_id = "${aws_security_group.wordpress-instance.id}"
}

resource "aws_security_group_rule" "trendmicro_agent-instance-icmp" {
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  source_security_group_id = "${aws_security_group.trendmicro_agent-elb.id}"
  security_group_id = "${aws_security_group.trendmicro_agent-instance.id}"
}
