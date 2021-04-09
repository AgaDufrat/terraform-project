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

In the network module we have to:
1. Create *VPC* with defined CIDR block, enable DNS support and DNS hostnames so each instance can have a DNS name along with IP address.
2. Add an *internet gateway* inside VPC which can be used by subnet to access the internet from inside the private cloud.
3. Add a *subnet* inside VPC with its own CIDR block which is a subset of VPC CIDR block and is given an availability zone
4. Add a *route table*, which uses internet gateway to access the internet.
5. Associate route table with the subnet to make our subnet public

## Security group module

Once the network group is ready, we can create an EC2 instance make it possible to SSH into it. For this, we have to create a security group which can be attached to our EC2 instance.

In the security group module we have to:
1. Add **ingress rule** to open port 22 for inbound traffic so we can SSH into our instance
2. Add **egress rule** to let all content go to the public internet.
`10.0.0.0/0` - all addresses on the internet are allowed to access
3. Create a [Key pair](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html#having-ec2-create-your-key-pair) which we are going to use to SSH on our EC2. In this case the key name is "testing".

Add the SSH key to the ssh-agent: `ssh-add ~/.ssh/testing.pem`
Set the permissions: `chmod 600 ~/.ssh/testing.pem`

4. Associate the Key pair with EC2 instance and provide the private key when we connect to the instance. Amazon EC2 stores the public key, and we store the private key which we later use to SSH.

The .pem file contains both private and public ssh key. We need to import only the public ssh key when creating an EC2 instance.

To extract the public key from the private key:
```
ssh-keygen -y -f KEYPAIR.pem
```
and assign this value to a variable called e.g. "public_key".

To SSH into the the instance (specific for ubuntu):
```
ssh -i ~/.ssh/testing.pem ec2-user@ec2-3-129-19-220.us-east-2.compute.amazonaws.com
```
where the last argument is the Public IPv4 address.

Note: there is also possible to create key pair using terraform with `resource "aws_key_pair"`.

## Load balancer

1. Add another subnet in a different availability zone. They need to have different cidr blocks.
2. Add another EC2 instance within the second subnet
3. Add a load balancer specifying the subnets

## Provision with Ansible

Ansible is an automation engine that automates cloud provisioning, configuration management, application deployment, intra-service orchestration. Alternatives include Puppet and Chief.

It's used to install and set up a web server (e.g. Nginx, Apache), a programming language, database etc.

1. Install Ansible `brew install ansible`
2. Set up the connection. User would be "ec2-user" for Amazon Linux based AMI or "ubuntu". We also need to provide private_key with a file to our .pem file so we can ssh to execute commands.

Use `apt-get` to run commands on Ubuntu and `yum` for Amazon Linux based AMI (ec2-user). Amazon Linux based AMI has Python installed, whereas you will need to install it on Ubuntu with `"sudo apt-get -qq install python -y"`.
Some application software like nginx is available in Amazon Linux Extras and can be installed with `sudo amazon-linux-extras install nginx1 -y`. During the installation you would be asked to confirm "Is this ok [y/d/N]", hence the `-y`.
