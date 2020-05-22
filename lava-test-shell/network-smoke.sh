#!/bin/sh

NET_IFACE="eth0"

report() {
	success=0
	if [ `which lava-test-case` ]; then
		if [ "$2" = $success ]; then
			result="lava-test-case $1 --result pass"
		else
			result="lava-test-case $1 --result fail"
		fi
		if [ -n "$3" ]; then
			result="$result --measurement $3 --units $4"
		fi
		eval $result
	else
		if [ "$2" = $success ]; then
			result="====> $1 - pass"
		else
			result="====> $1 - fail"
		fi
		if [ -n "$3" ]; then
			result="$result ($3 $4)"
		fi
		echo $result
	fi
}

ifconfig $NET_IFACE
report net-interface $?

ping -c 1 8.8.8.8
success=$?
lat=`ping -c 1 8.8.8.8 | awk -F '/' 'END {print $5}'`
report ping $success 0$lat "millisecond"

ping -c 1 google.com
report dns $?
