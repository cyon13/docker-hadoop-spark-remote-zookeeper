#!/bin/bash

# Spark stop
$SPARK_HOME/sbin/stop-all.sh
# JopHistory stop
mapred --daemon stop historyserver
# Hadoop stop
$HADOOP_HOME/sbin/stop-all.sh

