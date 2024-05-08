#custom-args: --platform=linux/arm64,linux/amd64 # multiple target architectures
FROM rocker/verse

ENV common_packs='psych ggcorrplot widyr ggbeeswarm gt gtsummary'
RUN for pack in "$common_packs"; do Rscript -e "if(!require('${pack}')) install.packages('${pack}')"; done
## INSTALLERS
RUN Rscript -e "if(!require('forcats')) install.packages('forcats')"
RUN Rscript -e "if(!require('GGally')) install.packages('GGally')"
RUN Rscript -e "if(!require('tidytext')) install.packages('tidytext')"
RUN Rscript -e "if(!require('flextable')) install.packages('flextable')"
RUN Rscript -e "if(!require('rmarkdown')) install.packages('rmarkdown')"
RUN Rscript -e "if(!require('ggplot2')) install.packages('ggplot2')"
RUN Rscript -e "if(!require('remotes')) install.packages('remotes')"
RUN Rscript -e "remotes::install_github('r-lib/hugodown')"
RUN Rscript -e "if(!require('GGally')) install.packages('GGally')"
RUN Rscript -e "if(!require('cowplot')) install.packages('cowplot')"
RUN Rscript -e "if(!require('gridExtra')) install.packages('gridExtra')"
RUN Rscript -e "if(!require('psych')) install.packages('psych')"
RUN Rscript -e "if(!require('ggcorrplot')) install.packages('ggcorrplot')"
RUN Rscript -e "if(!require('widyr')) install.packages('widyr')"
RUN Rscript -e "if(!require('ggbeeswarm')) install.packages('ggbeeswarm')"
RUN Rscript -e "if(!require('gtsummary')) install.packages('gtsummary')"
RUN Rscript -e "if(!require('gt')) install.packages('gt')"


## INSTALL HUGO 0.80.0
RUN wget https://github.com/gohugoio/hugo/releases/download/v0.80.0/hugo_0.80.0_Linux-64bit.tar.gz && \
tar -zxvf hugo_0.80.0_Linux-64bit.tar.gz && \
mv hugo /usr/local/bin/ && \
rm -r hugo*

WORKDIR /app
CMD ["R"]
