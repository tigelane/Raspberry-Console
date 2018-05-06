# Raspberry-Console

To enable SSH you need a blank file, in the root directory of flash card:  
touch ssh


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
