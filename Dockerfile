#custom-args: --platform=linux/arm64,linux/amd64 # multiple target architectures
FROM rocker/verse

## INTALLERS
RUN Rscript -e "if(!require('forcats')) install.packages('gt')"
RUN Rscript -e "if(!require('GGally')) install.packages('GGally')"
RUN Rscript -e "if(!require('tidytext')) install.packages('tidytext')"
RUN Rscript -e "if(!require('ggbeeswarm')) install.packages('ggbeeswarm')"
RUN Rscript -e "if(!require('flextable')) install.packages('flextable')"
RUN Rscript -e "if(!require('gtsummary')) install.packages('gtsummary')"
RUN Rscript -e "if(!require('gt')) install.packages('gt')"
RUN Rscript -e "if(!require('rmarkdown')) install.packages('rmarkdown')"
RUN Rscript -e "if(!require('ggplot2')) install.packages('ggplot2')"
RUN Rscript -e "if(!require('remotes')) install.packages('remotes')"
RUN Rscript -e "remotes::install_github('r-lib/hugodown')"

## INSTALL HUGO 0.80.0
RUN wget https://github.com/gohugoio/hugo/releases/download/v0.80.0/hugo_0.80.0_Linux-64bit.tar.gz && \
tar -zxvf hugo_0.80.0_Linux-64bit.tar.gz && \
mv hugo /usr/local/bin/ && \
rm -r hugo*

WORKDIR /app
CMD ["R"]
