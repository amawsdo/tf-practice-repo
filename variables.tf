#variable "access_key" {}
#variable "secret_key" {}
/*
variable "region" {
  default = "us-east-2"
}
variable "ami_id" {
  type = map(any)
  default = {
    us-east-2 = "ami-0b614a5d911900a9b"
    us-east-1 = "ami-abcd"
  }
}
*/

variable "region" {
  description = "Environment build in specific reagion"
  type    = string
  default = "us-east-2" #ohio
}

variable "ami_id" {
  type = map(string)
  default = {
    us-east-2    = "ami-0b614a5d911900a9b"
    us-east-1    = "ami-035b3c7efe6d061d5"
    eu-west-2    = "ami-132b3c7efe6sdfdsfd"
    eu-central-1 = "ami-9787h5h6nsn75gd33"
  }
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_name" {
  type    = string
  default = "ec2-tf"
}

variable "cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string
  default     = "10.0.0.0/16"
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  type        = string
  default     = "default"
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "enable_classiclink" {
  description = "Should be true to enable ClassicLink for the VPC. Only valid in regions and accounts that support EC2 Classic."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = string
  default     = "vpc-tf"
}
