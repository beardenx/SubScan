#!/bin/bash

figlet -f big "subscan"
echo "Author : beardenx"

echo "Github : https://github.com/beardenx\n"

if [ $# -gt 2 ]; then
 	echo "Usage: ./runit.sh <domain>"
 	echo "Example: ./runit.sh yahoo.com"
 	exit 1
fi	

if [ ! -d "NmapScan" ]; then
	mkdir NmapScan
fi

echo "Gathering Subdomain with Amass..."
amass enum -d $1 >> subdomains.txt

echo "Probing for alive subdomain..."
cat subdomains.txt | httprobe -s -p https:443 | sed 's/https\?:\/\///' | tr -d ":443" > probe.txt

echo "Scanning for open ports with Nmap..."
nmap -iL probe.txt -T5 -oA NmapScan/scanned.txt
