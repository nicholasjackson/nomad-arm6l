#!/bin/bash

sudo apt-get update
sudo apt-get install -y git build-essential curl libc6-dev-i386

curl -L -o ~/${go_version}.tar.gz https://dl.google.com/go/${go_version}.tar.gz 
tar -C /usr/local -xzf ~/${go_version}.tar.gz
mkdir /root/go

echo "GOPATH=/root/go" >> /root/.ssh/environment
echo "PATH=$PATH:/usr/local/go/bin:/root/go/bin" >> /root/.ssh/environment
echo "PermitUserEnvironment yes" >> /etc/ssh/sshd_config

mkdir -p /root/go/src/github.com/hashicorp
git clone --branch ${nomad_version} https://github.com/hashicorp/nomad.git /root/go/src/github.com/hashicorp/nomad

sudo systemctl restart sshd
