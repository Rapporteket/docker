ARG BASE_IMAGE=rapporteket/rstudio:main

FROM ${BASE_IMAGE}

ARG GITHUB_PAT

RUN R -e "remotes::install_github('Rapporteket/ltmv', dependencies = TRUE)"
