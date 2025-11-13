FROM rapporteket/dev:weekly

LABEL maintainer="Arnfinn Hykkerud Steindal <arnfinn.hykkerud.steindal@helse-nord.no>"

ARG GH_PAT
ENV GITHUB_PAT=${GH_PAT}

ENV MYSQL_HOST=db-ltmv

# add registry dev config and R pkg dependencies
COPY --chown=rstudio:rstudio db.yml /home/rstudio/rap_config/
RUN cat /home/rstudio/rap_config/db.yml >> /home/rstudio/rap_config/dbConfig.yml \
    && rm /home/rstudio/rap_config/db.yml \
    && echo "MYSQL_HOST=${MYSQL_HOST}" >> /home/rstudio/.Renviron \
    && echo "MYSQL_HOST=${MYSQL_HOST}" >> /home/shiny/.Renviron \
    && R -e "remotes::install_github('Rapporteket/ltmv', dependencies = TRUE)"
