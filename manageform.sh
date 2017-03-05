#!/bin/bash
# file <statefile>
# key_name
# username

if [ $# -eq 0 ]
	then
	echo "no"
	exit 1
fi
statefile=$1
terraform apply -var 'key_name=confman' -var 'stack_name='$statefile'' -var-file=./variables.tfvars -state=$statefile
manager=$(terraform output -state=$statefile | grep instance_ip | cut -f2 -d'=' | cut -f1 -d',')
manager_lan=$(terraform output -state=$statefile | grep instance_lan_ip | cut -f2 -d'=' | cut -f1 -d',')
others=$(terraform output -state=$statefile | grep instance_ip | cut -f2 -d',')
others_lan=$(terraform output -state=$statefile | grep instance_lan_ip | cut -f2 -d',')

echo "Manager: $manager"
echo "manager_lan: $manager_lan"
echo "Others: $others"
echo "others_lan: $others_lan"
sleep 150
cd ansible && \
ansible --private-key=confman.pem -i $manager, -u ubuntu all -m raw -a "sudo docker swarm init --advertise-addr $manager_lan | grep token"
swarm_token=$(ansible --private-key=confman.pem -i $manager, -u ubuntu all -m raw -a "sudo docker swarm join-token manager -q" | grep ^SWM) 
#ansible --private-key=confman.pem -i $manager, -u ubuntu all -m raw -a "sudo docker swarm join-token manager -q"
echo "Token: ${swarm_token}"

ansible --private-key=confman.pem -i $others, -u ubuntu all -m raw -a "sudo docker swarm join --token ${swarm_token} ${manager_lan}:2377"
