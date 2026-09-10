ARG BASE_IMAGE=rapporteket/rstudio:main

FROM ${BASE_IMAGE}

ARG GITHUB_PAT

# add registry dev config and R pkg dependencies
COPY --chown=rstudio:rstudio db.yml /home/rstudio/rap_config/
RUN cat /home/rstudio/rap_config/db.yml >> /home/rstudio/rap_config/dbConfig.yml \
    && rm /home/rstudio/rap_config/db.yml \
    && R -e "remotes::install_github(c('Rapporteket/smerte', 'Rapporteket/rapbase@main'))"
