#custom-args: --platform=linux/arm64,linux/amd64 # multiple target architectures

# Use ARMv7 base image with R and required dependencies
FROM arm32v7/debian

# Set environment variables
ENV R_HOME=/usr/lib/R
ENV R_LIBS_USER=/usr/local/lib/R/site-library
ENV TZ=UTC
RUN touch zzzz.zzz
# Install system dependencies
# Install required R packages
## HUGODOWN DEVTOOLS ONE-LINER \
## hugodown missing dependencies \
#RUN apt-get update && \
    #apt-get install -y \
        #libcurl4-openssl-dev \
        #libssl-dev \
        #libxml2-dev \
        #pandoc \
        #pandoc-citeproc \
        #wget \
        #neovim \
        #r-base \
				#r-cran-rmarkdown \
				#r-cran-remotes \
				#r-cran-downlit \
				#r-cran-rcpptoml \
				#r-cran-usethis \
				#r-cran-whisker \
				#r-cran-whoami \
        #&& \
    #apt-get clean
#

# Install hugodown from GitHub
#RUN R -e 'remotes::install_github("r-lib/hugodown", dependencies = FALSE, upgrade = "never")'

# Set the entry point to R console
CMD ["R"]

