resource "aws_vpc" "prod-vpc" {
    cidr_block = "10.1.0.0/16"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    instance_tenancy = "default"

}


resource "aws_subnet" "prod-subnet-public-1" {
    vpc_id = "${aws_vpc.prod-vpc.id}"
    cidr_block = "10.1.1.0/24"
    map_public_ip_on_launch = "true" 

  
}

resource "aws_subnet" "prod-subnet-private-1" {
    vpc_id = "${aws_vpc.prod-vpc.id}"
    cidr_block = "10.1.2.0/24"
    map_public_ip_on_launch = "false" 

}


resource "aws_internet_gateway" "prod-igw" {
    vpc_id = "${aws_vpc.prod-vpc.id}"

}


resource "aws_route_table" "prod-public-crt" {
    vpc_id = "${aws_vpc.prod-vpc.id}"
    route {
        cidr_block = "0.0.0.0/0" 
        gateway_id = "${aws_internet_gateway.prod-igw.id}"
    }

}


resource "aws_route_table_association" "prod-crta-public-subnet-1" {
    subnet_id = "${aws_subnet.prod-subnet-public-1.id}"
    route_table_id = "${aws_route_table.prod-public-crt.id}"
}


resource "aws_security_group" "prod-ssh-allowed" {

    vpc_id = "${aws_vpc.prod-vpc.id}"

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}


resource "aws_key_pair" "prod-key-pair" {
    key_name = "ssh-key-pair"
    public_key = "${file(var.PUBLIC_KEY_PATH)}"
}

resource "aws_instance" "prod-server" {
    ami = "${var.AMI_ID}"
    instance_type = "t2.micro"
    subnet_id = "${aws_subnet.prod-subnet-public-1.id}"
    vpc_security_group_ids = ["${aws_security_group.prod-ssh-allowed.id}"]
    key_name = "${aws_key_pair.prod-key-pair.id}"

}





resource "aws_vpc" "critical-vpc" {
    cidr_block = "10.2.0.0/16"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    instance_tenancy = "default"

}

resource "aws_subnet" "critical-subnet-private-1" {
    vpc_id = "${aws_vpc.critical-vpc.id}"
    cidr_block = "10.2.1.0/24"
    map_public_ip_on_launch = "false" 

}


resource "aws_security_group" "critical-ssh-allowed" {

    vpc_id = "${aws_vpc.critical-vpc.id}"

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["10.1.0.0/16"]
    }
}



resource "aws_instance" "critical-server" {
    ami = "${var.AMI_ID}"
    instance_type = "t2.micro"
    subnet_id = "${aws_subnet.critical-subnet-private-1.id}"
    vpc_security_group_ids = ["${aws_security_group.critical-ssh-allowed.id}"]
    key_name = "${aws_key_pair.prod-key-pair.id}"

}


resource "aws_vpc_peering_connection" "prod2critical-peering" {
  vpc_id = "${aws_vpc.prod-vpc.id}"
  peer_vpc_id = "${aws_vpc.critical-vpc.id}"
  auto_accept = true
}

resource "aws_route" "prod2critical" {
  route_table_id = "${aws_route_table.prod-public-crt.id}"
  destination_cidr_block = "${aws_vpc.critical-vpc.cidr_block}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.prod2critical-peering.id}"
}


resource "aws_route" "critical2primary" {
  route_table_id = "${aws_vpc.critical-vpc.main_route_table_id}"
  destination_cidr_block = "${aws_vpc.prod-vpc.cidr_block}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.prod2critical-peering.id}"
}



