ARG BASE_IMAGE=rapporteket/rstudio:main

FROM ${BASE_IMAGE}

RUN --mount=type=secret,id=gh_pat,env=GITHUB_PAT \
 R -e "remotes::install_github(c(\
         'Rapporteket/ablanor', \
         'Rapporteket/barnehofte', \
         'Rapporteket/fraktur', \
         'Rapporteket/hoftebrudd', \
         'Rapporteket/korsband', \
         'Rapporteket/kvarus', \
         'Rapporteket/leddprotese', \
         'Rapporteket/ltmv', \
         'Rapporteket/ms', \
         'Rapporteket/norartritt', \
         'Rapporteket/NORIC', \
         'Rapporteket/parkinson', \
         'Rapporteket/rapwhale', \
         'Rapporteket/smerte', \
         'Rapporteket/soreg' \
       ), dependencies = TRUE, auth_token = Sys.getenv('GITHUB_PAT'))"
