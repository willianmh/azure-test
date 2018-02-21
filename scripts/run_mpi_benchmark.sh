#!/bin/bash

# the first paramiter is the admin password, the second one is the Mout disk password the tird one is the vmSize the forth is the GroupName

set -x
GROUP_NAME=mpi${3}
NUMBER_INSTANCES=3
BIN_PATH="/home/username/mymountpoint/NPB3.3-MPI/bin/"
NUMBER_REPETITIONS=5
NUMBER_RROCESSORS=2
declare -a VM_SIZES=('Standard_D2s_v3' 'Standard_NC6')
# VM_SIZE=${VM_SIZES[${3}]}
VM_SIZE=${VM_SIZES[0]}
RESULTS_DIRECTORY="results/${VM_SIZE}_result"

function pause(){
    # read -p "$*"
    echo "$*"
}

echo "------------------------------------------"  >> file.log.old
cat file.log >> file.log.old
date > file.log
echo "Creating group ${GROUP_NAME}"
az group create --name $GROUP_NAME --location "South Central US"

FILE=~/.ssh/id_rsa.pub
if [ ! -e "$FILE" ]; then
    # if there is not an rsa key, create it
    echo "File $FILE does not exist"
    ssh-keygen -f ~/.ssh/id_rsa -t rsa -N ''
fi

for (( i = 1; i < $NUMBER_INSTANCES + 1 ; i++ )); do
    echo "Creating the machine number $i"
    # az group deployment create --verbose --debug --name SingularityTest --resource-group $GROUP_NAME \
    az group deployment create --name "SingularityTest$(whoami)$(date +%s)" --resource-group $GROUP_NAME \
    --template-file azuredeploy.json --parameters vmSize="${VM_SIZE}" vmName="testMpi${i}" dnsLabelPrefix="my${GROUP_NAME}dnsprefix${i}" \
    adminPassword=$1 scriptParameterPassMount=$2 adminPublicKey="`cat ~/.ssh/id_rsa.pub`" >> file.log
    SSH_ADDR=`grep "ssh " file.log | tail -n 1 | cut -c 23- | rev | cut -c 2- | rev`
    HOST_ADDR=`echo $SSH_ADDR | cut -d '@' -f 2`
    # Add all credential do cop the host public key later
    ssh-keyscan -H ${HOST_ADDR} >> ~/.ssh/known_hosts
    # scp ${SSH_ADDR} ~/.ssh/id_rsa.pub id_rsa${i}.pub
done

# pause "Press [Enter] key to continue"


echo "******************************************"  >> file.log

# grep "ssh " file.log
SSH_ADDR=`grep "ssh " file.log | tail -n 1 | cut -c 23- | rev | cut -c 2- | rev`
# HOST_ADDR=`echo $SSH_ADDR | cut -d '@' -f 2`
# ssh-keyscan -H ${HOST_ADDR} >> ~/.ssh/known_hosts

# copy coordinator (master) credential to all slaves
ssh ${SSH_ADDR} << EOF
    ssh-keygen -f ~/.ssh/id_rsa -t rsa -N ''
EOF
scp ${SSH_ADDR}:~/.ssh/id_rsa.pub id_rsa_coodinator.pub
grep "ssh " file.log | xargs -L1 echo | cut -c 12- | xargs -L1 ssh-copy-id -f -i id_rsa_coodinator.pub

# pause "Press [Enter] key to execute"


# SUBNET_HOSTS=`seq 3 $(echo ${NUMBER_INSTANCES}+3 | bc) | tr '\n'  " "  | sed 's/ /n10.0.0./g' | cut -c 3- | rev | cut -c 9-| rev`
# echo "${SUBNET_HOSTS}" > hostfile

### OSX Only
# seq 3 $(echo ${NUMBER_INSTANCES}+3 | bc) | tr '\n'  " "  | sed 's/ /\n10.0.0./g' | cut -c 3- | rev | cut -c 8-| rev | sed "s/n/ slots=${NUMBER_RROCESSORS}n/g" | tr 'n' '\n' > hostfile

rm hostfile
for host in `seq 4 $(echo ${NUMBER_INSTANCES}+3 | bc)`; do
    echo "10.0.0.${host} slots=${NUMBER_RROCESSORS}" >> hostfile
done

scp scripts/run_bench.sh hostfile ${SSH_ADDR}:
# rm hostfile
ssh ${SSH_ADDR} << EOF
    set -x
    for host in \`seq 4 $(echo ${NUMBER_INSTANCES}+3 | bc)\`; do
        ssh-keyscan -H "10.0.0.\${host}" >> ~/.ssh/known_hosts
    done
    chmod +x run_bench.sh
    ./run_bench.sh "${NUMBER_REPETITIONS} ${BIN_PATH}"
EOF
mkdir -p ${RESULTS_DIRECTORY}
scp "${SSH_ADDR}:/home/username/*.log" ${RESULTS_DIRECTORY}
scp "${SSH_ADDR}:/home/username/*.sa" ${RESULTS_DIRECTORY}

echo "To tedelete the resource type:"
echo "az group delete --resource-group ${GROUP_NAME} --yes --no-wait"
# pause "Press [Enter] key to delete the group ${GROUP_NAME}"
# az group delete --resource-group ${GROUP_NAME} --yes --no-wait

FILE=~/*mountpoint/
if [ -e "$FILE" ]; then
    cp -r results "$FILE/results_$(whoami)$(date +%s)"
fi

###########
if [[ $50 ]]; then
    echo "DONE!!"
    #statements
    # mpirun -np 20 singularity exec ./mpi_sample  mymountpoint/ubuntu.img
    # mpirun -np 5 -host 10.0.0.5, 10.0.0.4 ./mpi_sample

    # --template-uri "https://raw.githubusercontent.com/jeferrb/AzureTemplates/master/azuredeploy.json" \

    # ssh -o StrictHostKeyChecking=no username@hostname.com
    # ssh -o StrictHostKeyChecking=no -o LogLevel=ERROR -o UserKnownHostsFile=/dev/null username@hostname.com

    # ssh-keygen -R [hostname]
    # ssh-keygen -R [ip_address]
    # ssh-keygen -R [hostname],[ip_address]
    # ssh-keyscan -H [hostname],[ip_address] >> ~/.ssh/known_hosts
    # ssh-keyscan -H [ip_address] >> ~/.ssh/known_hosts
    # ssh-keyscan -H [hostname] >> ~/.ssh/known_hosts

        # mpirun -np ${NUMBER_INSTANCES} -host ${SUBNET_HOSTS} ./mymountpoint/NPB3.3-MPI/bin/sp.S.16 >> remote.log


# echo "=========================================="  >> results.log
# -------> cat remote.log >> results.log
# echo "=========================================="  >> results.log
fi

