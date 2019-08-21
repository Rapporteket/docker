FROM rocker/verse:latest

ENV DEBIAN_FRONTEND noninteractive
ENV LC_TIME nb_NO.UTF-8

# debian extras
RUN apt-get update && apt-get install -yq \
    apt-utils \
    locales \
    locales-all \
    mysql-client \
    netcat-openbsd \
    tzdata \
    unixodbc \
    unixodbc-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# testing: shiny-server just do not get anything but locale C
RUN locale-gen nb_NO.UTF-8

# experimental add mariadb odbc driver not found in debian 9 repo...
ADD https://downloads.mariadb.com/Connectors/odbc/connector-odbc-2.0.15/mariadb-connector-odbc-2.0.15-ga-debian-x86_64.tar.gz /tmp
RUN tar xvzf /tmp/mariadb-connector-odbc-2.0.15-ga-debian-x86_64.tar.gz --directory /tmp
RUN cp /tmp/mariadb-connector-odbc-2.0.15-ga-debian-x86_64/lib/libmaodbc.so /usr/lib/x86_64-linux-gnu/odbc/
COPY --chown=rstudio:rstudio odbcinst.ini /home/rstudio/.odbcinst.ini

# System locales
ENV LANG=nb_NO.UTF-8
ENV LC_ALL=nb_NO.UTF-8
RUN echo "LANG=\"nb_NO.UTF-8\"" > /etc/default/locale

# making proxy def (and other env vars) go all the way into Rstudio
# console, based on
# https://github.com/rocker-org/rocker-versioned/issues/91
ARG PROXY=
ENV http_proxy=${PROXY}
ENV https_proxy=${PROXY}

ARG INSTANCE=DEV
ENV R_RAP_INSTANCE=${INSTANCE}

ARG CONFIG_PATH=/home/rstudio/rap_config
ENV R_RAP_CONFIG_PATH=${CONFIG_PATH}

RUN touch /home/rstudio/.Renviron
RUN echo "http_proxy=${PROXY}" >> /home/rstudio/.Renviron
RUN echo "https_proxy=${PROXY}" >> /home/rstudio/.Renviron
RUN echo "R_RAP_INSTANCE=${INSTANCE}" >> /home/rstudio/.Renviron
RUN echo "R_RAP_CONFIG_PATH=${CONFIG_PATH}" >> /home/rstudio/.Renviron

# add rstudio user to root group  and enable shiny server
ENV ROOT=TRUE
RUN export ADD=shiny && bash /etc/cont-init.d/add

## provide user shiny with corresponding environmental settings
RUN touch /home/shiny/.Renviron
RUN echo "http_proxy=${PROXY}" >> /home/shiny/.Renviron
RUN echo "https_proxy=${PROXY}" >> /home/shiny/.Renviron
RUN echo "R_RAP_INSTANCE=${INSTANCE}" >> /home/shiny/.Renviron
RUN echo "R_RAP_CONFIG_PATH=${CONFIG_PATH}" >> /home/shiny/.Renviron


# Install odbc package from github
RUN R -e "devtools::install_github('r-dbi/odbc')"

# Install base Rapporteket packages in R 
RUN R -e "devtools::install_github('Rapporteket/rapbase', ref='rel')"
RUN R -e "devtools::install_github('Rapporteket/raptools')"

# tinytex maybe not so fully automtaic...
RUN usermod -a -G staff,rstudio shiny
USER shiny
RUN R -e "tinytex::tlmgr_install('collection-langeuropean')"

USER root
