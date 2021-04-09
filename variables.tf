variable "cidr_block_range" {
  description = "CIDR block for the VPC"
  default = "10.1.0.0/16"
}
variable "cidr_subnet_one" {
  description = "CIDR block for the subnet"
  default = "10.1.2.0/24"
}
variable "cidr_subnet_two" {
  description = "CIDR block for the subnet"
  default = "10.1.3.0/24"
}
variable "availability_zone_one" {
  description = "availability zone to create first subnet"
  default = "eu-west-1a"
}
variable "availability_zone_two" {
  description = "availability zone to create second subnet"
  default = "eu-west-1b"
}

variable "instance_ami" {
  description = "AMI for aws EC2 instance"
  default = "ami-022e8cc8f0d3c52fd"
}
variable "instance_type" {
  description = "type for aws EC2 instance"
  default = "t2.micro"
}

variable "environment_tag" {
  description = "Environment tag"
  default = "Production"
}

variable "public_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCLDxMr/sLwCYrrCnX6Avw9IomU7DxMcrF38WRFjbWmYPnxlAvbwO8kkgRkxHugMe/uXjr9g9hJhLAuaC36TlB9f/WjGyO6bLlPZyJczuam+0zJ4RJ2o28cRuYdDe8i8fQna3r/7XCh26o5f90NxTiTOuCSHuhmCFF8BLKfkkQr+H598M4BIU8TLrVCC9+jQ4I+vaAD5m1RSLaprgEOP2wQJp0L/Cu5fKqDqHtMggRBEAp/RmQy4Q5j2AH/peGz+2YkBSknL7ywbJMVjaGqPxTS3F69Dvkv2jGlZxP/QL/Dczx5384e2v5ktacqX+4is0GilMwiUgGf2ngwWFyCnpbn"
}

variable "private_key" {
  default = "~/.ssh/testing.pem"
}
