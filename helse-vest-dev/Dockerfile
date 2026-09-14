# syntax=docker/dockerfile:1
ARG BASE_IMAGE=rapporteket/rstudio:main

FROM ${BASE_IMAGE}

ARG GITHUB_PAT

RUN <<'RSCRIPT'
#!/usr/bin/env Rscript
remotes::install_github(
  c(
    "Rapporteket/ablanor",
    "Rapporteket/barnehofte",
    "Rapporteket/fraktur",
    "Rapporteket/hoftebrudd",
    "Rapporteket/korsband",
    "Rapporteket/kvarus",
    "Rapporteket/leddprotese",
    "Rapporteket/ltmv",
    "Rapporteket/ms",
    "Rapporteket/norartritt",
    "Rapporteket/NORIC",
    "Rapporteket/parkinson",
    "Rapporteket/rapwhale",
    "Rapporteket/smerte",
    "Rapporteket/soreg"
  ),
  dependencies = TRUE
)
RSCRIPT
