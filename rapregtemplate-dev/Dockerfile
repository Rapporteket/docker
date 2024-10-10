FROM rapporteket/dev:weekly

LABEL maintainer="Arnfinn Hykkerud Steindal <arnfinn.hykkerud.steindal@helse-nord.no>"

ARG GITHUB_PAT
ENV GITHUB_PAT=${GITHUB_PAT}

# add registry dev config and R pkg dependencies
COPY --chown=rstudio:rstudio db.yml /home/rstudio/rap_config/
RUN cat /home/rstudio/rap_config/db.yml >> /home/rstudio/rap_config/dbConfig.yml \
    && rm /home/rstudio/rap_config/db.yml \
    && R -e "remotes::install_github(c('Rapporteket/rapbase', \
    'Rapporteket/rapregtemplate'))"

COPY rstudio-prefs.json /home/rstudio/.config/rstudio/rstudio-prefs.json
