variable "AMI_ID" { default = "ami-0ec34443801d0e4e3" }


variable "PRIVATE_KEY" {
  default = "jenkins_aws"
}

variable "PUBLIC_KEY" {
  default = "/home/zima/aws/ssh/jenkins_aws.pem"
}


variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}

variable "AWS_REGION" {
  default = "us-east-1"
}
#=====================================================================
