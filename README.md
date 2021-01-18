# Terraform project

To learn about terraform (infrastructure as code) and cloud infrastructure in general.

## Credentials template
[How to get your keys](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#access-keys-and-secret-access-keys)

```
variable "aws_access_key" {
default = "PASTE_ACCESS_KEY_HERE"
}
variable "aws_secret_key" {
default = "PASTE_SECRET_KEY_HERE"
}
variable "aws_region" {
default = "ENTER_AWS_REGION"
}
```

## Modules

After adding a module, we have to tun `terraform init` to install all modules required by the configuration.

## Network module

We need to have a *Virtual Private Cloud (VPC)* to isolate our network from other virtual networks in the AWS Cloud. Amazon VPC service lets us provision a private, isolated section of the AWS Cloud where we can launch our EC2 instance within a virtual network.

When creating a VPC we need to specify [CIDR block](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) (Classless Inter-Domain Routing). It's a method for allocating IP addresses and for IP routing.
CIDR block is a range of IP addressed for example:
`10.0.0.0/24` - 254 hosts (IP addresses), includes all listings from 10.0.0.1 to 10.0.0.255
`10.0.0.0/16` - 65000 IP addresses
`10.0.0.0/32` - only one

Then we can add a *subnet*. Each subnet has its own CIDR block, which is a subset of the VPC CIDR block. We need an *internet gateway* which allows internet traffic. It let's machines in private network can send packages the public internet and receive requests.
If a subnet’s traffic is routed to an internet gateway using route table, the subnet is known as a public subnet. All instances inside a public subnet can access the internet using internet gateway.

In the network module have to:
1. Create *VPC* with defined CIDR block, enable DNS support and DNS hostnames so each instance can have a DNS name along with IP address.
2. Add an *internet gateway* inside VPC which can be used by subnet to access the internet from inside the private cloud.
3. Add a *subnet* inside VPC with its own CIDR block which is a subset of VPC CIDR block and is given an availability zone
4. Add a *route table*, which uses internet gateway to access the internet.
5. Associate route table with the subnet to make our subnet public
