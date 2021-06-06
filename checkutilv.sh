#! /bin/bash

util_list=(google-chrome vlc apache node curl python pacman bash zsh )
for uti in ${util_list[*]}
do
	if [ -z $(which $uti) ]; then
		echo Utility $uti not found
	else
		echo $($uti --version | head -n1)
	fi
done


