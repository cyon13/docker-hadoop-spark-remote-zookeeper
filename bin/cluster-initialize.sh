#!/bin/bash


# data delete
rm -rf $HADOOP_HOME/data/*/*
ssh nn2 "rm -rf $HADOOP_HOME/data/*/*"
ssh dn1 "rm -rf $HADOOP_HOME/data/*/*"
ssh dn2 "rm -rf $HADOOP_HOME/data/*/*"
ssh dn3 "rm -rf $HADOOP_HOME/data/*/*"



# zkfc format
$HADOOP_HOME/bin/hdfs zkfc -formatZK 


# journalnode start
$HADOOP_HOME/bin/hdfs --daemon start journalnode
ssh nn2 "$HADOOP_HOME/bin/hdfs --daemon start journalnode"
ssh dn1 "$HADOOP_HOME/bin/hdfs --daemon start journalnode"

# namenode format
$HADOOP_HOME/bin/hdfs namenode -format

# journalnode format
$HADOOP_HOME/bin/hdfs namenode -initialSharedEdits -force


$HADOOP_HOME/bin/hdfs --daemon start namenode 
ssh nn2 "$HADOOP_HOME/bin/hdfs namenode -bootstrapStandby -force"


#ssh dn1 "$HADOOP_HOME/bin/hdfs datanode -format"
#ssh dn2 "$HADOOP_HOME/bin/hdfs datanode -format"
#ssh dn3 "$HADOOP_HOME/bin/hdfs datanode -format"

# Hadoop run

$HADOOP_HOME/sbin/start-all.sh
# JopHistory run
mapred --daemon start historyserver

#HBASE run
$HBASE_HOME/bin/start-hbase.sh

# Spark run 
$SPARK_HOME/sbin/start-all.sh


# Zeppelin run
$ZEPPELIN_HOME/bin/zeppelin-daemon.sh start

