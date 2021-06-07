#! /bin/bash

# BASH script to print dates from today till end of the month

NDATE=$(date -d $(date +%Y)$(date +%m)01+1month-1day +%d)
TDATE=$(date -d now +%d)

for i in $(seq -f "%02g" $TDATE $NDATE); do echo $i/$(date +%m)/$(date +%Y) ; done
