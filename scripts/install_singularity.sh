#!/bin/bash
# tar -zxvf /home/username/mymountpoint/openmpi-3.0.0_compiled.tar.gz  -C /home/username &

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
sudo apt-get -y update
sudo apt-get install -y wget make gcc libgfortran3 tmux htop git sysstat libibnetdisc-dev openmpi-bin libopenmpi-dev libhdf5-openmpi-dev bc &>> ${LOGFILE} &
# sudo apt-get install -y wget make gcc libgfortran3 tmux htop git sysstat libibnetdisc-dev bc libnuma-dev libibverbs-dev gfortran &

# For mpich do: sudo apt-get install mpich libmpich-dev libhdf5-mpich-dev

# git clone https://github.com/jeferrb/AzureTemplates.git

# wget -q https://www.open-mpi.org/software/ompi/v3.0/downloads/openmpi-3.0.0.tar.gz
# tar -zxf openmpi-3.0.0.tar.gz
# cd openmpi-3.0.0
# ./configure --with-device=ch3:ssm --prefix="/home/$USER/.openmpi" # --enable-mpirun-prefix-by-default # 
# make -j && sudo make install
# cat <<EOT >> ~/.bashrc
# export PATH="$PATH:/home/$USER/.openmpi/bin"
# export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/home/$USER/.openmpi/lib/"
# EOT
# source ~/.bashrc


# wget http://www.mpich.org/static/downloads/3.2.1/mpich-3.2.1.tar.gz
# tar -zxf mpich-3.2.1.tar.gz
# cd mpich-3.2.1
# ./configure --prefix=/usr/local/mpich2-1.0 >& configure.log
# make -j >& make.log
# sudo make install >& install.log
# cat <<EOT >> ~/.bashrc
# export PATH="$PATH:/usr/local/mpich2-1.0"
# EOT
# source ~/.bashrc

if [[ $SWAP ]]; then
	#Create a swapfile
	sudo fallocate -l 4G /swapfile
	sudo mkswap /swapfile
	sudo swapon /swapfile
	sudo bash -c "echo '/swapfile swap swap defaults 0 0' >> /etc/fstab"
fi

# creade and setup the shared folder 
sudo mkdir /home/username/mymountpoint
echo "${1}" > pass
sudo bash -c 'echo "//test1diag281.file.core.windows.net/shared-fs /home/username/mymountpoint cifs nofail,vers=3.0,username=test1diag281,password=`cat pass`,dir_mode=0777,file_mode=0777,serverino" >> /etc/fstab'
rm pass
sudo mount -a

echo cp "/home/username/mymountpoint/ubuntu.img /home/username/" &>> ${LOGFILE}
cp /home/username/mymountpoint/ubuntu.img /home/username/  &>> ${LOGFILE} &

wait

echo cp "*************** Install Singularity" &>> ${LOGFILE}
# Install Singularity
VERSION=2.4.2
wget -q https://github.com/singularityware/singularity/releases/download/$VERSION/singularity-$VERSION.tar.gz
tar xvf singularity-$VERSION.tar.gz
cd singularity-$VERSION
echo "libgomp.so" >> etc/nvliblist.conf
./configure --prefix=/usr/local &>> ${LOGFILE}
make -j &>> ${LOGFILE}
sudo make install


# cd /home/username/
# tar -zxvf /home/username/mymountpoint/openmpi-3.0.0_compiled.tar.gz  -C /home/username
# cd /home/username/openmpi-3.0.0
# sudo make install &>> azure_install.log
# cat <<EOT >> /home/username/.bashrc
# export PATH="$PATH:/home/username/.openmpi/bin"
# export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/home/username/.openmpi/lib/"
# EOT
# source ~/.bashrc

echo "done" > donefile

# cp /home/username/mymountpoint/ubuntu.img /home/username/

# singularity pull shub://ruycastilho/GPUtest:1604

################
# for the host machine, install Azure CLI
if [[ 0 ]]; then
	# Install required dependencies
	sudo apt-get update && sudo apt-get install -y libssl-dev libffi-dev python-dev build-essential
	# Install the CLI with curl
	curl -L https://aka.ms/InstallAzureCli | bash
	# restart your shell
	exec -l $SHELL
	# clear your shell's command hash cache
	hash -r
fi




