output "server_ip" {
    description = "Public IP address of serverr"
    value = "${aws_instance.server.public_ip}"
}