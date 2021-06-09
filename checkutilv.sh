#! /bin/bash

# BASH script to read a given file as an input where each line int he file contains a utility. 
# Print the version of the utility, if it is installed, else print the statement 
# 'The utility <name> is not installed '

file='./utillist.txt'
while read line; do
if [[ -z $(which $line) ]]; then
	echo Utility $line not found
else
	echo $($line --version | head -n1)
fi
done  < $file


