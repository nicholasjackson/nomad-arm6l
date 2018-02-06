#!/bin/bash
go get github.com/goreleaser/goreleaser
git clone https://github.com/nicholasjackson/nomad-arm6l.git

cp ./nomad-arm6l/.goreleaser.yml $GOPATH/src/github.com/hashicorp/nomad

cd $GOPATH/src/github.com/hashicorp/nomad
goreleaser --skip-validate --rm-dist
