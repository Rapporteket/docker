# R development environment and database for Rapporteket

## Introduction
The 
[docker-compose.yml file](https://github.com/Rapporteket/docker/blob/master/rap-dev-data/docker-compose.yml)
combines the 
[R development environment for Rapporteket](https://github.com/Rapporteket/docker/tree/master/rap-dev)
and a
[docker mysql image](https://hub.docker.com/_/mysql/)
to form a development environment where data also can
be explored. Hence, this set of docker containers will be suitable to develop
content/reports at Rapporteket.

Based on tagging, docker images of
[rap-dev-data](https://hub.docker.com/r/areedv/rap-dev-data/tags/)
can be tailor made to include a given set of data. Data in these images will
always be encrypted and therefore only accessible by the person holding the
corresponding key.

## Usage

### Prerequisite
Docker must be installed, please refere to the instructions for
[Windows](https://docs.docker.com/docker-for-windows/install/)
and
[Mac](https://docs.docker.com/docker-for-mac/install/)
. For
[linux](https://store.docker.com/search?offering=community&type=edition&operating_system=linux)
please make sure to install
[docker-compose](https://docs.docker.com/compose/install/)
after the docker engine has been installed.

### Start
*rap-dev-data* is based on two co-working docker containers and both are
started the
[docker-compose.yml file](https://github.com/Rapporteket/docker/blob/master/rap-dev-data/docker-compose.yml)
. After downloading the file open and edit it according to the desired tag of
the *rap-dev-data* image that is required. For instance the image with no
pre-added data is tagged *nodata*. To use this image make sure to specify
this tag for the *dev* container in the *docker-compose.yml* file:
```yaml
...
  dev:
    ...
    image: areedv/rap-dev-data:nodata
    ...
```

If you have a tailor made image containing data the corresponding image will be
tagged with your github username. In that case replace the above tag "nodata"
with your github username. The data payload has been encrypted with your
public key collected from github. If you have registred more than one public
key at github the first one is used. To decrypt the data payload the
corresponding private key must be made available to the *dev* container.
One way of doing this is by mounting the directory containing your private key
as a volume in the container. On linux systems a users private key is usually
found in the *~/.ssh* directory and the corresponding entry in
*docker-compose.yml* is shown below:
```yaml
...
  dev:
  ...
  volumes:
    - ~/.ssh:/home/rstudio/.ssh
  ...
```
where all after the ":" defines the mount point within the container.

docker rm -vf $(docker ps -a -q)
