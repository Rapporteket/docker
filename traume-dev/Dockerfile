FROM rapporteket/rstudio:main

ARG GITHUB_PAT

RUN R -e "remotes::install_github('Rapporteket/traume', dependencies = TRUE)"
