# Docker-filer

<!-- badges: start -->
[![Version](https://img.shields.io/github/v/release/rapporteket/docker?sort=semver)](https://github.com/rapporteket/rapbase/releases)
[![Publish Docker image](https://github.com/Rapporteket/docker/actions/workflows/docker.yml/badge.svg)](https://github.com/Rapporteket/docker/actions/workflows/docker.yml)
[![Publish Docker image on release](https://github.com/Rapporteket/docker/actions/workflows/docker-release.yml/badge.svg?event=release)](https://github.com/Rapporteket/docker/actions/workflows/docker-release.yml)
<!-- badges: end -->

Docker-filer som brukes i Rapporteket, enten som basis-image for applikasjonene eller som utviklingsmiljø (RStudio).

## Innhold

Innholdes finnes i de ulike mappene. Mappen `base-r` brukes som grunnlagsimage til alle Rapporteket-applikasjonene.

## Hvordan lage et nytt image

1. Lag en mappe og legg en fil med navnet `Dockerfile` i mappa.
2. Legg inn mappenavnet i listen i fila `.github/workflows/docker.yml`

Det vil da bli bygd et image basert på Docker-fila. For commits til `main`-grena, ved en ny release og hver søndag kveld vil image også dyttes opp til [Rapporteketsiden på Dockerhub](https://hub.docker.com/u/rapporteket).