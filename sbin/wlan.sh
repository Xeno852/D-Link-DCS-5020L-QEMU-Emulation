#!/bin/sh
#
# $Id: wlan.sh, v1.00 2012-11-05 andy
#
# usage: wlan.sh 
#

echo "**** wlan.sh ***"

ap_up=`gpio apup`
wlan_disable=`nvram_get 2860 WirelessDisable`
if [ "$ap_up" = "1" ]; then
if [ "$wlan_disable" = "1" ]; then
echo "***** apclient disable *****"
gpio apclient 0
else
echo "***** apclient enable *****"
gpio apclient 1
sleep 10
dhcp.sh 
fi
exit 0
fi


wlan_init.sh

lan_link=`gpio lanlink`
if [ "$lan_link" = "1" ]; then
exit 0
fi

sleep 2
gpio ping
sleep 2

# mydlink
#/mydlink/opt.local stop
#/mydlink/opt.local start
date
echo "*** wlan.sh -> mydlink ***"
gpio mydlink


