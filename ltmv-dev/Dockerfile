FROM rapporteket/dev:main

LABEL maintainer="Arnfinn Hykkerud Steindal <arnfinn.hykkerud.steindal@helse-nord.no>"

RUN --mount=type=secret,id=github_pat,env=GITHUB_PAT \
    R -e "remotes::install_github('Rapporteket/ltmv', dependencies = TRUE)"
