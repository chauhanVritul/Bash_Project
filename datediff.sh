#! /bin/bash

# BASH script to print difference in days between two dates given as input

# dates should be in the format yyyymmdd

DATE1=$(date +%s -d $1)
DATE2=$(date +%s -d $2)

let DIFF=($DATE1 - $DATE2)/86400
echo $DIFF days
