# Configure apt for mongodb
# http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list

# Configure apt for java
# http://www.webupd8.org/2012/01/install-oracle-java-jdk-7-in-ubuntu-via.html
apt-get update
apt-get install -y python-software-properties
add-apt-repository -y ppa:webupd8team/java
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

# Update apt sources
apt-get update

# Install stuff available through apt-get
apt-get install -y unzip wget git vim mongodb-10gen oracle-java8-installer oracle-java8-set-default samba samba-common cifs-utils

# Install scala and play manually
cd /opt
wget http://www.scala-lang.org/files/archive/scala-2.11.7.tgz
tar -zxvf scala-2.11.7.tgz
wget http://downloads.typesafe.com/typesafe-activator/1.3.5/typesafe-activator-1.3.5-minimal.zip
unzip typesafe-activator-1.3.5-minimal.zip
chmod +x /opt/activator-1.3.5-minimal
chmod -R a+rw /opt/activator-1.3.5-minimal/*

echo 'PATH=${PATH}:/opt/scala-2.11.7/bin:/opt/activator-1.3.5-minimal' >> /etc/profile

# Set up Samba for sharing files to the host
cat > /etc/samba/smb.conf <<'endmsg'
[global]
map to guest = bad user
server string = scala
guest account = vagrant

[home]
path = /home/vagrant
public = Yes
browseable = Yes
writable = Yes
read only = No
guest ok = Yes
guest only = Yes
force user = vagrant
force group = vagrant
create mask = 0777
directory mask = 0777
endmsg

service smbd restart
