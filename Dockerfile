#custom-args: --platform=linux/arm64,linux/amd64 # multiple target architectures

FROM rocker/verse

## INTALLER
RUN Rscript -e "if(!require('ggally')) install.packages('ggally')"
RUN Rscript -e "if(!require('tidytext')) install.packages('tidytext')"
RUN Rscript -e "if(!require('ggbeeswarm')) install.packages('ggbeeswarm')"
RUN Rscript -e "if(!require('flextable')) install.packages('flextable')"
RUN Rscript -e "if(!require('gtsummary')) install.packages('gtsummary')"
RUN Rscript -e "if(!require('gt')) install.packages('gt')"
RUN Rscript -e "if(!require('rmarkdown')) install.packages('rmarkdown')"
RUN Rscript -e "if(!require('ggplot2')) install.packages('ggplot2')"
RUN Rscript -e "if(!require('remotes')) install.packages('remotes')"
RUN Rscript -e "remotes::install_github('r-lib/hugodown')"

CMD ["R"]
