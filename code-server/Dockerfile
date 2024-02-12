FROM codercom/code-server:4.21.0

WORKDIR /home/coder

ARG GH_PAT
ENV GITHUB_PAT=${GH_PAT}

USER root

# hadolint ignore=DL3008
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils \
    default-mysql-client \
    libcairo2-dev \
    libcurl4-gnutls-dev \
    libfreetype6-dev \
    libfribidi-dev \
    libgit2-dev \
    libharfbuzz-dev \
    libmariadb-dev \
    libmariadb-dev-compat \
    libpng-dev \
    libssl-dev \
    libtiff5-dev \
    libxt-dev \
    libxml2-dev \
    locales \
    locales-all \
    netcat-openbsd \
    pandoc \
    r-base \
    r-base-dev \
    tzdata \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER 1000

COPY settings.json ./.local/share/code-server/User/settings.json

ARG R_LIBS_USER=/home/coder/.config/R/library:/home/coder/R/library
ENV R_LIBS_USER=${R_LIBS_USER}

ARG R_RAP_CONFIG_PATH=/home/coder/.config/rap_config
ENV R_RAP_CONFIG_PATH=${R_RAP_CONFIG_PATH}

RUN touch /home/coder/.Renviron \
    && echo "R_LIBS_USER=${R_LIBS_USER}" >> /home/coder/.Renviron \
    && echo "R_RAP_CONFIG_PATH=${R_RAP_CONFIG_PATH}" >> /home/coder/.Renviron \
    && code-server --install-extension reditorsupport.r \
    && mkdir -p /home/coder/R/library \
    && R -e "install.packages(c('remotes', 'devtools', 'languageserver'), lib = '/home/coder/R/library')" \
    && R -e "remotes::install_github('Rapporteket/rapbase@*release', lib = '/home/coder/R/library')" \
    && wget -q http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz \
    && tar -xf install-tl-unx.tar.gz \
    && "$(tar -tf install-tl-unx.tar.gz | head -1)"install-tl -no-doc-install \
                                                              -no-src-install \
                                                              -no-interaction \
                                                              -scheme scheme-minimal \
                                                              -texdir /home/coder/texlive \
    && rm -rf install-tl-*

ENV PATH=/home/coder/texlive/bin/x86_64-linux/:${PATH}

RUN tlmgr install \
        amsmath \
        babel-norsk \
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
        stringenc \
        subfig \
        textpos \
        titlesec \
        ucs \
        uniquecounter \
        xcolor \
        zapfding
