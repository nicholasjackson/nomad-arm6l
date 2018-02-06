#!/bin/bash
git clone https://github.com/nicholasjackson/nomad-arm6l.git
go get github.com/goreleaser/goreleaser
cp .goreleaser.yml $GOPATH/src/github.com/hashicorp/nomad

cd $GOPATH/src/github.com/hashicorp/nomad
goreleaser --skip-validate --rm-dist
