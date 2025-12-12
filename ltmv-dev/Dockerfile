FROM rapporteket/dev:weekly

LABEL maintainer="Arnfinn Hykkerud Steindal <arnfinn.hykkerud.steindal@helse-nord.no>"

ARG GH_PAT
ENV GITHUB_PAT=${GH_PAT}

RUN R -e "remotes::install_github('Rapporteket/ltmv', dependencies = TRUE)"
