FROM rapporteket/dev:weekly

LABEL maintainer="Kevin Thon <kevin.otto.thon@helse-nord.no>"

# hadolint ignore=DL3008

# add registry dev config and R pkg dependencies
COPY --chown=rstudio:rstudio db.yml /home/rstudio/rap_config/
RUN cat /home/rstudio/rap_config/db.yml >> /home/rstudio/rap_config/dbConfig.yml \
    && rm /home/rstudio/rap_config/db.yml \
    && R -e "remotes::install_github(c('Rapporteket/rapbase', 'Rapporteket/smerte'))"