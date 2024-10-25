FROM rapporteket/dev:weekly

LABEL maintainer="Arnfinn Hykkerud Steindal <arnfinn.hykkerud.steindal@helse-nord.no>"

ARG GITHUB_PAT
ENV GITHUB_PAT=${GITHUB_PAT}

RUN R -e "remotes::install_github(c('Rapporteket/rapbase@nordiscir_mod', 'Rapporteket/rapFigurer', \
    'Rapporteket/pilot', 'Rapporteket/nordicscir@nhn'))"
