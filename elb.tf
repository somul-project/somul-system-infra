data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.default.id
}

resource "aws_lb" "server_lb" {
  name               = "server-${module.variables.env}-nlb"
  internal           = false
  load_balancer_type = "network"
  subnets            = data.aws_subnet_ids.all.ids
  enable_deletion_protection = false

  tags = {
    Environment = "${(module.variables.is_prod) ? "production" : "staging"}"
  }
}

resource "aws_lb_target_group" "server_target_group" {
  name     = "server-${module.variables.env}-target-group"
  port     = 8000
  protocol = "TCP"
  vpc_id      = data.aws_vpc.default.id
}

resource "aws_lb_target_group_attachment" "server_cluster_attachment" {
  target_group_arn = "${aws_lb_target_group.server_target_group.arn}"
  target_id        = "${aws_instance.server.id}"
  port             = 8000
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

