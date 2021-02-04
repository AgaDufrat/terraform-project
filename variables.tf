variable "cidr_block_range" {
  description = "CIDR block for the VPC"
  default = "10.1.0.0/16"
}
variable "cidr_subnet" {
  description = "CIDR block for the subnet"
  default = "10.1.0.0/24"
}
variable "availability_zone" {
  description = "availability zone to create subnet"
  default = "us-east-2a"
}

variable "instance_ami" {
  description = "AMI for aws EC2 instance"
  default = "ami-0cf31d971a3ca20d6"
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
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCOejnYGvzLizYgjBTGI6kH+2j87TeyHteJMD5ogzkaVEoWVmFy8uAOvA/PTv905PhDqBkFgrNefbQsqtyjcrjRs36WKRBI5qKyeHOx8uCmeoI9wmWs2GieYWrt/OFhcK5PuicjRYFaTkj4R6axhCi9DV6/5jM2vb8nwwvD9joXFWf+1KTsj8FbgjgFyI1j8SGRSllzMYg4Vmo9DsxCUmA+nqSLjW8QAFMF4jJ8YXl8e5dKaOHLg2/y0F6nXufxo8HIY7/1OoWRXwPdOX5aLs9z6hoqohvz8zRpxf8yzcTntJRnLfkqR4bvQt5+KgI2YrsescXDRzVxsCeTqeDhuKO5"
}
