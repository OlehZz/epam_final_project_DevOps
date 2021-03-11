data "aws_ami" "latest_ubuntu18" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}
# jenkins server
resource "aws_instance" "jenkins_ubuntu_18" {
  ami           = data.aws_ami.latest_ubuntu18.id
  instance_type = "t2.micro"
  key_name = var.PRIVATE_KEY
  vpc_security_group_ids = [var.webserver_sg]
  subnet_id   = var.public_subnet_id
  user_data              = file("modules/instances/install.sh")
  tags = {
    Name  = "Jenkins for epam project"
    Owner = "Oleh Zemskov"
  }
}

# jenkins node
resource "aws_instance" "jenkins_node" {
  ami           = data.aws_ami.latest_ubuntu18.id
  instance_type = "t2.micro"
  key_name = var.PRIVATE_KEY
  vpc_security_group_ids = [var.webserver_sg]
  subnet_id   = var.public_subnet_id
  user_data              = file("modules/instances/node_install.sh")
  tags = {
    Name  = "Jenkins node"
    Owner = "Oleh Zemskov"
  }
}

#ec2 for ASG
resource "aws_launch_configuration" "web" {
  name            = "Webserver"
  key_name        = var.PRIVATE_KEY
  image_id        = data.aws_ami.latest_ubuntu18.id
  instance_type   = "t2.micro"
  security_groups = [var.webserver_sg]
}