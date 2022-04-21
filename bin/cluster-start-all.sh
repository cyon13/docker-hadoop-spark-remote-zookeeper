#!/bin/bash

# Hadoop run
$HADOOP_HOME/sbin/start-all.sh
# JopHistory run
mapred --daemon start historyserver
# Spark run 
$SPARK_HOME/sbin/start-all.sh
