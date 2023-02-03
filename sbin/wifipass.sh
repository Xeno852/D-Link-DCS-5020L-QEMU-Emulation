#!/bin/sh
#
# usage: wifipass.sh $1 $2
#

MacAddress=$1
salt=$2
wifipass=$(echo -n "${MacAddress}${salt}" | openssl dgst -sha256 2> /dev/null | cut -c 57-64 | sed -e 's/0/P/g' -e 's/1/Q/g' -e 's/2/R/g' -e 's/3/S/g' -e 's/4/T/g' -e 's/5/U/g' -e 's/6/V/g' -e 's/7/W/g' -e 's/8/X/g' -e 's/9/Y/g' -e 's/a/A/g' -e 's/b/B/g' -e 's/c/C/g' -e 's/d/D/g' -e 's/e/E/g' -e 's/f/F/g' | sed -e 's/P/2/g' -e 's/Q/3/g' -e 's/R/4/g' -e 's/S/5/g' -e 's/T/6/g' -e 's/U/7/g' -e 's/V/8/g' -e 's/W/9/g' -e 's/X/a/g' -e 's/Y/b/g' -e 's/A/c/g' -e 's/B/d/g' -e 's/C/e/g' -e 's/D/f/g' -e 's/E/g/g' -e 's/F/h/g')
echo ${wifipass}
gpio wlankey ${wifipass}
