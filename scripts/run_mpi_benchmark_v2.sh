#!/bin/bash

# the first paramiter is the admin password, the second one is the Mout disk password the tird one is the vmSize the forth is the number of instances

set -x
GROUP_NAME=mpi${RANDOM}
NUMBER_INSTANCES=${4}
BIN_PATH="/home/username/mymountpoint/NPB3.3-MPI/bin/"
NUMBER_REPETITIONS=5
declare -a VM_SIZES=("Basic_A0" "Basic_A1" "Basic_A2" "Basic_A3" "Basic_A4" "Standard_A0" "Standard_A1" "Standard_A1_v2" "Standard_A10" "Standard_A11" "Standard_A2" "Standard_A2_v2" "Standard_A2m_v2" "Standard_A3" "Standard_A4" "Standard_A4_v2" "Standard_A4m_v2" "Standard_A5" "Standard_A6" "Standard_A7" "Standard_A8" "Standard_A8_v2" "Standard_A8m_v2" "Standard_A9" "Standard_B1ms" "Standard_B1s" "Standard_B2ms" "Standard_B2s" "Standard_B4ms" "Standard_B8ms" "Standard_D1" "Standard_D1_v2" "Standard_D11" "Standard_D11_v2" "Standard_D11_v2_Promo" "Standard_D12" "Standard_D12_v2" "Standard_D12_v2_Promo" "Standard_D13" "Standard_D13_v2" "Standard_D13_v2_Promo" "Standard_D14" "Standard_D14_v2" "Standard_D14_v2_Promo" "Standard_D15_v2" "Standard_D16_v3" "Standard_D16s_v3" "Standard_D2" "Standard_D2_v2" "Standard_D2_v2_Promo" "Standard_D2_v3" "Standard_D2s_v3" "Standard_D3" "Standard_D3_v2" "Standard_D3_v2_Promo" "Standard_D32_v3" "Standard_D32s_v3" "Standard_D4" "Standard_D4_v2" "Standard_D4_v2_Promo" "Standard_D4_v3" "Standard_D4s_v3" "Standard_D5_v2" "Standard_D5_v2_Promo" "Standard_D64_v3" "Standard_D64s_v3" "Standard_D8_v3" "Standard_D8s_v3" "Standard_DS1" "Standard_DS1_v2" "Standard_DS11" "Standard_DS11_v2" "Standard_DS11_v2_Promo" "Standard_DS12" "Standard_DS12_v2" "Standard_DS12_v2_Promo" "Standard_DS13" "Standard_DS13_v2" "Standard_DS13_v2_Promo" "Standard_DS13-2_v2" "Standard_DS13-4_v2" "Standard_DS14" "Standard_DS14_v2" "Standard_DS14_v2_Promo" "Standard_DS14-4_v2" "Standard_DS14-8_v2" "Standard_DS15_v2" "Standard_DS2" "Standard_DS2_v2" "Standard_DS2_v2_Promo" "Standard_DS3" "Standard_DS3_v2" "Standard_DS3_v2_Promo" "Standard_DS4" "Standard_DS4_v2" "Standard_DS4_v2_Promo" "Standard_DS5_v2" "Standard_DS5_v2_Promo" "Standard_E16_v3" "Standard_E16s_v3" "Standard_E2_v3" "Standard_E2s_v3" "Standard_E32_v3" "Standard_E32-16s_v3" "Standard_E32-8s_v3" "Standard_E32s_v3" "Standard_E4_v3" "Standard_E4s_v3" "Standard_E64_v3" "Standard_E64-16s_v3" "Standard_E64-32s_v3" "Standard_E64s_v3" "Standard_E8_v3" "Standard_E8s_v3" "Standard_F1" "Standard_F16" "Standard_F16s" "Standard_F1s" "Standard_F2" "Standard_F2s" "Standard_F4" "Standard_F4s" "Standard_F8" "Standard_F8s" "Standard_H16" "Standard_H16m" "Standard_H16mr" "Standard_H16r" "Standard_H8" "Standard_H8m" "Standard_NC12" "Standard_NC12s_v2" "Standard_NC24" "Standard_NC24r" "Standard_NC24rs_v2" "Standard_NC24s_v2" "Standard_NC6" "Standard_NC6s_v2" "Standard_NV12" "Standard_NV24" "Standard_NV6")
declare -a VM_CORES=("1" "1" "2" "4" "8" "1" "1" "1" "8" "16" "2" "2" "2" "4" "8" "4" "4" "2" "4" "8" "8" "8" "8" "16" "1" "1" "2" "2" "4" "8" "1" "1" "2" "2" "2" "4" "4" "4" "8" "8" "8" "16" "16" "16" "20" "16" "16" "2" "2" "2" "2" "2" "4" "4" "4" "32" "32" "8" "8" "8" "4" "4" "16" "16" "64" "64" "8" "8" "1" "1" "2" "2" "2" "4" "4" "4" "8" "8" "8" "8" "8" "16" "16" "16" "16" "16" "20" "2" "2" "2" "4" "4" "4" "8" "8" "8" "16" "16" "16" "16" "2" "2" "32" "32" "32" "32" "4" "4" "64" "64" "64" "64" "8" "8" "1" "16" "16" "1" "2" "2" "4" "4" "8" "8" "16" "16" "16" "16" "8" "8" "12" "12" "24" "24" "24" "24" "6" "6" "12" "24" "6")
VM_SIZE=${VM_SIZES[${3}]}
NUMBER_RROCESSORS=${VM_CORES[${3}]}
# VM_SIZE=${VM_SIZES[0]}
RESULTS_DIRECTORY="results/${VM_SIZE}_instances_${NUMBER_INSTANCES}_result"
LOG_FILE=logfile_${VM_SIZE}_${NUMBER_INSTANCES}_${GROUP_NAME}.log

