FROM rapporteket/dev:weekly

LABEL maintainer="Arnfinn Hykkerud Steindal <arnfinn.steindal@helse-nord.no>"

ARG GH_PAT
ENV GITHUB_PAT=${GH_PAT}

COPY --chown=rstudio:rstudio db.yml ${R_RAP_CONFIG_PATH}/
RUN cat ${R_RAP_CONFIG_PATH}/db.yml >> ${R_RAP_CONFIG_PATH}/dbConfig.yml \
    && rm ${R_RAP_CONFIG_PATH}/db.yml \
    && chmod ugo+rw ${R_RAP_CONFIG_PATH}/* \
    && R -e "install.packages(c('binom', \
                                'covr', \
                                'dplyr', \
                                'DT', \
                                'janitor', \
                                'kableExtra', \
                                'knitr', \
                                'lintr', \
                                'lubridate', \
                                'magrittr', \
                                'readr', \
                                'rlang', \
                                'rmarkdown', \
                                'rpivotTable', \
                                'shiny', \
                                'shinyalert', \
                                'shinycssloaders', \
                                'stringr', \
                                'testthat', \
                                'tidyselect', \
                                'xtable'))" \
    && R -e "remotes::install_github(c('Rapporteket/rapbase', \
    'Rapporteket/ablanor'))"
