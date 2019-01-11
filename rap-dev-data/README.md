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

NB! Please follow the above install instructions carefully. The method used to
successfully install docker will depend on your type
of OS (and even different versions of the same OS). You might even need to
alter BIOS-settings on your computer if virtualization is not already enabled.

This documentation is based on docker hosted on a linux-type OS. Hence,
following these instructions you might find yourself stuck on other
platforms. For instance, if you are running the container on an older Windows
OS using Docker Toolbox the web browser address
[localhost:8787](http://localhost:8787) will not get
you to the right place. Instead, you might find the corresponding site at
[192.168.99.100:8787](http://192.168.99.100:8787). The actual IP in this case
can be found by running
```bash
docker-machine ip default
```
in the Docker Quick Start Terminal.

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


### Add local data to container
Skip this section if you use a container that has data pre-built. If
you use the _nodata_ tag of this container and have requested and been provided
with the file _payload.tar.gz_, please read on.

Your local data must be present within the container. Hence, you need to
re-build the container according to the following three steps:

#### Step 1: Get the docker-files
If you havent done so already, clone the _docker_ project from Rapporteket at
GitHub:
```bash
git clone https://github.com/Rapporteket/docker.git
```

#### Step 2: Edit the docker files
Move into the directory _docker/rap-dev-data_. In _Dockerfile_ un-comment the
line
```bash
#COPY --chown=rstudio:rstudio payload.tar.gz /home/rstudio/regData/
```
by removing the "#" at the start of the line. Then, save and exit.

#### Step 3: Build the container
Move the file _payload.tar.gz_ into the same directory as _Dockerfile_. Then,
from the same directory, build the container:
```bash
docker build -t rap-dev-data .
```

### Initializing container data
If you have requested a tag of *rap-dev-data* that contains data or you have
built the container locally adding your own _payload.tar.gz_-file, your
image will hold these data  in an encrypted form. Hence, at the initial state
of the container the data payload must be decrypted to enable further use. An
init-script is provided to aid decryption, loading of data into the mysql
database, installation of various configuration files, etc. Once your container
is started, your web browser is navigated to
[localhost:8787](http://localhost:8787) and you are logged into RStudio, open
the RStudio terminal tab and run the init script:
```bash
./init.sh
```

You will be prompted for the password to your private key used for decryption
and root password for your mysql database. The latter is by default set to
"root". Please note that use of shiny-server in this container may also depend
on configuration provided through this init-script. Therefore, every time this
container is started at its initial state please run this script before you
start your work. 

### Behind a proxy
Use of this container behind a proxy server tend to complicate things
slightly. In summary, the proxy settings must be pre-built into the image
that is used to provide you with the RStudio container. The below 3 steps will
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
       - "3838:3838"
     dns:
       - 8.8.8.8
       - dns_ip_1
       - dns_ip_2
       - dns_ip_3
...
```


