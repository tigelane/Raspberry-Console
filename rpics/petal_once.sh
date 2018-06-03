# Collect the IP Address info
myserver=192.168.55.147
addr=$( ifconfig eth0 | grep netmask | awk '{print $2}' )

# Post the IP Address to the internet to get later
sudo curl -X POST -F 'apikey=1Irs3L98V' -F "addrline=$addr" http://"$myserver"/addr >> setup.log

# Prerequsits for ser2net
apt-get install libtool
apt-get install autoconf

# Move and Unpack ser2net from the /boot folder
cp /boot/rpics/ser2net-3.5.tar.gz /tmp
tar -xvf /tmp/ser2net-3.5.tar.gz
cd /tmp/ser2net

# Build and install ser2net
autoreconf -i
./configure
make
make install
make clean

# Create a log folder - might not be used yet
mkdir /var/log/ser2net

# Modify the system so it runs ser2net ever time, and always posts it's IP address to the internet
cp /boot/rpics/rc.local /etc/rc.local
cp /boot/rpics/ser2net.conf /etc/ser2net.conf

# Touch a file so we know this script ran
touch /boot/rpics/ser2net.installed
