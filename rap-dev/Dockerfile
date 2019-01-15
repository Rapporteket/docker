FROM rocker/verse:3.5.0

ENV DEBIAN_FRONTEND noninteractive
ENV LC_TIME nb_NO.UTF-8

# debian extras
RUN apt-get update && apt-get install -yq \
    apt-utils \
    locales \
    locales-all \
    mysql-client \
    netcat-openbsd \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# System locales
ENV LANG=nb_NO.UTF-8
ENV LC_ALL=nb_NO.UTF-8
RUN echo "LANG=nb_NO.UTF-8" > /etc/default/locale

# making proxy def (and other env vars) go all the way into Rstudio console
# based on https://github.com/rocker-org/rocker-versioned/issues/91
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
RUN touch /home/rstudio/.Renviron
RUN echo "http_proxy=${PROXY}" >> /home/shiny/.Renviron
RUN echo "https_proxy=${PROXY}" >> /home/shiny/.Renviron
RUN echo "R_RAP_INSTANCE=${INSTANCE}" >> /home/shiny/.Renviron
RUN echo "R_RAP_CONFIG_PATH=${CONFIG_PATH}" >> /home/shiny/.Renviron

# Install base Rapporteket packages in R 
RUN R -e "devtools::install_github('Rapporteket/rapbase', ref='rel')"
RUN R -e "devtools::install_github('Rapporteket/raptools')"
