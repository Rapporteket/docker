FROM rapporteket/dev:weekly

LABEL maintainer="Arnfinn Hykkerud Steindal <arnfinn.hykkerud.steindal@helse-nord.no>"

ARG GITHUB_PAT

RUN R -e "remotes::install_github('Rapporteket/ltmv', dependencies = TRUE)"
