FROM pandoc/minimal:3.11.0 AS pandoc-source

FROM rhub/r-minimal:4.6.1

COPY --from=pandoc-source /usr/local/bin/pandoc /usr/local/bin/pandoc

ENV LC_ALL=nb_NO.UTF-8
ENV LANG=nb_NO.UTF-8

ARG TARGETARCH
ARG GITHUB_PAT

RUN installr -d \
     -t "cmake libuv-dev icu-dev libpng-dev fontconfig-dev freetype-dev fribidi-dev harfbuzz-dev libxml2-dev libx11-dev mariadb-dev curl-dev git cairo-dev" \
     -a "mariadb-connector-c-dev libuv fontconfig harfbuzz fribidi libxml2 cairo harfbuzz-icu font-liberation mariadb-client jpeg-dev tiff-dev libwebp-dev" \
           bookdown \
           bslib \
           Cairo \
           DBI \
           digest \
           DT \
           jsonlite \
           kableExtra \
           knitr \
           logger \
           plotly \
           remotes \
           rlang \
           RMariaDB \
           rmarkdown \
           sendmailR \
           shiny \
           shinyalert \
           sship \
           tidyverse \
  && R -e "remotes::install_github('Rapporteket/rapbase')"

CMD ["R"]
