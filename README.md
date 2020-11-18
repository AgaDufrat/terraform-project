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
