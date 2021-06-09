#! /bin/bash
#
# BASH script to find unique IP address, find how many request have been made and how many non 200 response have been made

awk '{ print $1 }' access.log | sort | uniq -c
echo -e "\n"

