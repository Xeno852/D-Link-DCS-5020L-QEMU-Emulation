#!/bin/sh

# only for use as a "zcip" callback script
if [ "x$interface" = x ]
then
	exit 1
fi

# zcip should start on boot/resume and various media changes
case "$1" in
init)
	# for now, zcip requires the link to be already up,
	# and it drops links when they go down.  that isn't
	# the most robust model...
	exit 0
	;;
config)
	if [ "x$ip" = x ]
	then
		exit 1
	fi
	# remember $ip for $interface, to use on restart
	if [ "x$IP" != x -a -w "$IP.$interface" ]
	then
		echo $ip > "$IP.$interface"
	fi
	#exec ip address add dev $interface \
	#	scope link local "$ip/16" broadcast +
  	
	ifconfig br0:1 down
	ifconfig br0:0 down
        gpio defaultip
        gpio apip
	
	ifconfig br0:1 $ip netmask 255.255.0.0	
        gpio autoip $ip
        killall -q mDNSResponder
        gpio mDNSResponder
        exit 0
	;;
deconfig)
	if [ x$ip = x ]
	then
		exit 1
	fi
	#exec ip address del dev $interface local $ip
	ifconfig br0:1 down	
        exit 0
	;;
esac
exit 1
