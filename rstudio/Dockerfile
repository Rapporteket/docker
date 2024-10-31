FROM rocker/verse:4.4.2

LABEL maintainer "Arnfinn Hykkerud Steindal <arnfinn.hykkerud.steindal@helse-nord.no>"

RUN echo "www-frame-origin=same" >> /etc/rstudio/disable_auth_rserver.conf \
  && echo "www-verify-user-agent=0" >> /etc/rstudio/disable_auth_rserver.conf

COPY 03_setup_root_path.sh /etc/cont-init.d/03_setup_root_path.sh

COPY 04_copy_env.sh /etc/cont-init.d/04_copy_env.sh
