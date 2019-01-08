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

### Prerequisites
Docker must be installed, please refere to the instructions for
[Windows](https://docs.docker.com/docker-for-windows/install/)
and
[Mac](https://docs.docker.com/docker-for-mac/install/)
. For
[linux](https://store.docker.com/search?offering=community&type=edition&operating_system=linux)
please make sure to install
[docker-compose](https://docs.docker.com/compose/install/)
after the docker engine has been installed.

### Start containers
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
where all after the ":" defines the mount point within the container. Please
adjust the part before the ":" according to where your private key is stored
on the host.

Then, start up the  containers. For a linux type host navigate to the
directory holding your *docker-compose.yml* file and start by running:
```bash
docker-compose up
```

from the command line. If the docker images are already downloaded RStudio
will shortly by accessible navigating your browser to
[localhost:8787](http://localhost:8787). If the images are not present on your
host computer please be patient and allow docker to download the images before
they are started. Once the containers are started log into RStudio witn user
"rstudio" and password "password". To acccess shiny-server navigate your
browser to [localhost:3838](http://localhost:3838) (no password needed).

### Stop containers
Using the above start up command pres ```ctrl + c``` to stop the containers.
Docker will save the state of your containers and any data that you've been
working on will still be there once you start your containers the next time.
For the security of your data this migth not be desirable. In that case it is
recommended to remove your containers (but keeping the initial images) by
running the following command after the containers have been stopped:
```bash
docker rm -vf $(docker ps -a -q)
```

Next time the container are started they will be in their initial states and
any data payload must be decrypted all over agian.

### Initializing container data
If you have requested a tag of *rap-dev-data* that contains data, the relevant
image will hold these in an encrypted form. Hence, at the initial state of the
container the data payload must be decrypted to enable further use. An
init-script is provided to aid decryption, loading of data into the mysql
database, installation of various configuration files, etc. Once logged into
RStudio open the terminal tab and run the init script:
```bash
./init.sh
```

You will be prompted for the password to your private key used for decryption
and root password for your mysql database. The latter is by default set to
"root".

### Behind a proxy
Doing your Rapporteket work behind a proxy server tend to complicate things
slightly. In summary, the proxy settings must be pre-built into the image
that is used to provie you with the RStudio container. The below 3 steps will
help you get up and running with a develoment environment that reflects your
proxy server settings.

#### Step 1: Re-build the _rap-dev_ image with your proxy settings
Please follow 
[the guide provided for _rap-dev_](https://github.com/Rapporteket/docker/tree/master/rap-dev#behind-a-proxy).

#### Step 2: Re-build the _rap-dev-data_ image
The _rap-dev-data_ container depend on _rap-dev_ and since the latter now has
changed this must also be applied to the _rap-dev-data_ image.

In the previous step the Rapporteket Docker repo was downloaded from GitHub
(if not, re-visit Step 1). Now, move into the _docker/rap-dev-data_ directory
and rebuild the _rap-dev-data_ image:
```bash
docker build -t rap-dev-data .
```

#### Step 3: Start your re-configured container
Make sure your docker-compose.yml file refers to the local images and star it
as per normal:
```bash
docker-compose up
```

### Add one or more nameserver
Nameservers can be defined during startup of the container and providing these
may be relevant in particular if behind a proxy server. On Ubuntu <=14 your
nameservers can be liste using the command:
```bash
nmcli dev list iface <interfacename> | grep IP4
```
or for Ubuntu >=15:
```bash
nmcli device show <interfacename> | grep IP4.DNS
```
Most likely \<interfacename\> should be replaced by _eth0_, _wlan0_ or similar.

Then, provide the IP(s) of your nameserver(s) in the _docker-compose.yml_ file:

```yaml
...
   dev:
     depends_on:
       - db
     image: rap-dev-data
     volumes:
       - ~/.ssh:/home/rstudio/.ssh
     ports:
       - "8787:8787"
     dns:
       - 8.8.8.8
       - dns_ip_1
       - dns_ip_2
       - dns_ip_3
...
```


