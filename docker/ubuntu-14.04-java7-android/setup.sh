apt-get update

apt-get -y install openjdk-7-jdk
apt-get -y install libnet-scp-perl unzip zip make gcc git-core
apt-get -y install lib32ncurses5 lib32stdc++6 lib32z-dev # for running 32 bits binary in 64 bits system
apt-get -y install gperf bc libxml2-utils bison

# Enable ssh connection
apt-get install -y openssh-server
mkdir /var/run/sshd
echo 'root:123456' | chpasswd
sed -i 's/^PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd
env NOTVISIBLE="in users profile"
echo -e "\nexport VISIBLE=now" >> /etc/profile

# better vi
sudo apt-get remove -y vim-common
sudo apt-get install -y vim
