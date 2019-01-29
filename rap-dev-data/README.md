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
Docker must be installed, please refer to the instructions for
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
of OS (and sometimes different versions of the same OS). You might even need to
alter BIOS-settings on your computer if virtualisation is not already enabled.

This documentation is written based on docker hosted on a linux-type OS. Even
though a lot of the commands are the same across platforms,
following these instructions still might lead you astray. For instance, if you
are running the container on an older Windows OS using Docker Toolbox the web
browser address [localhost:8787](http://localhost:8787) (used throughout this
document) will not get
you to the right place. Instead, you might find the corresponding site at
[192.168.99.100:8787](http://192.168.99.100:8787). The actual IP in this case
can be found by running
```bash
docker-machine ip default
```
in the Docker Quick Start Terminal.


### Adjustments to reflect your environment
The below sections might or might not apply to your use cases. At the very
start of each section a small piece of text is provided to help you
decide if the case in question do apply or, if not, can be skipped. And please,
do not worry! If you have it wrong, just start over again. Every adjustment
you make will be done in either of the files
[docker-compose.yml](https://github.com/Rapporteket/docker/blob/master/rap-dev-data/docker-compose.yml)
or
[Dockerfile](https://github.com/Rapporteket/docker/blob/master/rap-dev-data/Dockerfile).
Likely, both will come in handy, so you might as well download them right away
(along with rest of the repository):
```bash
git clone https://github.com/Rapporteket/docker.git --config core.autocrlf=input
```
Before you proceed, move into the directory _rap-dev-data_ where you will find
both of the above mentioned files.

#### Expose your ssh keys to the container
It is likely that you want to take use of your ssh keys already existing on
your computer (host of your container-to-become). If you do not need your
ssh keys (very unlikely since you will be needing them to decrypt any data that
has been delivered to you), skip this section.

##### On linux (and probably also mac, but not tested)
If you use a linux-type os your ssh keys are usually found in the *~/.ssh*
directory and the corresponding entry in *docker-compose.yml* is shown below:
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

##### On Windows
If you use Windows and to ensure the correct permissions of your ssh
keys used within the container the mount point is different from that of linux
(and probably mac). Assuming your ssh keys are stored in the
*C:\\Users\\[username]\\.ssh* directory (replace *[username]* with your actual
username) the corresponding entry in *docker-compose.yml* is shown below:
```yaml
...
  dev:
  ...
  volumes:
    - C:/Users/[username]/.ssh:/tmp/.ssh
  ...
```
where all after the ":" defines the mount point within the container. Please
adjust the part before the ":" according to where your ssh keys are stored on
the host. Initialization of the container will make sure your keys are copied
to the right place within the container and to adjust permissions accordingly.

Store your setting by saving the file.

#### Define domain name system (DNS) servers to the container
If you will be using your container on a network where internet traffic will
traverse a proxy server (see
[Build a local image and define proxy server settings](#build))
it is also likely that you will have to define DNS servers residing on your
local network. If you are not behind such a proxy server, skip this section.

First, you will have to find the IP address(es) of your DNS servers. On Ubuntu
<=14 your DNS servers can be listed using the command:
```bash
nmcli dev list iface <interfacename> | grep IP4
```
or for Ubuntu >=15:
```bash
nmcli device show <interfacename> | grep IP4.DNS
```
Most likely \<interfacename\> should be replaced by _eth0_, _wlan0_ or similar.

On Windows, open a command prompt (_cmd_) and type:
```cmd
ipconfig /all
```
and look for IP addresses in lines of the output that contain the letters "DNS".

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
Save the file.


#### Use the container with pre-built data
If you did not request a container with data pre-built, skip this section.

If you do have access to the container with your data pre-built this will
exist as a tagged version of _rap-dev-data_ and the tag will be the same as
your username on GitHub. To use this tag edit the _docker-compose.yml_ file
according to the following:
```bash
...
  dev:
    ...
    image: areedv/rap-dev-data:github-username
    ...
```
and replace _github-username_ with your actual username. Save the file.

#### Add local data to container
Skip this section if you use a container that has data pre-built.

In the following it is assumed that you have requested and been provided
with the file _payload.tar.gz_. Make sure this file is placed directly under
the _rap-dev-data_ directory. Then, open and edit the _Dockerfile_ and
un-comment the following line:
```bash
#COPY --chown=rstudio:rstudio payload.tar.gz /home/rstudio/regData/
```
by removing the "#" at the start of the line. Make sure you save the file in
the _rap-dev-data_ directory. To apply the
above changes the container needs to be re-built so make sure to perform the
steps described in
[Build a local image and define proxy server settings](#build).




#### <a name="build"></a>Build a local image and define proxy server settings
If you do not need to define a proxy server or you do not need to add local
data to your container, skip this section.

If your container is to be used behind a proxy server or/and you will add
local data to your container you have to build your very own version of the
_rap-dev-data_ container image. On the command line (Docker Quick Start
Terminal if on older Windows) make sure you are placed in the _rap-dev-data_
directory. Clean up any docker leftovers from previous builds to ensure you
build a clean image:
```bash
docker system prune --all --volumes --force
```

Then you build the your local image by following ONE out of the below two
alternatives. It will take some  time to pull and extract images all over again
so please be patient.


##### Alternative A: without proxy

From the command line do:
```bash
docker build --no-cache --pull --force-rm -t rap-dev-data .
```

##### Alternative B: with proxy
Make sure you know the *address* and *port number* of your proxy server which
will be on the form similar to _http://my-proxy.domain.no:8080_ or
_http://[your.proxy.ip]:8080_ where the address and
port number are separated by ":". If you do not know what address and port
number to use, ask IT support staff or a system administrator. Assuming that
the container to be built is to
be run locally (on the same computer building it) the same proxy settings will
also apply to the docker software running on your computer. The docker software
may be able to read global proxy settings for your system and in that case you
will be ready to proceed. If not, you will also have to configure your docker
software to reflect your system settings by adding the following (json) entry
to the file _config.json_:
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
replacing IPs and port numbers to reflect your set-up. On a linux type os
this file is found under your home directory, _e.g._ _~/.docker/config.json_.

Then, build a local image  with proxy definition:
```bash
docker build --no-cache --pull --force-rm --build-arg PROXY=http://my-proxy.domain.no:8080 -t rap-dev-data .
```

After performing one of the two above alternative builds edit the 
_docker-compose.yml_ file to make sure you use your newly built local image
(rather than pulling it from a remote repository) when starting the container.
After editing, the relevant part of _docker-compose.yml_ should look like this:
```bash
...
   dev:
     depends_on:
       - db
     image: rap-dev-data
...
```


### Start containers
Working your way down here from the top you should be ready to start the
containers. On the command line and placed under the _rap-dev-data_ directory
run the command:
```bash
docker-compose up
```

After the startup process RStudio will be accessible navigating your browser to
[localhost:8787](http://localhost:8787). Log into RStudio with user
"rstudio" and password "password". To access shiny-server navigate your
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

After running this command and the next time the containers are started they
will be in their initial states (as built).


### Initializing container data
At its initial state _rap-dev-data_ holds data in an encrypted form and this
data payload must be decrypted to enable further use. An
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

## Data protection
Getting the most out of the _rap-dev-data_ container depend on the availablity
of sensible data. The purpose of the following text is pure informational,
mainly on how the data is protected both at rest (storage) and during
transport and will apply regardless if the container image comes with data
pre-built or if users add data to the container after it has been fetched.

### Organizational measures
In this context there are two parties involved; the _provider_ and the
_user_ where the direction of flow is from the first to the latter. Formally,
by law/regulation the _user_ represents the _data owner_ and the _provider_
represents the _data processor_ acting under instruction from the _data owner_.
At both ends data will be at rest (stored) and during exchange data will be
transported. Flow of data is always initiated by a request from the _user_ to
the _provider_ and is only possible (see [Technical measures](#tech)) if the _user_ is a
member of the _Rapporteket_ organization at GitHub. Membership in this
organization can be obtained by persons cooperating on registry statistics and
is granted base on user application and a following approval by administrators
of this organization.

This arrangement ensures that the _provider_ and the _user_ have both a formal
and a practical relation prior to any exchange of data.

### <a name="tech"></a>Technical measures
A data set to be used in conjunction with this docker container is encrypted
by the _provider_ following a hybrid scheme: the data is encrypted applying a
disposable symmetric key and this key is in turn asymetrically encrypted using
a public key provided by the _user_ (resipient of data). Here, the term
"hybrid" referes to that both symmetric an asymmetric encrytion is performed,
and the term
"disposable" means that the symmetric key will only be applied once and never
re-used for encryption of data. The public key is assosiated with a
corresponding private key that is kept secret and only accessible by the person
owning it (in contrast to the public key that can be shared freely). The 
_provider_
then deliver the encrypted data to the _user_. After receiving the data the
_user_ follow the reverse hybrid scheme: the encrypted symmetric key is
decrypted applying the corresponding private key and then the decrypted
symmetric key is used to decrypt the data set itself.

Method of encryption consists of generating a randomized 256 bit key every time
data is to be encrypted. This key is then used to encrypt data following the
[Advance Encryption Standard](https://en.wikipedia.org/wiki/Advanced_Encryption_Standard).
The recipients public key is collected from his/hers user account
at GitHub and used to asymmetrically encrypt the symmetric key. The
encrypted data and encrypted key is then shipped to the recipient. For
practial implementation of encryption and decryption as describe above the
[OpenSSL cryptography library](https://www.openssl.org/) is applied.

This scheme ensures that data privacy are protected by [sufficiently strong
encryption](https://www.keylength.com/) and that decryption only can be
performed by the recipient.


### Ways of data delivery (transport)
A data set can be delivered by e-mail, which is a method commonly used when
statisticians need data from the registries they work on. E-mail is _per se_
an insecure channel; the sender or recipient cannot control or prevent
evesdroping or any temporary of permanent storage of e-mail content in transit.
However, when the content itself (_e.g._ data) is properly protected by methods
approved by the _data owner_ this method can still be safely applied for data
transportation.

Alternatively, a data set can be bundled into the container image and
exposed in a cloud service for retrieval. The cloud service may _per se_ be
publicly accessible and hence insecure in terms of data privacy. Again,
when the data set itself is properly protected by methods approved by the
_data owner_ this method can be safely applied for data transportation.

In this context the two methods described above can be regarded as equal with
regard to the degree of data privacy protection.
