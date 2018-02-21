#!/bin/bash

    sudo apt-get update
    sudo apt-get upgrade -y
    sudo apt-get dist-upgrade -y
    sudo apt-get install build-essential ubuntu-desktop gcc make -y tmux zsh clinfo
    # sudo apt-get install build-essential gcc make -y

# Disable the Nouveau kernel driver, which is incompatible with the NVIDIA driver. (Only use the NVIDIA driver on NV VMs.) To do this, create a file in /etc/modprobe.d named nouveau.conf
# with the following contents:

    echo "blacklist nouveau" >> /etc/modprobe.d/nouveau.conf
    echo "blacklist lbm-nouveau" >> /etc/modprobe.d/nouveau.conf

#Reboot the VM and reconnect. Exit X server:

    sudo systemctl stop lightdm.service
    wget -O NVIDIA-Linux-x86_64-384.73-grid.run https://go.microsoft.com/fwlink/?linkid=849941
    chmod +x NVIDIA-Linux-x86_64-384.73-grid.run
    sudo ./NVIDIA-Linux-x86_64-384.73-grid.run --ui=none --no-questions --accept-license --disable-nouveau

# When you're asked whether you want to run the nvidia-xconfig utility to update your X configuration file, select Yes.

    sudo cp /etc/nvidia/gridd.conf.template /etc/nvidia/gridd.conf

#Add the following to /etc/nvidia/gridd.conf:
    sudo bash -c 'echo "IgnoreSP=TRUE" >> /etc/nvidia/gridd.conf'

#Cuda:

    CUDA_REPO_PKG=cuda-repo-ubuntu1604_9.0.176-1_amd64.deb
    wget -O /tmp/${CUDA_REPO_PKG} http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/${CUDA_REPO_PKG}
    sudo dpkg -i /tmp/${CUDA_REPO_PKG}
    sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub
    rm -f /tmp/${CUDA_REPO_PKG}
    sudo apt-get update
    sudo apt-get install -y cuda-drivers cuda

    bash -c 'echo "export PATH=/usr/local/cuda-9.1/bin${PATH:+:${PATH}}" >> .bashrc'
    bash -c 'echo "export LD_LIBRARY_PATH=/usr/local/cuda-9.1/lib64\${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}" >> .bashrc'

    sudo apt install -y ocl-icd-opencl-dev

#Reboot the VM and proceed to verify the installation.

#For updates:
#    sudo apt-get update
#    sudo apt-get upgrade -y
#    sudo apt-get dist-upgrade -y
#    sudo apt-get install cuda-drivers
#    sudo reboot