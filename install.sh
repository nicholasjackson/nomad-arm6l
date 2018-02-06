sudo apt-get update
sudo apt-get install -y git build-essential

wget https://dl.google.com/go/${GOVERSION}.tar.gz
tar -C /usr/local -xzf ${GOVERSION}.tar.gz
mkdir ~/go

echo "export GOPATH=~/go" >> .profile
echo "export PATH=$PATH:/usr/local/go/bin" >> .profile

mkdir -p $GOPATH/src/github.com/hashicorp
git clone --branch ${NOMAD_VERSION} https://github.com/hashicorp/nomad.git $GOPATH/src/github.com/hashicorp/nomad
