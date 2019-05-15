FROM rapporteket/rap-dev:latest

# our own touch to shiny-server
RUN rm /srv/shiny-server/index.html
RUN rm -rf /srv/shiny-server/sample-apps
RUN usermod -a -G staff,rstudio shiny
ADD --chown=root:root rapShinyApps.tar.gz /srv/shiny-server/

# add data payload, scripts and settings
#COPY --chown=rstudio:rstudio payload.tar.gz /home/rstudio/regData/
COPY --chown=rstudio:rstudio dec.sh /home/rstudio/regData/
COPY --chown=rstudio:rstudio init.sh /home/rstudio/
COPY --chown=rstudio:rstudio odbcinst.ini /home/rstudio/.odbcinst.ini

# environment settings for timezone, network proxy, context and config
ARG TZ=Europe/Oslo
ENV TZ=${TZ}

ARG PROXY=
ENV http_proxy=${PROXY}
ENV https_proxy=${PROXY}

ARG INSTANCE=DEV
ENV R_RAP_INSTANCE=${INSTANCE}

ARG CONFIG_PATH=/home/rstudio/rap_config
ENV R_RAP_CONFIG_PATH=${CONFIG_PATH}

RUN touch /home/rstudio/.Renviron
RUN echo "TZ=${TZ}" > /home/rstudio/.Renviron
RUN echo "http_proxy=${PROXY}" >> /home/rstudio/.Renviron
RUN echo "https_proxy=${PROXY}" >> /home/rstudio/.Renviron
RUN echo "R_RAP_INSTANCE=${INSTANCE}" >> /home/rstudio/.Renviron
RUN echo "R_RAP_CONFIG_PATH=${CONFIG_PATH}" >> /home/rstudio/.Renviron

RUN touch /home/shiny/.Renviron
RUN echo "TZ=${TZ}" > /home/shiny/.Renviron
RUN echo "http_proxy=${PROXY}" >> /home/shiny/.Renviron
RUN echo "https_proxy=${PROXY}" >> /home/shiny/.Renviron
RUN echo "R_RAP_INSTANCE=${INSTANCE}" >> /home/shiny/.Renviron
RUN echo "R_RAP_CONFIG_PATH=${CONFIG_PATH}" >> /home/shiny/.Renviron
RUN echo "LANG=nb_NO.UTF-8" >> /home/shiny/.Renviron
