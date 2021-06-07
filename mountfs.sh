#! /bin/bash

# BASH script to list all the mount and their types

cd ~/Documents/Projects/
mount 1> mountOutput.txt

awk ' { print $3,$5 } ' ./mountOutput.txt
