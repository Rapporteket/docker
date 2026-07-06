FROM pandoc/minimal:3.10.0 AS pandoc-source

FROM rhub/r-minimal:4.6.1

LABEL maintainer="Arnfinn Hykkerud Steindal <arnfinn.hykkerud.steindal@helse-nord.no>"

COPY --from=pandoc-source /usr/local/bin/pandoc /usr/local/bin/pandoc

ENV LC_ALL=nb_NO.UTF-8
ENV LANG=nb_NO.UTF-8

ARG TARGETARCH

RUN --mount=type=secret,id=github_pat,env=GITHUB_PAT \
     installr -d \
     -t "cmake libuv-dev icu-dev libpng-dev fontconfig-dev freetype-dev fribidi-dev harfbuzz-dev libxml2-dev libx11-dev mariadb-dev curl-dev git cairo-dev" \
     -a "mariadb-connector-c-dev libuv fontconfig harfbuzz fribidi libxml2 cairo harfbuzz-icu font-liberation mariadb-client" \
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
           Cairo \
  && R -e "remotes::install_github('Rapporteket/rapbase')"

CMD ["R"]
