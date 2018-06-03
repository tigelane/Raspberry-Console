# Collect the IP Address info
myserver=192.168.55.147
addr=$( ifconfig eth0 | grep netmask | awk '{print $2}' )

# Post the IP Address to the internet to get later
sudo curl -X POST -F 'apikey=1Irs3L98V' -F "addrline=$addr" http://"$myserver"/addr >> setup.log
