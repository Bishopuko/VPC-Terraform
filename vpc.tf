provider "aws"  {
    shared_credentials_file = "$HOME/.aws/credentials"
    profile = "default"
    region = "us-east-2"
}
resource "aws_vpc" "first_vpc" {
    cidr_block       = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_hostnames = "true"
     tags = {
       "name" : "MyTerraformVPC"
    }
}
   
resource "aws_subnet" "publicsubnet1" {
    vpc_id = aws_vpc.first_vpc.id
    cidr_block = "10.0.1.0/24"
    tags = {
      "name" : "Publicsub-1"
    }
}

resource "aws_subnet" "publicsubnet2" {
    vpc_id = aws_vpc.first_vpc.id
    cidr_block = "10.0.2.0/24"
    tags = {
      "name" : "Publicsub-2"
    }
}

resource "aws_subnet" "publicsubnet3" {
    vpc_id = aws_vpc.first_vpc.id
    cidr_block = "10.0.3.0/24"
    tags = {
      "name" : "Publicsub-3"
    }
}

resource "aws_subnet" "privateubnet1" {
    vpc_id = aws_vpc.first_vpc.id
    cidr_block = "10.0.4.0/24"
    tags = {
      "name" : "Privatesub-4"
    }
}

resource "aws_subnet" "privatesubnet2" {
    vpc_id = aws_vpc.first_vpc.id
    cidr_block = "10.0.5.0/24"
    tags = {
      "name" : "Privatesub-5"
    }
}

resource "aws_subnet" "privatesubnet3" {
    vpc_id = aws_vpc.first_vpc.id
    cidr_block = "10.0.6.0/24"
    tags = {
      "name" = "Privatesub-6"
    }
}
resource "aws_internet_gateway" "GW" {
    vpc_id = aws_vpc.first_vpc.id
    tags = {
        "Name" : "Public-GW"
    }
}
resource "aws_route_table" "rta" {
    vpc_id = aws_vpc.first_vpc.id
    
    route {
        cidr_block = "0.0.0.0/24"
        gateway_id = aws_internet_gateway.GW.id
    }
    tags = {
        "Name" : "Route-T"
    }
}
resource "aws_route_table" "rtaa" {
    vpc_id = aws_vpc.first_vpc.id
    
    route {
        cidr_block = "0.0.0.0/24"
        gateway_id = aws_internet_gateway.GW.id
    }
    tags = {
        "Name" : "Route-T2"
    }
}
resource "aws_route_table" "rtaaa" {
    vpc_id = aws_vpc.first_vpc.id
    
    route {
        cidr_block = "0.0.1.0/24"
        gateway_id = aws_internet_gateway.GW.id
    }
    tags = {
        "Name" : "Route-T3"
    }
}
resource "aws_route_table_association" "rta1" {
    subnet_id = aws_subnet.publicsubnet1.id
    route_table_id = aws_route_table.rtaaa.id
}
resource "aws_route_table_association" "rta2" {
    subnet_id = aws_subnet.publicsubnet2.id
    route_table_id = aws_route_table.rtaaa.id
}
resource "aws_route_table_association" "rta3" {
    subnet_id = aws_subnet.publicsubnet3.id
    route_table_id = aws_route_table.rtaaa.id
}
resource "aws_eip" "nat-eip" {
    vpc = true
  
}
resource "aws_nat_gateway" "private-nat" {
    allocation_id = aws_eip.nat-eip.id
    subnet_id = aws_subnet.privateubnet1.id
    tags = {
        "Name" : "NAT-1"
    }
}
resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.first_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.private-nat.id
    }
    tags =  {
        "Name" : "Nat-Route"
    }
}
resource "aws_route_table_association" "prta" {
    subnet_id = aws_subnet.privateubnet1.id
    route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "prta2" {
    subnet_id = aws_subnet.privatesubnet2.id
    route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "prta3" {
    subnet_id = aws_subnet.privatesubnet3.id
    route_table_id = aws_route_table.private_rt.id
}
