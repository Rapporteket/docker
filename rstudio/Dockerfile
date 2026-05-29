FROM rocker/tidyverse:4.6.0

LABEL maintainer="Arnfinn Hykkerud Steindal <arnfinn.hykkerud.steindal@helse-nord.no>"

ENV DEBIAN_FRONTEND=noninteractive

# system libraries of general use
# hadolint ignore=DL3008
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils \
    locales \
    locales-all \
    default-mysql-client \
    netcat-openbsd \
    tzdata \
    libgit2-dev \
    sudo \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    libssl-dev \
    libmariadb-dev \
    libmariadb-dev-compat \
    libharfbuzz-dev \
    libfribidi-dev \
    # mssql odbc stuff
    unixodbc \
    unixodbc-dev \
    tdsodbc \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# testing: shiny-server just do not get anything but locale C
RUN locale-gen nb_NO.UTF-8

# System locales
ENV LANG=nb_NO.UTF-8
ENV LC_ALL=nb_NO.UTF-8
ENV LC_TIME=nb_NO.UTF-8
RUN echo "LANG=\"nb_NO.UTF-8\"" > /etc/default/locale
ENV TZ=Europe/Oslo

# making proxy def (and other env vars) go all the way into Rstudio
# console, based on
# https://github.com/rocker-org/rocker-versioned/issues/91
ARG GITHUB_PAT=
ENV GITHUB_PAT=${GITHUB_PAT}

ARG CONFIG_PATH=/home/rstudio/rap_config
ENV R_RAP_CONFIG_PATH=${CONFIG_PATH}
RUN mkdir -p ${CONFIG_PATH} \
    && chmod ugo+rwx ${CONFIG_PATH}

# add rstudio user to root group  and enable shiny server
ENV ROOT=TRUE

## provide users rstudio and shiny with corresponding environmental settings, install and config
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN R -e "install.packages(c('remotes', 'lifecycle', 'testthat', 'lintr'), repos='https://cloud.r-project.org/')" \
    && R -e "remotes::install_github('rapporteket/rapbase@*release', dependencies = TRUE)" \
    && R -e "file.copy(system.file(c('rapbaseConfig.yml'), package = 'rapbase'), Sys.getenv('R_RAP_CONFIG_PATH'))" \
    && chown rstudio:rstudio ${CONFIG_PATH}/* \
    && chmod ugo+rw ${CONFIG_PATH}/* \
    && wget -q http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz \
    && tar -xf install-tl-unx.tar.gz \
    && "$(tar -tf install-tl-unx.tar.gz | head -1)"install-tl -no-doc-install \
                                                              -no-src-install \
                                                              -no-interaction \
                                                              -scheme scheme-basic \
                                                              -texdir /usr/local/texlive \
    && rm -rf install-tl-*

# for amd64 architecture
ENV PATH=/usr/local/texlive/bin/x86_64-linux/:${PATH}

# for arm64 architecture
ENV PATH=/usr/local/texlive/bin/aarch64-linux/:${PATH}

RUN tlmgr update --self --all \
    && tlmgr install \
        amsmath \
        babel-norsk \
        beamer \
        bigintcalc \
        bitset \
        booktabs \
        caption \
        collection-langeuropean \
        datetime \
        epstopdf-pkg \
        eso-pic \
        etexcmds \
        etoolbox \
        fancyhdr \
        float \
        fmtcount \
        fontaxes \
        framed \
        geometry \
        gettitlestring \
        grfext \
        hycolor \
        hyperref \
        hyphen-norwegian \
        intcalc \
        kvdefinekeys \
        kvsetkeys \
        lastpage \
        latex-amsmath-dev \
        lato \
        letltxmacro \
        ltxcmds \
        marginnote \
        microtype \
        oberdiek \
        pdfescape \
        pdflscape \
        pdfpages \
        ragged2e \
        refcount \
        rerunfilecheck \
        sectsty \
        silence \
        stringenc \
        subfig \
        textpos \
        titlesec \
        ucs \
        uniquecounter \
        xcolor \
        xkeyval \
        zapfding
