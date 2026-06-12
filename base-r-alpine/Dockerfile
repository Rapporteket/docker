FROM rhub/r-minimal:4.6.0

LABEL maintainer="Arnfinn Hykkerud Steindal <arnfinn.hykkerud.steindal@helse-nord.no>"

ENV LC_ALL=nb_NO.UTF-8
ENV LANG=nb_NO.UTF-8

ARG TARGETARCH
ARG GITHUB_PAT

RUN installr -d \
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
  && R -e "remotes::install_github('Rapporteket/rapbase')" \
  && wget -q https://github.com/jgm/pandoc/releases/download/3.10/pandoc-3.10-linux-${TARGETARCH}.tar.gz \
  && tar xzf pandoc-3.10-linux-${TARGETARCH}.tar.gz \
  && mv pandoc-3.10/bin/* /usr/local/bin/ \
  && rm -rf pandoc-3.10*

CMD ["R"]
