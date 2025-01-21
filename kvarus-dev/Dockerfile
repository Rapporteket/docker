FROM rapporteket/dev:weekly

LABEL maintainer="Stein-Kato Lindberg <stein-kato.lindberg@helse-nord.no>"

ARG GITHUB_PAT
ENV GITHUB_PAT=${GITHUB_PAT}

RUN R -e "remotes::install_github(c('Rapporteket/kvarus'))"
RUN R -e "install.packages('NHSRplotthedots', dependencies=TRUE, repos='http://cran.rstudio.com/')"
