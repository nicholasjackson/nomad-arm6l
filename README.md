# nomad-arm6l
[![Build Status](https://travis-ci.org/nicholasjackson/nomad-arm6l.svg?branch=master)](https://travis-ci.org/nicholasjackson/nomad-arm6l)

Build of Nomad for Raspberry Pi statically linked

### Automated build

This uses Scaleway to provide an ARMv7 host automatically and compile `nomad`.

### Local build: Cross-compilation

This uses a Docker image to cross-compile `nomad`.

To get the binary to the host, run the following command:

```sh
docker build --pull -t nomad-arm6l .
docker run --rm nomad-arm6l cat /usr/bin/nomad > nomad
```

It is possible to compile a new version as well, using the following command:

```sh
docker build --pull --build-arg nomad_version="master" -t nomad-arm6l .
docker run --rm nomad-arm6l cat /usr/bin/nomad > nomad
```
