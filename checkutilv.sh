#! /bin/bash

# BASH script to read a given file as an input where each line int he file contains a utility. 
# Print the version of the utility, if it is installed, else print the statement 
# 'The utility <name> is not installed '


util_list=(google-chrome vlc apache node curl python pacman bash zsh )
for uti in ${util_list[*]}
do
	if [ -z $(which $uti) ]; then
		echo Utility $uti not found
	else
		echo $($uti --version | head -n1)
	fi
done


