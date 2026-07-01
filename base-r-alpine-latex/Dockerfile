FROM rapporteket/base-r-alpine:weekly

LABEL maintainer="Arnfinn Hykkerud Steindal <arnfinn.hykkerud.steindal@helse-nord.no>"

# for amd64 architecture
ENV PATH=/usr/local/texlive/bin/x86_64-linuxmusl:${PATH}

# for arm64 architecture
ENV PATH=/usr/local/texlive/bin/aarch64-linuxmusl/:${PATH}

# hadolint ignore=DL3018
RUN apk add --no-cache perl wget tar \
  && wget -q http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz \
  && tar -xf install-tl-unx.tar.gz --one-top-level --strip-components=1 \
  && install-tl-unx/install-tl -no-doc-install \
                               -no-src-install \
                               -no-interaction \
                               -scheme scheme-basic \
                               -texdir /usr/local/texlive \
  && rm -rf install-tl-* \
  && apk del tar \
  && pdflatex --version \
  && tlmgr update --self && tlmgr install \
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
