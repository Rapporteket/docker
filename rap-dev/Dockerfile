FROM rocker/verse

# need this for ssh through proxy?
RUN apt-get update && apt-get install -y netcat-openbsd

# making proxy def (and other env vars) go all the way into Rstudio console
# based on https://github.com/rocker-org/rocker-versioned/issues/91
ARG PROXY=
ENV http_proxy=${PROXY}
ENV https_proxy=${PROXY}

ARG INSTANCE=DEV
ENV R_RAP_INSTANCE=${INSTANCE}

RUN touch /home/rstudio/.Renviron
RUN echo "http_proxy=${PROXY}" >> /home/rstudio/.Renviron
RUN echo "https_proxy=${PROXY}" >> /home/rstudio/.Renviron
RUN echo "R_RAP_INSTANCE=${INSTANCE}" >> /home/rstudio/.Renviron


# Install base Rapporteket packages in R 
RUN R -e "devtools::install_github('Rapporteket/rapbase', ref='rel')"

