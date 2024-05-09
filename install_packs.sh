#!/bin/sh
arch_dependencies=\
'icu
gcc-fortran'

archlinux_r_packs=\
'kableExtra
flextable
reactable'

cran_packs=\
'shiny
rmarkdown
tidyverse
tidytext
forcats
remotes
dplyr
ggplot2
flextable
psych
cowplot
gridExtra'

common_packs=\
'ggcorrplot
widyr
ggbeeswarm
gt
gtsummary'

precompiled_repos=\
"repos = c('https://apache.r-universe.dev', 'https://cloud.r-project.org', 'https://ddsjoberg.r-universe.dev')"

install_with_apt()
{
	apt-get update
	apt-get clean
	apt-get -y --no-install-recommends install r-base
#apt-get install -y r-base-dev || echo __APTTED__"$pack"
#apt-get install -y r-recommended || echo __APTTED__"$pack"
apt-get clean || echo __APTTED__"$pack"
#apt-get autoclean || echo __APTTED__"$pack"
#apt-get autoremove -y || echo __APTTED__"$pack"
#dpkg --configure -a || echo __APTTED__"$pack"
#apt --fix-broken install -y || echo __APTTED__"$pack"

echo "$cran_packs" | while read -r pack
do
	if command -v "$pack" >/dev/null 2>&1; then
	    echo "$pack is installed."
	else
	    echo "$pack is not installed."
		apt-get -y --no-install-recommends install r-cran-"$pack" || echo __APTTED__"$pack"
		apt-get clean || echo __APTTED__"$pack"
		#apt-get autoclean || echo __APTTED__"$pack"
		#apt-get autoremove -y || echo __APTTED__"$pack"
		#dpkg --configure -a || echo __APTTED__"$pack"
		#apt --fix-broken install -y || echo __APTTED__"$pack"
	fi
done
}

require_conditional_install()
{
echo "$common_packs" | while read -r pack
do 
	echo ___rscipt_ins_"$pack"
	Rscript -e "if(!require('${pack}')) install.packages('${pack}', ${precompiled_repos})"
done

Rscript -e "if(!require(hugodown)) remotes::install_github('r-lib/hugodown', update = 'never')"
}

## CHECK DEBUG FLAG
if test "$1" = "debug"
then
    echo "The positional argument is 'debug'"
	echo ___DEBUG_FLAG___
	require_conditional_install
else
    echo "The positional argument is not 'debug'"
	echo ___NO_FLAG___
	install_with_apt
	require_conditional_install
fi

apt-get clean

## arm
#https://github.com/gohugoio/hugo/releases/download/v0.80.0/hugo_0.80.0_Linux-ARM.tar.gz
## arch64v8
#https://github.com/gohugoio/hugo/releases/download/v0.80.0/hugo_0.80.0_Linux-ARM64.tar.gz
## x86_64
#https://github.com/gohugoio/hugo/releases/download/v0.80.0/hugo_0.80.0_Linux-64bit.tar.gz
## mac
#https://github.com/gohugoio/hugo/releases/download/v0.80.0/hugo_extended_0.80.0_macOS-64bit.tar.gz
## windows
#https://github.com/gohugoio/hugo/releases/download/v0.80.0/hugo_extended_0.80.0_Windows-64bit.zip