#! /bin/bash

# Script to create a new systemd service and enable it.
# Needs to point to a script location.

if [ $# -eq 0 ]
  then
    echo "Please supply a name, and a script location in the arguments."
    exit
fi

if [ $# -eq 1 ]
  then
    echo "Please supply a script location as the second argument."
    exit
fi

SCRIPT_LOC=$(readlink -f $2)

SERVICE_FILE_CONTENTS=$(cat <<EOF
[Unit]
Description=$1

[Service]
ExecStart=$SCRIPT_LOC

[Install]
WantedBy=multi-user.target
EOF
)
NEWSERVICELOCATION="/etc/systemd/system/$1.service"

sudo touch $NEWSERVICELOCATION
sudo chown $USER $NEWSERVICELOCATION
echo "$SERVICE_FILE_CONTENTS" > $NEWSERVICELOCATION
if [ $? -eq 0 ] 
then
	echo "Created New File in $NEWSERVICELOCATION"
else
	echo "Unable to create service file in $NEWSERVICELOCATION."
	echo "Exiting..."
	exit
fi

echo "Restarting systemctl daemon"
sudo systemctl daemon-reload
if [ $? -eq 0 ] 
then
	echo "Restarted systemctl daemon successfully"
else
	echo "Unable to restart systemctl daemon"
	echo "Exiting..."
	exit
fi

echo "Enabling the $1 service..."
sudo systemctl enable $1 --now
if [ $? -eq 0 ] 
then
	echo "Enabled service successfully!"
	echo "All done!"
else
	echo "Unable to enable service"
	echo "Exiting..."
	exit
fi
