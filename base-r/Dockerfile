FROM rocker/r-ver:4.4.1

LABEL maintainer="Arnfinn Hykkerud Steindal <arnfinn.hykkerud.steindal@helse-nord.no>"

# hadolint ignore=DL3008
RUN apt-get update && apt-get install -y --no-install-recommends \
    pandoc \
    libmariadb-dev \
    libmysqlclient21 \
    lmodern \
    locales \
    perl \
    wget \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set norsk bokmaal as default system locale
RUN sed -i 's/^# *\(nb_NO.UTF-8\)/\1/' /etc/locale.gen \
    && locale-gen \
    && echo "LANG=\"nb_NO.UTF-8\"" > /etc/default/locale \
    && update-locale LANG=nb_NO.utf8

ENV LC_ALL=nb_NO.UTF-8
ENV LANG=nb_NO.UTF-8
ENV TZ=Europe/Oslo

# install R package dependencies and TinyTeX
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN install2.r --error --skipinstalled --ncpus -1 \
    remotes \
    && R -e "remotes::install_github('rapporteket/rapbase@*release')"\
    && rm -rf /tmp/downloaded_packages \ 
    && wget -q http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz \
    && tar -xf install-tl-unx.tar.gz \
    && "$(tar -tf install-tl-unx.tar.gz | head -1)"install-tl -no-doc-install \
                                                              -no-src-install \
                                                              -no-interaction \
                                                              -scheme scheme-basic \
                                                              -texdir /usr/local/texlive \
    && rm -rf install-tl-*

ENV PATH=/usr/local/texlive/bin/x86_64-linux/:${PATH}

RUN tlmgr update --self && tlmgr install \
        babel-norsk \
        beamer \
        bigintcalc \
        bitset \
        booktabs \
        caption \
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

CMD ["R"]
