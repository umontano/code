#rhub/r-minimal:4.0.5
#rocker/r-base:4.0.4
#rocker/r-ubuntu:20.04
#rstudio/r-base:4.0.4-focal
FROM rocker/rstudio
RUN apt-get install -y \
				r-cran-downlit \
				r-cran-rcpptoml \
				r-cran-usethis \
				r-cran-whisker \
				r-cran-whoami \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

## CLONE HUGODOWN
#RUN git clone https://github.com/r-lib/hugodown.git
#RUN R CMD INSTALL hugodown/
# Set the entry point to R console
CMD ["R"]
