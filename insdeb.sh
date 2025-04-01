#!/bin/sh
precompiled_cran_packs=\
'
ggtext
ragg
thematic
ggraph
tm
tinytex
ggbeeswarm
lme4
future.apply
GGally
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
rlang
gridExtra
igraph
rsconnect
'

noncompiled_source_rpacks=\
'
webshot2
broom.helpers
showtext
quanteda
report
mirt
ggcorrplot
widyr
gt
gtsummary
'

precompiled_repos=\
"repos = c('https://apache.r-universe.dev', 'https://cloud.r-project.org', 'https://ddsjoberg.r-universe.dev')"

github_remotes="
if(!require(ggmirt)) remotes::install_github('masurp/ggmirt', update = 'never')"

#* deb: libcurl4-openssl-dev (Debian, Ubuntu, etc)
#* rpm: libcurl-devel (Fedora, CentOS, RHEL)
debian_common='
apt-utils
texlive-pictures
lmodern
lynx
build-essential
pandoc
wget
less
texlive-latex-recommended
texlive-latex-extra
'
extradebia=\
'
___texlive-latex-base
libcurl4-openssl-dev
g++
libstdc++-dev
libc6-dev
libcurl4-openssl-dev
libxml2-dev
libssl-dev
libfontconfig1-dev
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




install_debian_apps()
{
	apt-get update
	apt-get clean
	#apt-get -y --no-install-recommends install r-base
	apt-get -y install r-base
	apt-get -y --no-install-recommends install texlive-latex-base

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
}


## CHECK IF CRAN PRECOMPILED R LIBRARIES ARE AVAILABLE
check_cran_available_and_install()
{
	for each_precompiled_cranp in $(echo "$precompiled_cran_packs" | tr '\n' ' ' | tr '[:upper:]' '[:lower:]')
	do
		each_precompiled_cranp=r-cran-"$each_precompiled_cranp"
		if apt-cache show "$each_precompiled_cranp"
		then
		    echo ___"$each_precompiled_cranp ___IS AVAILABLE IN COMPILED CRAN."___
		    apt-get install -y "$each_precompiled_cranp"
		    echo ___FINISHED_INSTALLING___"$each_precompiled_cranp"___
		else
		    echo "$each_precompiled_cranp not avail."
		    echo "$each_precompiled_cranp" >> notcran.txt
		fi
	done
}



requiere_compile_rsource_install()
{
	for each_rsource in $(echo "$noncompiled_source_rpacks" | tr '\n' ' ')
	do
		echo _
		echo ___RSCIPT_INS_"$each_rsource"___
		#Rscript -e "if(!require('${each_rsource}')) install.packages('${each_rsource}', ${precompiled_repos}, dependencies = c('Depends'))"
		Rscript -e "if(!require('${each_rsource}')) install.packages('${each_rsource}', ${precompiled_repos})"
		echo ___DONE_INSTALLING_"$each_rsource"___
		echo ____________
	done
	## INSTALL TINYTEX ONLY IF HUGODOWN R PACKAGE IS NOT INSTALLED
	Rscript -e "if(!require(hugodown)) tinytex::install_tinytex(force= TRUE)"
	## INSTALL WITH REMOTES
	Rscript -e "if(! require(ggmirt)) remotes::install_github('masurp/ggmirt', update = 'never')"
	Rscript -e "if(!require(hugodown)) remotes::install_github('r-lib/hugodown', update = 'never')"
	#https://github.com/jalvesaq/colorout
	#https://github.com/jalvesaq/colorout
	#https://github.com/jalvesaq/colorout
	Rscript -e "if(! require(colorout)) remotes::install_github('jalvesaq/colorout', update = 'never')"
}

everything_installing()
{
	install_debian_apps
	check_cran_available_and_install
	requiere_compile_rsource_install
	grep -q 'colorout' ~/.Rprofile && echo ___COLOROUT_FOUND___ || echo 'library(colorout)' >> ~/.Rprofile
}

## CHECK DEBUG FLAG
if test "$1" = "build"
then
    echo "The positional argument is 'build'"
	echo ___BUILD_FLAG___
	requiere_compile_rsource_install
else
    echo "The positional argument is not 'build'"
	echo ___NO_FLAG___
	everything_installing
fi

## INSTALL TINYTEX ONLY IF IT IS NOT INSTALLED WHICH IS MEANT BY THE TEX FLAG
#test "$1" != 'notex' && Rscript -e "tinytex::install_tinytex(force= TRUE)"

apt-get autoremove -y
apt-get clean

