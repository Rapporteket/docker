FROM rap-dev

# our own touch to shiny-server
RUN rm /srv/shiny-server/index.html
RUN rm -rf /srv/shiny-server/sample-apps
RUN usermod -a -G staff shiny
ADD --chown=root:root rapShinyApps.tar.gz /srv/shiny-server/

# add data payload and scripts
#COPY --chown=rstudio:rstudio payload.tar.gz /home/rstudio/regData/
COPY --chown=rstudio:rstudio dec.sh /home/rstudio/regData/
COPY --chown=rstudio:rstudio init.sh /home/rstudio/
