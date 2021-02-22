#!/bin/bash

# This script enables the VPN functionality of aos.

# Should be run as a systemd service.

# Connects to VPN, then checks the ip is a VPN one.
get_ip() {
	curl -qs ipconfig.io/ip
}

log() {
	echo "$(date +%H:%M) $1"
}

log "beginning VPN script"

OLD_IP=$(get_ip)

log "old ip found: $OLD_IP"





while true; do

	NEW_IP=$(get_ip)
	log "Checking IP $NEW_IP"
	if [[ $NEW_IP == $OLD_IP ]]; then
		# if we are on the home IP

		log "showing public ip $OLD_IP"
		RES=$(curl https://am.i.mullvad.net/json | jq .mullvad_exit_ip)
		if [[ $RES == "true" ]]; then
			log "connected to vpn, sleeping 1 min"
			sleep 60
			notify-send
		else
			notify-send "NOT CONNECTED TO VPN. PUBLIC IP SHOWING"
			log "connecting to wireguard: wg1"
			wg-quick up wg1
			# sleep to allow configuration to finish...
			sleep 2
		fi
	fi

done


