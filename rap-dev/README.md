# R development environment for Rapporteket
[![](https://img.shields.io/docker/automated/areedv/rap-dev.svg)](https://hub.docker.com/r/areedv/rap-dev/builds/)
[![](https://img.shields.io/docker/build/areedv/rap-dev.svg)](https://hub.docker.com/r/areedv/rap-dev/builds/)
[![](https://img.shields.io/docker/pulls/areedv/rap-dev.svg)](https://hub.docker.com/r/areedv/rap-dev)


## Introduction
This is a Docker file for an R developing environment to be used in task
related to reporting services at Rapporteket.

The Docker container builds ontop of
[verse](https://hub.docker.com/r/rocker/verse) and has the
[rapbase](https://github.com/Rapporteket/rapbase) R package pre-built from the
_rel_ branch.

## Usage

### Plain

### Behind a proxy
To make your container aware of your proxy add the following to your json
configuration file:

```json
{
  "proxies": {
    "default": {
      "httpProxy": "your.proxy.url"
    }
  }
}
```

### Add one or more nameservers

### Interact with GitHub with secure shell and public key
