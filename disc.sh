#!/usr/bin/env sh

while :
do
	if [[ ($(date +%H) -gt 10) && ($(date +%H) -lt 17)]]; then
		# In restricted time-area.
		# Closing Discord
		notify-send "Discord Check"
		ps aux | grep discord | grep -qv grep 
		if [ "$?" -eq 0 ]; then
			echo "Killing Discord"
			killall DiscordCanary || killall Discord
		fi
	fi
	sleep 5
done
