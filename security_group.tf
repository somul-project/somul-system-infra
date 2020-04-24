// Allowing every traffics to instances.
resource "aws_security_group" "default" {
  name        = "server-${module.variables.env}-security-group"
  description = "Allow every traffics to instances"
  vpc_id      = "${aws_vpc.main_vpc.id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}