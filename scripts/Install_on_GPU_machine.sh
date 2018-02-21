export DEBIAN_FRONTEND=noninteractive
sudo apt-get -y update
# sudo apt-get -y upgrade
sudo apt-get install -y wget make gcc libgfortran3 tmux htop git sysstat libibnetdisc-dev openmpi-bin libopenmpi-dev libhdf5-openmpi-dev bc automake m4



VERSION=2.4.2
wget -q https://github.com/singularityware/singularity/releases/download/$VERSION/singularity-$VERSION.tar.gz
tar xvf singularity-$VERSION.tar.gz
cd singularity-$VERSION
echo "libgomp.so" >> etc/nvliblist.conf
./configure --prefix=/usr/local
make -j
sudo make install
cd
sudo mkdir /home/username/mymountpoint
echo "${1}" > pass
echo "gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg==" > pass
sudo bash -c 'echo "//test1diag281.file.core.windows.net/shared-fs /home/username/mymountpoint cifs nofail,vers=3.0,username=test1diag281,password=`cat pass`,dir_mode=0777,file_mode=0777,serverino" >> /etc/fstab'
rm pass
sudo mount -a

