#!/bin/sh
## POSITIONAL PARAMETER EXECUTE OPTIONS: build force github
precompiled_cran_packs=\
'
ggthemes
mice
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
chromote
webshot2
broom.helpers
report
ggcorrplot
widyr
gt
gtsummary
'
needs_compilation_r_packages=\
'
showtext
missForest
quanteda
mirt
'


force_reinstal_within_r_packages_list=\
'
ggplot2
broom
'

precompiled_repos=\
"repos = c('https://apache.r-universe.dev', 'https://cloud.r-project.org', 'https://ddsjoberg.r-universe.dev')"

github_remotes="
if(!require(ggmirt)) remotes::install_github('masurp/ggmirt', update = 'never')"

#* deb: libcurl4-openssl-dev (Debian, Ubuntu, etc)
#* rpm: libcurl-devel (Fedora, CentOS, RHEL)
## SHOWTEXT MISSING FONTS
#"sudo apt-get install libfreetype6-dev"
debian_common='
libfreetype6-dev
libfreetype6
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
	for each_rsource in $noncompiled_source_rpacks
	do
		echo _
		echo ___RSCIPT_INS_"$each_rsource"___
		#Rscript -e "if(!require('${each_rsource}')) install.packages('${each_rsource}', ${precompiled_repos}, dependencies = c('Depends'))"
		Rscript -e "if(!require('${each_rsource}')) install.packages('${each_rsource}', ${precompiled_repos})"
		echo ___DONE_INSTALLING_"$each_rsource"___
		echo ____________
	done
}


requiere_needs_compilation_r_packages_install()
{
	for each_rsource in $needs_compilation_r_packages
	do
		echo _
		echo ___RSCIPT_INS_"$each_rsource"___
		#Rscript -e "if(!require('${each_rsource}')) install.packages('${each_rsource}', ${precompiled_repos}, dependencies = c('Depends'))"
		Rscript -e "if(!require('${each_rsource}')) install.packages('${each_rsource}', ${precompiled_repos})"
		echo ___DONE_INSTALLING_"$each_rsource"___
		echo ____________
	done
}

require_remotes_github_install_fn()
{
	echo ___GITHUB_REMOTES_INSTALL___
	## INSTALL TINYTEX ONLY IF HUGODOWN R PACKAGE IS NOT INSTALLED
	Rscript -e "if(!require(hugodown)) tinytex::install_tinytex(force= TRUE)"
	## INSTALL WITH REMOTES
	Rscript -e "if(!require(ggmirt)) remotes::install_github('masurp/ggmirt', update = 'never')"
	Rscript -e "if(!require(hugodown)) remotes::install_github('r-lib/hugodown', update = 'never')"
	#https://github.com/jalvesaq/colorout
	#https://github.com/jalvesaq/colorout
	#https://github.com/jalvesaq/colorout
	Rscript -e "if(! require(colorout)) remotes::install_github('jalvesaq/colorout', update = 'never')"
}

force_reinstall_rpacks()
{
	for each_reinstallee in $force_reinstal_within_r_packages_list
	do
		echo _
		echo ___FORCE REINSTALL_"$each_reinstallee"___
		Rscript -e "install.packages('${each_reinstallee}', ${precompiled_repos})"
		echo ___DONE_REINS_"$each_reinstallee"___
		echo ____________
	done
}

everything_installing()
{
	install_debian_apps
	check_cran_available_and_install
	requiere_compile_rsource_install
	requiere_needs_compilation_r_packages_install
	require_remotes_github_install_fn
	force_reinstall_rpacks
	grep -q 'colorout' ~/.Rprofile && echo ___COLOROUT_FOUND___ || echo 'library(colorout)' >> ~/.Rprofile
	apt-get autoremove -y
	apt-get clean
}


##################################################
## DEFINITION OF SHORHAND FUNCTIONS
##################################################
build() { echo '___BUILD____'; requiere_compile_rsource_install; requiere_needs_compilation_r_packages_install; }
force() { echo '___FORCE____'; force_reinstall_rpacks; }
github() { echo '___GITHUB____'; require_remotes_github_install_fn; }

## CHEKING WHETHER THERE IS A FLAG AND EXECUTE ONLY SUCH FLAG
rm ~/.Rprofile 
if test -z $1
then
	echo ___no_INPUT____
	echo ___NO_FLAG___
	echo ___INSTALLING_EVERYTHIHG____
	everything_installing
else
	echo ___BUILD_FLAG___
	echo "$1"____THE_POSITIONAL_ARGUMENT_WILL_BE_CALLED___"$1"
	## CALL THE SHORTHAND ALIASING FUNCTION
	$1
	## ADD COLOR TO  LOGIN PROFILE
	grep -q 'colorout' ~/.Rprofile && echo ___COLOROUT_FOUND___ || echo 'library(colorout)' >> ~/.Rprofile
fi
## INSTALL TINYTEX ONLY IF IT IS NOT INSTALLED WHICH IS MEANT BY THE TEX FLAG
#test "$1" != 'notex' && Rscript -e "tinytex::install_tinytex(force= TRUE)"
