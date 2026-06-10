FROM rhub/r-minimal:4.6.0

LABEL maintainer="Arnfinn Hykkerud Steindal <arnfinn.hykkerud.steindal@helse-nord.no>"

ENV LC_ALL=nb_NO.UTF-8
ENV LANG=nb_NO.UTF-8

ARG TARGETARCH
ARG GITHUB_PAT

RUN installr -d \
     -t "cmake libuv-dev icu-dev libpng-dev fontconfig-dev freetype-dev fribidi-dev harfbuzz-dev libxml2-dev libx11-dev mariadb-dev curl-dev git cairo-dev" \
     -a "mariadb-connector-c-dev libuv fontconfig harfbuzz fribidi libxml2 cairo harfbuzz-icu font-liberation mariadb-client" \
           bookdown \
           bslib \
           DBI \
           digest \
           dplyr \
           DT \
           jsonlite \
           kableExtra \
           knitr \
           logger \
           readr \
           rlang \
           RMariaDB \
           rmarkdown \
           sendmailR \
           shiny \
           shinyalert \
           sship \
           utils \
           ggplot2 \
           remotes \
           Cairo \
  && R -e "remotes::install_github('Rapporteket/rapbase')" \
  && wget -q https://github.com/jgm/pandoc/releases/download/2.19.2/pandoc-2.19.2-linux-${TARGETARCH}.tar.gz \
  && tar xzf pandoc-2.19.2-linux-${TARGETARCH}.tar.gz \
  && mv pandoc-2.19.2/bin/* /usr/local/bin/ \
  && rm -rf pandoc-2.19.2* \
  && apk add --no-cache perl wget xz tar \
  && wget -q http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz \
  && tar -xf install-tl-unx.tar.gz \
  && "$(tar -tf install-tl-unx.tar.gz | head -1)"install-tl -no-doc-install \
                                                            -no-src-install \
                                                            -no-interaction \
                                                            -scheme scheme-basic \
                                                            -texdir /usr/local/texlive \
  && rm -rf install-tl-*

# for amd64 architecture
ENV PATH=/usr/local/texlive/bin/x86_64-linuxmusl:${PATH}

# for arm64 architecture
ENV PATH=/usr/local/texlive/bin/aarch64-linuxmusl/:${PATH}

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

CMD ["R"]
