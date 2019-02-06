############## VPC #####################
provider "aws" {
  region = "${var.region}"
}
resource "aws_vpc" "myvpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "myvpc"
  }
}

############### SUBNETS ######################
resource "aws_subnet" "private_subnets" {
  count             = "${length(var.private-subnets)}"
  vpc_id            = "${aws_vpc.myvpc.id}"
  cidr_block        = "${element(var.private_subnet_cidrs,count.index)}"
  availability_zone = "${element(var.pri-azs,count.index)}"

  tags = {
    Name = "private-Subnet-${count.index +1}"
  }
}
resource "aws_subnet" "private_db" {
  count             = "${length(var.db-subnets)}"
  vpc_id            = "${aws_vpc.myvpc.id}"
  cidr_block        = "${element(var.private_db_cidrs,count.index)}"
  availability_zone = "${element(var.pri-azs-db,count.index)}"

  tags = {
    Name = "private-db-${count.index +1}"
  }
}


resource "aws_subnet" "public_subnets" {
  count                   = "${length(var.public-subnets)}"
  vpc_id                  = "${aws_vpc.myvpc.id}"
  cidr_block              = "${element(var.public_subnet_cidrs,count.index)}"
  map_public_ip_on_launch = true
  availability_zone       = "${element(var.pub-azs,count.index)}"

  tags = {
    Name = "public-Subnet-${count.index +1}"
  }
}

######################## IGW #################
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = "${aws_vpc.myvpc.id}"

  tags = {
    Name = "Internet Gateway"
  }
}
#output "id" {
#  value="${aws_internet_gateway.internet_gateway.id}"
#}

###################### ROUTE TABLE ##################
resource "aws_route_table" "publicRT" {
  vpc_id = "${ aws_vpc.myvpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${ aws_internet_gateway.internet_gateway.id }"
  }

  tags = {
    Name = "publicRT"
  }
}



########### associate public subnet to public route table ###########

resource "aws_route_table_association" "public_subnet_association" {
  count          = "${length(var.public_subnet_cidrs)}"
  subnet_id      = "${element(aws_subnet.public_subnets.*.id, count.index)}"
  route_table_id = "${aws_route_table.publicRT.id }"
}

#################### NAT #### EIP #########
# adding an elastic IP

#resource "aws_eip" "elastic_ip" {
#  vpc        = true
#  depends_on = ["aws_internet_gateway.internet_gateway"]
#}

# creating the NAT gateway

resource "aws_nat_gateway" "nat" {
  count         = "${length(var.public-subnets}"
  allocation_id = "${ aws_eip.elastic_ip.id }"
  subnet_id     = "${ element(aws_subnet.public_subnets.*.id, 0) }"
  depends_on    = ["aws_internet_gateway.internet_gateway"]
  }


#################### DB SUBNET #################

resource "aws_db_subnet_group" "dbsubnet" {
  name       = "main"
  subnet_ids = ["${aws_subnet.private_db.*.id}"] 
  tags {
    Name = "MyDBsubnetGroup"
 }
}


