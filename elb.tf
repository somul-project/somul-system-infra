resource "aws_lb" "server_lb" {
  name               = "server-${module.variables.env}-nlb"
  internal           = false
  load_balancer_type = "network"
  subnets            = ["${aws_subnet.main_subnet.id}"]

  enable_deletion_protection = false

  tags = {
    Environment = "${(module.variables.is_prod) ? "production" : "staging"}"
  }

  depends_on = ["aws_internet_gateway.main_vpc_igw"]
}

resource "aws_lb_target_group" "server_target_group" {
  name     = "server-${module.variables.env}-target-group"
  port     = 80
  protocol = "TCP"
  vpc_id   = "${aws_vpc.main_vpc.id}"
}

resource "aws_lb_listener" "server_https" {
  load_balancer_arn = "${aws_lb.server_lb.arn}"
  port              = "443"
  protocol          = "TLS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "${var.elb_certificate[module.variables.env]}"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.server_target_group.arn}"
  } 
}
