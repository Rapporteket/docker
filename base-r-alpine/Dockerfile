FROM rhub/r-minimal:4.6.0

LABEL maintainer="Arnfinn Hykkerud Steindal <arnfinn.hykkerud.steindal@helse-nord.no>"

# hadolint ignore=DL3018
RUN apk add --no-cache --update-cache \
        mariadb-connector-c-dev

ENV LC_ALL=nb_NO.UTF-8
ENV LANG=nb_NO.UTF-8

ARG TARGETARCH
ARG GITHUB_PAT

RUN installr -d \
    -t "gfortran curl-dev gcc musl-dev" \
    -a "cairo font-liberation" \
           bookdown \
           bslib \
           DBI \
           digest \
           dplyr \
           DT \
           jsonlite \
           kableExtra \
           knitr \
           logger \
           readr \
           rlang \
           RMariaDB \
           rmarkdown \
           sendmailR \
           shiny \
           shinyalert \
           sship \
           utils \
           ggplot2 \
           remotes \
  && R -e "remotes::install_github('Rapporteket/rapbase')" \
  && wget -q https://github.com/jgm/pandoc/releases/download/2.19.2/pandoc-2.19.2-linux-${TARGETARCH}.tar.gz \
  && tar xzf pandoc-2.19.2-linux-${TARGETARCH}.tar.gz \
  && mv pandoc-2.19.2/bin/* /usr/local/bin/ \
  && rm -rf pandoc-2.19.2*

CMD ["R"]
