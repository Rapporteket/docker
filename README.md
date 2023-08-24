# Introduction
This is a repository containing Docker files for containers relevant for
Rapporteket.

If you do not know what containers are you can read more about it
[here](https://www.cio.com/article/2924995/software/what-are-containers-and-why-do-you-need-them.html) and
[here](https://en.wikipedia.org/wiki/Operating-system-level_virtualization#cite_note-1)
.

[Docker](https://www.docker.com/) is one way of using appliation containers.
Going down that path, [this](https://docs.docker.com/get-started/) is a nice
place to get started.

# Content
Contents are found in the sub-directories of this repository. A short summary is
provided below.

## Development environment with data for Rapporteket
If you are into development of content at Rapporteket you might want RStudio as
an 
[IDE](https://en.wikipedia.org/wiki/Integrated_development_environment),
Shiny-Server to test your apps and a database server that can host
the data you will be developing upon, this docker container will be your
choice. Please navigate
[here](https://github.com/Rapporteket/docker/tree/main/rap-dev-data).

## Development environment for Rapporteket
Same as above, but without a database server. Mainly used as a fundament for
the above, but if you want to make your own twist please file free to use it.
Please navigate
[here](https://github.com/Rapporteket/docker/tree/main/rap-dev)
