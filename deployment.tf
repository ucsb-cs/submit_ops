output "ip" {
    value = "${aws_eip.submit_ip.public_ip}"
}

provider "aws" {
  profile = "submit"
  region  = "${var.region}"
}

resource "aws_eip" "submit_ip" {
  instance = "${aws_instance.submit_http.id}"
  vpc = true
}

resource "aws_instance" "submit_http" {
  subnet_id = "subnet-867638dd"
  ami = "${var.ami}"
  instance_type = "t2.micro"
  key_name = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.submit_http.id}"]
}

# Access the instances over SSH and HTTP
resource "aws_security_group" "submit_http" {
  description = "Provides ssh and http access"
  vpc_id = "vpc-a95532cf"
  # Access everything
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    protocol = "-1"
    to_port = 0
  }
  # SSH access from anywhere
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # HTTP access from anywhere
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  name = "submit_http"
}

variable "ami" {}

variable "key_name" {}

variable "region" {
  default = "us-east-1"
}
