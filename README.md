# VSC Cloud Dev Box

This repository contains some IaC scripts to create a development environment based on Visual Studio Code (VSC) on AWS.

## How it works

The general idea is to start the VM and use it to develop and run your applications using VSCs [Remote SSH Development](https://code.visualstudio.com/docs/remote/ssh) feature.

Due to VSC implementation, all non UI related VSC plugins will be installed on the VM as well. Only UI related plugins will be installed on the host. Therefore, it is also possible to isolate multiple development environments easily by creating multiple boxes.

## Setup

Currently an AWS EC2 t2.micro instance using terraform defaults is created. To run the IaC scripts follow these steps:

1. Configure AWS CLI

```
aws configure
```

2. Run terraform script providing your SSH Public Key location (defaults to: ~/.ssh/id_rsa.pub)

```
terraform apply -var "ssh_public_key=<PATH TO PUBLIC KEY>"
```

terraform will create the box based on Fedora 34 Cloud Base and initialize it using [cloud-init](https://cloud-init.io)

The EC2 instance created will have the following applications installed:
- podman
- podman-compose
- vim

For compatiblity reasons **docker** and **docker-compose** bash aliases are created.

## Usage

You can connect to your instance via SSH using Public-Key authentication. For a working connection you will have to add a SSH inbound rule on the default security group.

For development [Visual Studio Codes remote development features](https://code.visualstudio.com/docs/remote/ssh) can be used.

# License

All contents of this repository are published under GNU GENERAL PUBLIC LICENSE Version 2.

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.