terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "eu-central-1"
}

data "template_file" "user_data" {
    template = file("./scripts/cloud-init.yaml")

    vars = {
      ssh_public_key = file(var.ssh_public_key)
    }
}

resource "aws_instance" "vsc-dev-box" {
  ami           = "ami-0b2a401a8b3f4edd3"
  instance_type = "t2.micro"
  user_data = data.template_file.user_data.rendered

  tags = {
    Name = "VisualStudioCodeDevBox"
  }
}
