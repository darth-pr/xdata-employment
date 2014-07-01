#! /bin/bash
##### Java installation #####
echo "[vagrant provisioning] Installing Java..."]
apt-get update
apt-get -y install curl
apt-get -y install python-software-properties # adds add-apt-repository
add-apt-repository -y ppa:webupd8team/java
apt-get update

# automatic install of the Oracle JDK 7
echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections

apt-get -y install oracle-java7-set-default

export JAVA_HOME="/usr/lib/jvm/java-7-oracle/jre"

echo "export JAVA_HOME=\$(readlink -f /usr/bin/java | sed \"s:bin/java::\")" >> /home/vagrant/.bashrc

##### Simple necessities #####
echo "[vagrant provisioning] Installing simple necessities..."
apt-get install -y vim
apt-get install -y git
apt-get install -y maven
apt-get install -y pip

##### Tika-python installation #####
echo "[vagrant provisioning] Installing and building tika-python..."]
pip install jcc #prereq of tika-python
cd /home/vagrant
git clone https://github.com/chrismattmann/tika-python.git
chown -R vagrant tika-python
chgrp -R vagrant tika-python
cd tika-python
python setup.py build
python setup.py install

##### Tika-python installation #####
echo "[vagrant provisioning] Installing and building tika python..."]
cd /home/vagrant
git clone https://github.com/chrismattmann/etllib.git
chown -R vagrant etllib
chgrp -R vagrant etllib
cd etllib
python setup.py build
python setup.py install

##### XDATA employment installation #####
cd /vagrant
mvn clean package
mkdir /usr/local/xdata-deployment
tar xzvf distribution/target/xdata-employment-distribution-*-bin.tar.gz -C /usr/local/xdata-deployment
cd /usr/local
chown -R vagrant xdata-deployment
chgrp -R vagrant xdata-deployment
export XDATA_EMPLOYMENT_HOME=/usr/local/xdata-deployment
echo "export XDATA_EMPLOYMENT_HOME=/usr/local/xdata-deployment" >> /home/vagrant/.bashrc

