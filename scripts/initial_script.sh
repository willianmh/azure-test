#!/bin/bash

sudo apt update
sudo apt upgrade
sudo apt install g++
sudo apt-get install -y wget make gcc libgfortran3 tmux htop git sysstat libibnetdisc-dev openmpi-bin libopenmpi-dev libhdf5-openmpi-dev bc


sudo mkdir /home/username/mymountpoint
echo "${1}" > pass
sudo bash -c 'echo "//machinetesti.file.core.windows.net/doc /home/username/pasta cifs nofail,vers=3.0,username=test1diag281,password=`cat pass`,dir_mode=0777,file_mode=0777,serverino" >> /etc/fstab'
rm pass
sudo mount -a

echo "config done"
