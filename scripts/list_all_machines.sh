

cat << EOF > teste.sh
#!/bin/bash
for host in \`seq 4 $(echo ${NUMBER_INSTANCES}+3 | bc)\`; do
echo "host \${host}"; ssh "10.0.0.\${host}" ls
done
EOF

scp teste.sh ${SSH_ADDR}:

ssh ${SSH_ADDR} << EOF
for host in \`seq 4 $(echo ${NUMBER_INSTANCES}+3 | bc)\`; do
echo "hostinho \${host}"
scp teste.sh "10.0.0.\${host}:"
ssh "10.0.0.\${host}" bash teste.sh > result_\${host}.txt
scp "10.0.0.\${host}:result_\${host}.txt" .
done
EOF