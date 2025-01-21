FROM rapporteket/dev:weekly

LABEL maintainer="Arnfinn Hykkerud Steindal <arnfinn.hykkerud.steindal@helse-nord.no>"

ARG GITHUB_PAT
ENV GITHUB_PAT=${GITHUB_PAT}

RUN R -e "remotes::install_github(c('Rapporteket/rapFigurer', \
    'Rapporteket/pilot', 'Rapporteket/nordicscir@main', 'Rapporteket/rapbase@main'))" \
    && tlmgr update --self && tlmgr install beamer colortbl babel-english
