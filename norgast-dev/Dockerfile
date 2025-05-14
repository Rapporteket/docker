FROM rapporteket/dev:weekly

LABEL maintainer="Kevin Thon <kevin.otto.thon@helse-nord.no>"

ARG GITHUB_PAT
ENV GITHUB_PAT=${GITHUB_PAT}

# add registry dev config and R pkg dependencies

RUN R -e "remotes::install_github(c('Rapporteket/norgast@nhn', 'Rapporteket/rapFigurer', \
    'Rapporteket/rapbase@main'))"
