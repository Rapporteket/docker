FROM rapporteket/dev:main

ARG GITHUB_PAT

# add registry dev config and R pkg dependencies
COPY --chown=rstudio:rstudio db.yml /home/rstudio/rap_config/
COPY --chown=rstudio:rstudio rapbase.yml /home/rstudio/rap_config/
RUN cat /home/rstudio/rap_config/db.yml >> /home/rstudio/rap_config/dbConfig.yml \
    && cat /home/rstudio/rap_config/rapbase.yml >> /home/rstudio/rap_config/rapbaseConfig.yml \
    && rm /home/rstudio/rap_config/db.yml \
    && rm /home/rstudio/rap_config/rapbase.yml \
    && R -e "install.packages(c('car', \
                                'covr', \
                                'dplyr', \
                                'DT', \
                                'ggplot2', \
                                'Hmisc', \
                                'janitor', \
                                'kableExtra', \
                                'knitr', \
                                'lintr', \
                                'lubridate', \
                                'magrittr', \
                                'markdown', \
                                'RColorBrewer', \
                                'readr', \
                                'revealjs', \
                                'rlang', \
                                'rmarkdown', \
                                'rpivotTable', \
                                'shiny', \
                                'shinyalert', \
                                'shinycssloaders', \
                                'testthat', \
                                'tidyr', \
                                'tidyselect', \
                                'xtable', \
                                'yaml'))" \
    && R -e "remotes::install_github(c('Rapporteket/noric', 'Rapporteket/rapbase@main'))"
