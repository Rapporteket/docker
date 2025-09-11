FROM rapporteket/dev:weekly

LABEL maintainer="Arnfinn Hykkerud Steindal <arnfinn.hykkerud.steindal@helse-nord.no>"

ARG GH_PAT
ENV GITHUB_PAT=${GH_PAT}

ENV MYSQL_HOST=db-ltmv

# add registry dev config and R pkg dependencies
COPY --chown=rstudio:rstudio db.yml /home/rstudio/rap_config/
RUN cat /home/rstudio/rap_config/db.yml >> /home/rstudio/rap_config/dbConfig.yml \
    && rm /home/rstudio/rap_config/db.yml \
    && echo "MYSQL_HOST=${MYSQL_HOST}" >> /home/rstudio/.Renviron \
    && echo "MYSQL_HOST=${MYSQL_HOST}" >> /home/shiny/.Renviron \
    && R -e "install.packages(c('covr', \
                                'dplyr', \
                                'ggplot2', \
                                'lintr', \
                                'magrittr', \
                                'rlang', \
                                'rpivotTable', \
                                'shiny', \
                                'shinyalert', \
                                'testthat'))" \
    && R -e "remotes::install_github(c('Rapporteket/rapbase@*release'))"
