#!/bin/bash

# Spark stop
$SPARK_HOME/sbin/stop-all.sh
# JopHistory stop
mapred --daemon stop historyserver
# Hadoop stop
$HADOOP_HOME/sbin/stop-all.sh


# Hadoop run
$HADOOP_HOME/sbin/start-all.sh
# JopHistory run
mapred --daemon start historyserver
# Spark run
$SPARK_HOME/sbin/start-all.sh
