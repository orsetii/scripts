#!/bin/bash
if [ $# -eq 0 ]
  then
    echo "Please enter a list of song names as \nthe argument to this script."
else
	while read line
	do
		ytmdl $line < <(echo "1") < <(echo "1")
	done < $1

fi
