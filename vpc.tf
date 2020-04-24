resource "aws_vpc" "main_vpc" {
  cidr_block = "${var.vpc_env[module.variables.env]}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "server-${module.variables.env}-vpc"
  }
}

resource "aws_subnet" "main_subnet" {
  vpc_id            = "${aws_vpc.main_vpc.id}"
  availability_zone = "ap-northeast-2a"
  cidr_block        = "${cidrsubnet(aws_vpc.main_vpc.cidr_block, 4, 1)}"
  map_public_ip_on_launch = true

  tags = {
    Name = "server-${module.variables.env}-subnet"
  }
}

resource "aws_default_route_table" "r" {
  default_route_table_id = "${aws_vpc.main_vpc.default_route_table_id}"

  tags = {
    Name = "server-${module.variables.env}-route-table"
  }
}

resource "aws_route_table_association" "main_public" {
	subnet_id      = "${aws_subnet.main_subnet.id}"
	route_table_id = "${aws_vpc.main_vpc.default_route_table_id}"
}

resource "aws_internet_gateway" "main_vpc_igw" {
  vpc_id = "${aws_vpc.main_vpc.id}"
  tags = {
    Name = "server-${module.variables.env}-igw"
  }
}

resource "aws_route" "applicaton_public" {
	route_table_id         = "${aws_vpc.main_vpc.default_route_table_id}"
	destination_cidr_block = "0.0.0.0/0"
	gateway_id             = "${aws_internet_gateway.main_vpc_igw.id}"
}