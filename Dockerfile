#rhub/r-minimal:4.0.5
#rocker/r-base:4.0.4
#rocker/r-ubuntu:20.04
#rstudio/r-base:4.0.4-focal
FROM ckrusemd/bookdown-action
RUN R -e \
'packs <- c(
"remotes",
"ggplot2",
"ggbeeswarm"
)
out <- lapply(packs, function(x) {if (!require(x)) install.packages(x) })
'

#RUN R -e 'install.packages("ggbeeswarm", "remotes")'
RUN R -e 'remotes::install_github("r-lib/hugodown", dependencies = FALSE, upgrade = "never")'
#RUN R -e 'remotes::install_github("r-lib/hugodown")'
## CLONE HUGODOWN
#RUN git clone https://github.com/r-lib/hugodown.git
#RUN R CMD INSTALL hugodown/
# Set the entry point to R console
CMD ["R"]
