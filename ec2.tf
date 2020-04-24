// Server
resource "aws_instance" "server" {
  ami             = "${data.aws_ami.ubuntu.id}"
  instance_type   = "t2.small"
  key_name        = "${var.key_pair[module.variables.env]}"
  security_groups = ["${aws_security_group.default.id}"]
  subnet_id       = "${aws_subnet.main_subnet.id}"

  associate_public_ip_address = true
  
  tags = {
    Name = "server-${module.variables.env}-server"
  }
}