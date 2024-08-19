resource "aws_security_group" "livlevi2com-websg" {
    name = "livlev2com-sg"
    description = "security group for webserver HTTP/S & SSH open"
    vpc_id = module.vpc.vpc_id

    tags = locals.tags
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
    security_group_id = aws_security_group.livlevi2com-websg.id
    cidr_ipv4 = module.vpc.public_subnets_cidr_blocks[0]
    ip_protocol = "tcp"
    from_port = 80
    to_port = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
    security_group_id = aws_security_group.livlevi2com-websg.id
    cidr_ipv4 = module.vpc.public_subnets_cidr_blocks[0]
    ip_protocol = "tcp"
    from_port = 443
    to_port = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
    security_group_id = aws_security_group.livlevi2com-websg.id
    cidr_ipv4 = module.vpc.public_subnets_cidr_blocks[0]
    ip_protocol = "tcp"
    from_port = 22
    to_port = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic" {
    security_group_id = aws_security_group.livlevi2com-websg.id
    cidr_ipv4 = "0.0.0.0/0"
    ip_protocol = "-1"
}