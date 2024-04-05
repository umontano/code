#rhub/r-minimal:4.0.5
#rocker/r-base:4.0.4
#rocker/r-ubuntu:20.04
#rstudio/r-base:4.0.4-focal
#custom-args: --platform=linux/arm64,linux/amd64 # multiple target architectures
FROM rocker/rstudio
## CLONE HUGODOWN
RUN git clone https://github.com/r-lib/hugodown.git
# Set the entry point to R console
CMD ["R"]
