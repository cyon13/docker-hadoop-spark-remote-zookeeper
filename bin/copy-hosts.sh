#!/bin/bash

nodes="nn2 dn1 dn2 dn3"

for node in $nodes
do	
	IPADDR=$(ssh -o  StrictHostKeyChecking=no $node "ifconfig  | grep broadcast| awk '{print \$ 2}'")
	NAME=$(ssh -o  StrictHostKeyChecking=no $node "echo \$HOSTNAME")
	HOST="$IPADDR	$NAME"
	echo $HOST >> /etc/hosts
	scp /etc/hosts $node:/etc/hosts
	echo $HOST
done
