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

data "template_file" "cloud_init_config" {
    template = file("./scripts/cloud-init.yaml")

    vars = {
      ssh_public_key = file(var.ssh_public_key)
      exposed = var.exposed
    }
}

data "template_file" "code_server_sh" {
    template = file("./scripts/code-server.sh")

    vars = {
      exposed = var.exposed
      domain = var.domain
      email = var.email
      test_cert = var.test_cert
    }
}

data "template_cloudinit_config" "config" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "cloud-init.yaml"
    content_type = "text/cloud-config"
    content      = "${data.template_file.cloud_init_config.rendered}"
  }

  part {
    filename     = "code-server.sh"
    content_type = "text/x-shellscript"
    content      = "${data.template_file.code_server_sh.rendered}"
  }
}

resource "aws_instance" "vsc-dev-box" {
  ami           = "ami-0b2a401a8b3f4edd3"
  instance_type = "t2.micro"
  user_data_base64 = "${data.template_cloudinit_config.config.rendered}"

  tags = {
    Name = "VisualStudioCodeDevBox"
  }
}
