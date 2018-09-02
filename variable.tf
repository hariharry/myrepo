variable "region" {
  default= "us-east-1"
}
variable "vpc_cidr" {
  default="10.0.0.0/16"
}
variable "private-subnets" {
  type ="list"
  default =["private_subnet1","private_subnet2","private_subnet3","private_subnet4"]
}
variable "db-subnets" {
type = "list"
default=["private_subnet3","private_subnet4"]
}
variable "public-subnets" {
  type ="list"
  default =["public_subnet1","public_subnet2"]
}

variable "private_subnet_cidrs" {
  type = "list"
  default = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24","10.0.4.0/24"]
}
variable "public_subnet_cidrs" {
  type = "list"
  default = ["10.0.5.0/24","10.0.6.0/24"]
}
variable "pri-azs" {
  type = "list"
  default =["us-east-1a","us-east-1a","us-east-1b","us-east-1b"]
}
variable "pub-azs" {
  type = "list"
  default =["us-east-1a","us-east-1b"]
}
