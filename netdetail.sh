#! /bin/bash

# BASH script to print public IP, show a list of available SSID order by strength
# gets the password of currently connected SSID, delete already saved connection ruchishivani

touch netout.txt
echo IPv4 address: $(curl ifconfig.me) 1>netout.txt

echo SSIDs order by strength: 1>>netout.txt

nmcli device wifi list 1>>netout.txt

nmcli device wifi show | grep -i password 1>>netout.txt

cat netout.txt
#uncomment below 2 lines - delete connection ruchishivani
#nmcli device connection delete ruchishivani 
echo connection deleted "ruchishivani"

 
