FROM codercom/code-server:4.16.1

ARG GH_PAT
ENV GITHUB_PAT=${GH_PAT}

RUN sudo apt-get update && sudo apt-get install -y --no-install-recommends \
    r-base \
    r-base-dev \
    apt-utils \
    locales \
    locales-all \
    default-mysql-client \
    netcat-openbsd \
    tzdata \
    libgit2-dev \
    sudo \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    libxml2-dev \
    libssl-dev \
    libmariadb-dev \
    libmariadb-dev-compat \
    libharfbuzz-dev \
    libfribidi-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    texlive-base \
    texlive-binaries \
    texlive-pictures \
    texlive-latex-base \
    texlive-latex-recommended \
    texlive-latex-extra \
    && sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG R_LIBS_USER=/home/coder/R/library
ENV R_LIBS_USER=${R_LIBS_USER}

RUN touch /home/coder/.Renviron \
    && echo "R_LIBS_USER=${R_LIBS_USER}" >> /home/coder/.Renviron \
    && mkdir -p /home/coder/R/library \
    && R -e "install.packages(c('remotes', 'devtools'), lib = '/home/coder/R/library')" \
    && R -e "remotes::install_github('Rapporteket/rapbase@*release', lib = '/home/coder/R/library')"

