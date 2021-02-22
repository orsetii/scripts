pulseaudio -k
sleep 0.5
pulseaudio --start
sleep 1
bluetoothctl power off
bluetoothctl power on
bluetoothctl scan on & 
sleep 1 
bluetoothctl scan off 
bluetoothctl connect 4C:87:5D:6D:7E:05
