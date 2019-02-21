# R development environment for Rapporteket
[![](https://img.shields.io/docker/automated/areedv/rap-dev.svg)](https://hub.docker.com/r/areedv/rap-dev/builds/)
[![](https://img.shields.io/docker/build/areedv/rap-dev.svg)](https://hub.docker.com/r/areedv/rap-dev/builds/)
[![](https://img.shields.io/docker/pulls/areedv/rap-dev.svg)](https://hub.docker.com/r/areedv/rap-dev)


## Introduction
This is a Docker file for an R developing environment to be used in task
related to reporting services at Rapporteket.

The Docker container builds ontop of
[verse](https://hub.docker.com/r/rocker/verse) and has the
[rapbase](https://github.com/Rapporteket/rapbase) (rel branch) and
[raptools](https://github.com/Rapporteket/raptools) R packages
(and their dependencies) pre-built. In addition, shiny-server is also
enabled.

## Usage
  When running the docker image your container will be accessed by a web-browser
pointing at given ports at localhost.

### Plain
Run the _rap-dev_ container from command line:
```bash
docker run -e PASSWORD=password --rm -p 3838:3838 -p 8787:8787 areedv/rap-dev:latest
```
This will download the image from hub.docker.com and run the container
exposing it on [localhost:3838](http://localhost:3838) (shiny-server) and
[localhost:8787](http://localhost:8787) (RStudio) through your web-browser.
PASSWORD setting will be used for logging into RStudio within the container.
The _--rm_ option removes the container when the session is terminated
(ctrl + c).

### Behind a proxy
Depending on your environment and usecases being behind a proxy server might
cause minor or even major problems. One or both of the below steps might
help you get going.

To make the docker client aware of your proxy add the following to your json
configuration file (_e.g. ~/.docker/config.json_):

```json
{
  "proxies": {
    "default": {
      "httpProxy": "[your.proxy.ip]:[your_proxy_port_number]",
      "httpsProxy": "[your.tls-proxy.ip]:[your_proxy_port_number]",
      "noProxy": "test.site1.com,*.site2.com,*.site3.com"
    }
  }
}
```
In addition, to make your console in RStudio within the container aware of the
proxy environment variables the container image must also contain these
settings (you will need this for instance if doing things like 
_install.packages()_ from the RStudio console within the container). This
requires rebuilding of the docker image and in order to do so you will need the
_Dockerfile_ which is available from github (this repo). If you havent
already done so, clone this repository to your own computer:
```bash
git clone https://github.com/Rapporteket/docker.git --config core.autocrlf=input
```
Move into the directory _docker/rap-dev_ and rebuild the container with the 
_PROXY_ build argument:
```bash
docker build --build-arg PROXY=http://[your.proxy.ip]:[your_proxy_port_number] -t rap-dev .
```
The above method uses the _PROXY_ value both for HTTP\_PROXY and HTTPS\_PROXY.
Then, run the newly configured container from your local docker image repo:
```bash
docker run -e PASSWORD=password --rm -p 3838:3838 -p 8787:8787 rap-dev
```

### Add one or more nameservers
Somewhat related to proxied connections one might also need to define servers
for name lookups (dns) explicitly. This can be done with the _--dns_ option
when running the container:
```bash
docker run --dns your.dns.server.ip --dns 8.8.8.8 -v ~/.ssh:/home/rstudio/.ssh -e PASSWORD=password --rm -p 3838:3838 -p 8787:8787 areedv/rap-dev:latest
```

### Interact with GitHub with secure shell and public key
Probably you will need to interact witn the Rapporteket organization at
GitHub. Applying secure shell (ssh) and key-pairs for this purpose will make
its use alot more convenient. Having exposed your public key to GitHub it is
staight forward to re-use your existing ssh-setup also within the
_rap-dev_-container simply by allowing the container to access the directory
containing your ssh-settings. The example below shows an entry from ssh config
(_e.g ~/.ssh/config_) that also apply includes a proxy server that need to be
traversed:
```bash
Host githubThroughProxy
        HostName github.com
        User git
        ProxyCommand /bin/nc -X connect -x your.proxy.ip:yourProxyPort %h %p
```
Based on the above example access to the _.ssh_ directory is defined by the
_-v_ option when running the container:
```bash
docker run -v ~/.ssh:/home/rstudio/.ssh -e PASSWORD=password --rm -p 3838:3838 -p 8787:8787 areedv/rap-dev:latest
```

Then, from within RStudio in your container new projects can be started from
GitHub refering to _githubThroughProxy:usernameOrOrg/repository_.

