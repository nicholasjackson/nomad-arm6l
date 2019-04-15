#!/bin/bash -e
if ! [[ -f "$GOPATH/src/github.com/hashicorp/nomad/.goreleaser.yml" ]]; then
    git clone https://github.com/nicholasjackson/nomad-arm6l.git
    cp ./nomad-arm6l/.goreleaser.yml $GOPATH/src/github.com/hashicorp/nomad
fi

cd $GOPATH/src/github.com/hashicorp/nomad
goreleaser --skip-validate --rm-dist --skip-publish
