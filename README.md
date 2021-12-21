# VSC Cloud Dev Box

This repository contains some IaC scripts to create a development environment based on Visual Studio Code (VSC) on AWS.

## How it works

The general idea is to start the VM and use it to develop. One can interact with it in two ways:
1. Develop using VSCs [Remote SSH Development](https://code.visualstudio.com/docs/remote/ssh) feature
2. Install [VSC Code Server](https://github.com/cdr/code-server) and develop using SSH tunneling or by exposing it to the internet

terraform will create the box based on Fedora 34 Cloud Base and initialize it using [cloud-init](https://cloud-init.io)

The EC2 instance created will have the following applications installed:
- podman
- podman-compose
- vim
- git
- VSC coder-server

For compatiblity reasons **docker** and **docker-compose** bash aliases are created.

## Setup

Currently an AWS EC2 t2.micro instance using terraform defaults is created. To run the IaC scripts follow these steps:

1. Configure AWS CLI

```
aws configure
```

### Setup VSC SSH remote or VSC Code Server via SSH Tunneling

2. Run terraform script providing your SSH Public Key location (defaults to: ~/.ssh/id_rsa.pub)

```
terraform apply -var "ssh_public_key=<PATH TO PUBLIC KEY>"
```

### Setup VSC Code Server exposed to the internet

In order to expose VSC Code Server to the internet the following prerequisites must be met:
1. You own a domain
2. You can change the domain's DNS record

To expose VSC Code Server to the internet follow these steps:

2. Run terraform script providing your SSH Public Key location, domain and email

```
terraform apply -var "ssh_public_key=<PATH TO PUBLIC KEY>" -var "exposed=true" -var "domain=<YOUR DOMAIN>" -var "email=<YOUR REAL EMAIL>"
```

3. Get the EC2 Instance Public IP and update your DNS Record (as soon as possible; provisioning process takes some time)

## Usage

### Visual Studio Code SSH remote development

You can connect to your instance via SSH using Public-Key authentication. For a working connection you will have to add a SSH inbound rule on the default security group.

Due to VSC implementation, all non UI related VSC plugins will be installed on the VM as well. Only UI related plugins will be installed on the host. Therefore, it is also possible to isolate multiple development environments easily by creating multiple boxes.

For development [Visual Studio Codes remote development features](https://code.visualstudio.com/docs/remote/ssh) can be used.

### Visual Studio Code Server via SSH Tunneling

In order to use Visual Studio Code Server via SSH Tunneling you have to first create the SSH tunnel:

```
ssh -N -L 8080:127.0.0.1:8080 <USER>@<HOST>
```

When the tunnel is established, open Visual Studio Code Server in your browser [http://127.0.0.1:8080](http://127.0.0.1:8080). The password can be found on your VM:

```
~/.config/code-server/config.yaml
```

### Visual Studio Code Server exposed

If you decided to expose Visual Studio Code Server to the internet, you only have to open the domain in the browser.  The password can be found on your VM:

```
~/.config/code-server/config.yaml
```

# License

All contents of this repository are published under GNU GENERAL PUBLIC LICENSE Version 2.

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.