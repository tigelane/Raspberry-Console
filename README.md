# Raspberry-Console
## PI Info
* ssh pi@192.168.55.184
* docker build -t tigelane/petal .
* docker run -p 80:80 tigelane/petal &


## Boot Disk Build
* diskutil list
* diskutil unmountDisk /dev/disk3
* sudo dd if=/dev/zero of=/dev/rdisk3 bs=1024 count=1
* sudo dd if=2018-04-18-raspbian-stretch-lite.img of=/dev/rdisk3 bs=4m

## Before first boot
To enable SSH you need a blank file, in the root directory of flash card:  
touch ssh

## Get the IP Address

* addr=$( ifconfig eth0 | grep netmask | awk '{print $2}' )
* sudo curl -X POST -F 'apikey=1Irs3L98V' -F "addrline=$addr" http://192.168.55.147/addr >> setup.log

## Add config file for Ser2Net
/etc/ser2net.conf

BANNER:banner:Serial_Console_1

4001:telnet:0:/dev/ttyUSB0:9600 8DATABITS NONE 1STOPBIT

4002:telnet:0:/dev/ttyUSB1:9600 8DATABITS NONE 1STOPBIT

4003:telnet:0:/dev/ttyUSB2:9600 8DATABITS NONE 1STOPBIT

4004:telnet:0:/dev/ttyUSB3:9600 8DATABITS NONE 1STOPBIT

## Install Serial Driver
### https://www.packet6.com/configuring-your-raspberry-pi-as-a-console-server/

sudo apt-get install git
sudo apt-get install libtool
sudo apt-get install autoconf

git clone https://github.com/cminyard/ser2net.git
cd ser2net
autoreconf -i
./configure
make
sudo make install
make clean
sudo mkdir /var/log/ser2net

sudo vi /etc/rc.local
Add:  /usr/local/sbin/ser2net -n -c /etc/ser2net.conf
Before the last exit line.

sudo reboot

## Setup firewall - iptables
rpi-update
apt-get dist-upgrade
apt-get update
apt-get install iptables-persistent
vi /etc/iptables/rules.v4

Validate it's working.  This will reject ping with not reachable.
-A INPUT -p icmp -m icmp –icmp-type 8 -j REJECT
