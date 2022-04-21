#!/bin/bash


SERVER_HOST_NAME=$HOSTNAME
HADOOP_HOME=$HADOOP_HOME

# ssh 실행
service ssh start


nodes="nn1 nn2 dn1 dn2 dn3 zk1 zk2 zk3"
hadoop_nodes="nn1 nn2 dn1 dn2 dn3"

if [ $SERVER_HOST_NAME == nn1 ];
then
	for node in $nodes
	do	
		IPADDR=$(ssh -o  StrictHostKeyChecking=no $node "ifconfig  | grep broadcast| awk '{print \$ 2}'")
		NAME=$(ssh -o  StrictHostKeyChecking=no $node "echo \$HOSTNAME")
		HOST="$IPADDR		$NAME"
		if [[ -z `grep "$node" /etc/hosts` ]]
		then
			echo $HOST >> /etc/hosts
			echo $HOST
		fi
	done

	for node in $hadoop_nodes
	do	
		scp /etc/hosts $node:/etc/hosts
		scp ~/.ssh/known_hosts $node:~/.ssh/known_hosts
	done
fi

tail -f /dev/null
