FROM rapporteket/dev:weekly

LABEL maintainer="Stein-Kato <stein-kato.lindberg@helse-nord.no>"

ARG GITHUB_PAT
ENV GITHUB_PAT=${GITHUB_PAT}

# add registry dev config and R pkg dependencies
COPY --chown=rstudio:rstudio db.yml /home/rstudio/rap_config/
RUN R -e "remotes::install_github(c('Rapporteket/kvarus'))"
