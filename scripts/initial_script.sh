#!/bin/bash

LOGFILE="/home/username/instalation.log"

#check network conction
ATTEMPTS=0
while [ $(nc -zw1 google.com 443) ] && [ "$ATTEMPTS" -lt 5 ]; do
  echo "we have NO connectivity" &>> ${LOGFILE}
  sleep 15
  ATTEMPTS=$((ATTEMPTS+1))
done

#Install MPI and dependencies
export DEBIAN_FRONTEND=noninteractive

touch hey.txt

sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install g++

sudo mkdir /home/username/mymountpoint
echo "${1}" > pass
sudo bash -c 'echo "//machinetesti.file.core.windows.net/doc /home/username/mymountpoint cifs nofail,vers=3.0,username=machinetesti,password=`cat pass`,dir_mode=0777,file_mode=0777,serverino" >> /etc/fstab'
rm pass
sudo mount -a

# sudo mount -t cifs //machinetesti.file.core.windows.net/doc /home/username/mymountpoint -o vers=3.0,username=machinetesti,password=pDyMoTChRGvm1/Pp0sz4USreLsttxoDa2xLKp/JXYWzppPUquesDLD7jerlLqdxSYGOGsLqRe8uYTLwtBW+AhQ==,dir_mode=0777,file_mode=0777,sec=ntlmssp

sudo touch /home/username/mymountpoint/ola.txt

echo "config done"
