#!/bin/sh
debian_common='
wget
texlive-latex-base
pandoc
less
'
texlive_debian='
texlive-latex-base
texlive-core
texlive-base
texlive-latex-base
texlive-fonts-recommended
texlive-latex-extra
'

arch_dependencies=\
'icu
gcc-fortran'

archlinux_r_packs=\
'kableExtra
flextable
reactable'

cran_packs=\
'kableextra
ggally
semplot
evaluate
gert
v8
lavaan
semtools
erm
tinytex
shiny
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
'report
mirt
ggcorrplot
widyr
ggbeeswarm
gt
gtsummary
tinytex'


precompiled_repos=\
"repos = c('https://apache.r-universe.dev', 'https://cloud.r-project.org', 'https://ddsjoberg.r-universe.dev')"

github_remotes="
if(!require(ggmirt)) remotes::install_github('masurp/ggmirt', update = 'never')"

install_with_apt()
{
	apt-get update
	apt-get clean
	apt-get -y --no-install-recommends install r-base

## REMOVE INITIAL AND FINAL NEWLINE CHARACTERS AND REPLACE NEWLINES WITH SPACES
packages=$(echo "$debian_common" | tr '\n' ' ' | sed '1s/^[ \t]*//; $s/[ \t]*$//; s/\n/ /g')
echo "$packages"
## LOOP THROUGH THE LIST
echo "Packages to be installed:"

## NOTE THAT THE PAKAGES VARIABLE IS UNQUOTED, THIS IF NEED TO SEPARATE BY SPACES _ THE QUOTATION SHOWSS A SINGEL STRING
for package in $packages
do
    echo ___TO_BE_I__"$package"
	apt-get install -y --no-install-recommends "$package" || echo __DEBIAN_INSTALLED__"$package"
    echo ___INSTALLED___"$package"
	apt-get clean
done


#apt-get install -y r-base-dev || echo __APTTED__"$pack"
#apt-get install -y r-recommended || echo __APTTED__"$pack"
apt-get clean || echo __APTTED__"$pack"
#apt-get autoclean || echo __APTTED__"$pack"
#apt-get autoremove -y || echo __APTTED__"$pack"
#dpkg --configure -a || echo __APTTED__"$pack"
#apt --fix-broken install -y || echo __APTTED__"$pack"
echo "$debian_common" | while read -r pack
do 
	echo __DEBIAN_TO_I__"$package"
	#apt-get -y install "$package" || echo __DEBIAN_INSTALLED__"$package"
	#apt-get clean
done

## INSTALL R LIBRARIES
echo "$cran_packs" | while read -r pack
do
    pack=r-cran-"$pack"
	if command -v "$pack" >/dev/null 2>&1; then
	    echo "$pack is installed."
	else
	    echo "$pack is not installed."
		apt-get -y --no-install-recommends install "$pack" || echo __APTTED__"$pack"
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
	Rscript -e "tinytex::install_tinytex(force= TRUE)"
	Rscript -e "if(!require(ggmirt)) remotes::install_github('masurp/ggmirt', update = 'never')"
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

#Rscript -e "tinytex::install_tinytex(force= TRUE)"
apt-get autoremove -y
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
