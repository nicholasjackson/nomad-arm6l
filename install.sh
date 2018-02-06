#!/bin/bash

sudo apt-get update
sudo apt-get install -y git build-essential

wget https://dl.google.com/go/${GOVERSION}.tar.gz
tar -C /usr/local -xzf ${GOVERSION}.tar.gz
mkdir /root/go

echo "export GOPATH=/root/go" >> /root/.ssh/environment
echo "export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin" >> /root/.ssh/environment
echo "PermitUserEnvironment yes" >> /etc/ssh/sshd_config

mkdir -p /root/go/src/github.com/hashicorp
git clone --branch ${NOMAD_VERSION} https://github.com/hashicorp/nomad.git /root/go/src/github.com/hashicorp/nomad

sudo systemctl restart ssh
