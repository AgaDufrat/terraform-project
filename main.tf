resource "aws_instance" "test" {
  ami = "ami-03f4c416f489586a3"
  instance_type = "t2.micro"
}
resource "aws_s3_bucket" "onebucket" {
   bucket = "testing-s3-with-terraform-aga"
   acl = "private"
   versioning {
      enabled = true
   }
   tags = {
     Name = "Bucket1"
     Environment = "Test"
   }
}