function pause(){
    read -p "$*"
    # echo "$*"
}

echo "------------------------------------------"  >> ${LOG_FILE}.old
cat ${LOG_FILE} >> ${LOG_FILE}.old
date > ${LOG_FILE}
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
    # --template-uri "https://raw.githubusercontent.com/jeferrb/AzureTemplates/master/azuredeploy.json" \
    az group deployment create --name "SingularityTest$(whoami)$(date +%s)" --resource-group $GROUP_NAME \
    --template-file azuredeploy_multiple_from_image.json --parameters vmSize="${VM_SIZE}" vmName="testMpi${i}" dnsLabelPrefix="my${GROUP_NAME}dnsprefix${i}" \
    adminPassword=$1 scriptParameterPassMount=$2 adminPublicKey="`cat ~/.ssh/id_rsa.pub`" >> ${LOG_FILE}
    if [ ! $? -eq 0 ]; then
        echo "Faile to create some VM instace, reverting changes"
        az group delete --resource-group ${GROUP_NAME} --yes --no-wait
    fi
    SSH_ADDR=`grep "ssh " ${LOG_FILE} | tail -n 1 | cut -c 23- | rev | cut -c 2- | rev`
    # if [[ -z "${SSH_ADDR}" ]]; then
    #     echo "Faile to create a VM instace, reverting changes"
    #     az group delete --resource-group ${GROUP_NAME} --yes --no-wait
    # fi
    HOST_ADDR=`echo $SSH_ADDR | cut -d '@' -f 2`
    # Add all credential do cop the host public key later
    ssh-keygen -R ${HOST_ADDR}
    ssh-keyscan -H ${HOST_ADDR} >> ~/.ssh/known_hosts
    # scp ${SSH_ADDR} ~/.ssh/id_rsa.pub id_rsa${i}.pub
done


echo "******************************************"  >> ${LOG_FILE}

# grep "ssh " ${LOG_FILE}
SSH_ADDR=`grep "ssh " ${LOG_FILE} | tail -n 1 | cut -c 23- | rev | cut -c 2- | rev`
# HOST_ADDR=`echo $SSH_ADDR | cut -d '@' -f 2`
# ssh-keyscan -H ${HOST_ADDR} >> ~/.ssh/known_hosts

# copy coordinator (master) credential to all slaves
ssh ${SSH_ADDR} << EOF
    ssh-keygen -f ~/.ssh/id_rsa -t rsa -N ''
EOF
scp ${SSH_ADDR}:~/.ssh/id_rsa.pub id_rsa_coodinator_${GROUP_NAME}.pub
grep "ssh " ${LOG_FILE} | xargs -L1 echo | cut -c 12- | xargs -L1 ssh-copy-id -f -i id_rsa_coodinator_${GROUP_NAME}.pub
rm id_rsa_coodinator_${GROUP_NAME}.pub
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
        ssh-keygen -R "10.0.0.\${host}"
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
az group delete --resource-group ${GROUP_NAME} --yes --no-wait

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

