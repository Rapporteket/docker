FROM rapporteket/dev:weekly

LABEL maintainer="Arnfinn Hykkerud Steindal <arnfinn.steindal@helse-nord.no>"

COPY --chown=rstudio:rstudio db.yml /home/rstudio/
RUN --mount=type=secret,id=github_pat,env=GITHUB_PAT \
    cat /home/rstudio/db.yml >> /home/rstudio/dbConfig.yml \
    && rm /home/rstudio/db.yml \
    && chmod ugo+rw /home/rstudio/* \
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
    && R -e "remotes::install_github(c('Rapporteket/ablanor', \
    'Rapporteket/rapbase@main'))"
