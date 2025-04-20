#!/usr/bin/env bash
#
# WARP+ Connection Manager
#
# Description: This script manages WARP+ VPN connections to bypass Iranian restrictions.
#              It automatically detects if the connection is routed through Iran and
#              re-establishes the VPN connection when needed. The script also configures
#              tun2proxy for SOCKS5 proxy setup and bypasses WARP endpoints.
#
# Author: aydin tabatabaei
#
# Logs:
#   - WARP output is logged to /var/log/warp_output.log
#
# Note: This script should be run with appropriate permissions, preferably as root.

endpoint_IP="188.114.97.47"
endpoint_PORT="894"

warp-plus --gool --endpoint $endpoint_IP:$endpoint_PORT >/var/log/warp_output.log &

echo "nameserver 1.1.1.1" >/etc/resolv.conf
echo "Waiting 5 seconds before initial check..."

while true; do
	response=$(curl -s --socks5 127.0.0.1:8086 --connect-timeout 10 ip-api.com)
	country=$(echo "$response" | awk '/countryCode/ {gsub(/[^A-Z]/,"",$3); print $3}')

	if [ -z "$country" ]; then
		echo "Debug: Country code extracted: '${country}'"
		sleep 5
		continue
	fi

	if [ "$country" = "IR" ]; then
		echo "Iran detected - taking action"
		kill -9 $(pidof /usr/bin/tun2proxy-bin) 2>/dev/null || true
		kill -9 $(pidof /usr/bin/warp-plus) 2>/dev/null || true
		sleep 2
		warp-plus --gool $endpoint_IP:$endpoint_PORT >/var/log/warp_output.log &
		sleep 5
	else
		echo "Country is ${country} - breaking loop"
		break
	fi

	sleep 5
done

ips=$(grep 'msg="using warp endpoints"' /var/log//warp_output.log | tail -1 | sed 's/.*endpoints="\[\([^]]*\)\].*/\1/')
ip1=$(echo "$ips" | cut -d' ' -f1 | cut -d: -f1)
ip2=$(echo "$ips" | cut -d' ' -f2 | cut -d: -f1)

tun2proxy-bin --setup --proxy socks5://127.0.0.1:8086 --bypass $endpoint_IP --bypass 192.168.0.0/16 --bypass 172.16.0.0/15 --bypass 10.0.0.0/8 &

exec nginx -g "daemon off;"
