FROM ubuntu:20.04

#자바 등 기타 프로그램 설치
RUN apt-get clean && apt-get -y update && apt-get install -y \
    vim \
    wget \
    unzip \
    ssh openssh-* \
    net-tools \
    openjdk-8-jdk

#ssh 키 생성
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
    chmod 0600 ~/.ssh/authorized_keys

# 하둡 설치
RUN wget https://downloads.apache.org/hadoop/common/hadoop-3.3.1/hadoop-3.3.1.tar.gz && \
    tar -xzf hadoop-3.3.1.tar.gz && \
    mv hadoop-3.3.1 /usr/local/hadoop && \
    rm hadoop-3.3.1.tar.gz

# 스쿱 설치
RUN wget http://archive.apache.org/dist/sqoop/1.4.7/sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz && \
    tar -xvf sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz && \
    mv sqoop-1.4.7.bin__hadoop-2.6.0 /usr/local/sqoop && \
    rm sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz


# HIVE 설치
RUN wget https://downloads.apache.org/hive/hive-3.1.2/apache-hive-3.1.2-bin.tar.gz && \
    tar -xvf apache-hive-3.1.2-bin.tar.gz && \
    mv apache-hive-3.1.2-bin /usr/local/hive&& \
    rm apache-hive-3.1.2-bin.tar.gz

# spark 설치
RUN wget https://dlcdn.apache.org/spark/spark-3.2.1/spark-3.2.1-bin-hadoop3.2.tgz && \
    tar -xzf spark-3.2.1-bin-hadoop3.2.tgz && \
    mv spark-3.2.1-bin-hadoop3.2 /usr/local/spark && \
    rm spark-3.2.1-bin-hadoop3.2.tgz

# python 설치
RUN apt-get install -y python3-pip

# PySpark, findspark 설치
RUN pip3 install pyspark findspark


# Zeppelin 설치
RUN wget https://dlcdn.apache.org/zeppelin/zeppelin-0.10.1/zeppelin-0.10.1-bin-all.tgz && \
    tar -xvf zeppelin-0.10.1-bin-all.tgz && \
    mv zeppelin-0.10.1-bin-all /usr/local/zeppelin && \
    rm zeppelin-0.10.1-bin-all.tgz

# 환경변수 설정
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 \
    HADOOP_HOME=/usr/local/hadoop \
    SQOOP_HOME=/usr/local/sqoop \
    HIVE_HOME=/usr/local/hive \
    SPARK_HOME=/usr/local/spark \
    ZEPPELIN_HOME=/usr/local/zeppelin
ENV HADOOP_COMMON_HOME=$HADOOP_HOME \
    HADOOP_HDFS_HOME=$HADOOP_HOME \
    HADOOP_MAPRED_HOME=$HADOOP_HOME \
    HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop \
    HADOOP_YARN_HOME=$HADOOP_HOME \
    HADOOP_YARN_CONF_DIR=$HADOOP_HOME/etc/hadoop \
    SQOOP_CONF_DIR=$SQOOP_HOME/conf \
    HIVE_CONF_DIR=$HIVE_HOME/conf \
    JAVA_HOME=$JAVA_HOME \
    PATH=$PATH:$JAVA_HOME/bin:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$SQOOP_HOME/bin:$HIVE_HOME/bin:$SPARK_HOME/bin:$SPARK_HOME/sbin:/usr/bin/python3:/usr/local:$ZEPPELIN_HOME/bin \
    PYTHONPATH=/usr/bin/python3 \
    PYSPARK_PYTHON=/usr/bin/python3 \
    SPARK_CONF_DIR=$SPARK_HOME/conf \
    ZEPPELIN_CONF_DIR=$ZEPPELIN_HOME/conf \
    HDFS_NN1_NAME=nn1 \
    HDFS_NN2_NAME=nn2 \
    HDFS_DN1_NAME=dn1 \
    HDFS_DN2_NAME=dn2 \
    HDFS_DN3_NAME=dn3 \
    HIVE_META_CONNECTION_URL=jdbc:oracle:thin:@172.17.0.3:1521:xe \
    HIVE_META_DB_TYPE=ORACLE \
    HIVE_META_CONNECTION_DRIVERNAME=oracle.jdbc.OracleDriver \
    HIVE_META_CONNECTION_USERNAME=hive \
    HIVE_META_CONNECTION_PASSWORD=11111 

RUN echo 'export HADOOP_HOME=/usr/local/hadoop' >> ~/.bashrc && \
    echo 'export HADOOP_COMMON_HOME=$HADOOP_HOME' >> ~/.bashrc && \
    echo 'export HADOOP_HDFS_HOME=$HADOOP_HOME' >> ~/.bashrc && \
    echo 'export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop' >> ~/.bashrc && \
    echo 'export YARN_CONF_DIR=$HADOOP_HOME/etc/hadoop' >> ~/.bashrc && \
    echo 'export HADOOP_YARN_HOME=$HADOOP_HOME' >> ~/.bashrc && \
    echo 'export HADOOP_MAPRED_HOME=$HADOOP_HOME' >> ~/.bashrc && \
    echo 'export SQOOP_HOME=/usr/local/sqoop' >> ~/.bashrc && \
    echo 'export SQOOP_CONF_DIR=$SQOOP_HOME/conf' >> ~/.bashrc && \
    echo 'export HIVE_HOME=/usr/local/hive' >> ~/.bashrc && \
    echo 'export HIVE_CONF_DIR=$HIVE_HOME/conf' >> ~/.bashrc && \
    echo 'export HADOOP_CLASSPATH=$HADOOP_CLASSPATH:$HIVE_HOME/lib/*' >> ~/.bashrc && \
    echo 'export HIVE_META_CONNECTION_URL=${HIVE_META_CONNECTION_URL}' >> ~/.bashrc && \
    echo 'export HIVE_META_DB_TYPE=${HIVE_META_DB_TYPE}' >> ~/.bashrc && \
    echo 'export HIVE_META_CONNECTION_DRIVERNAME=${HIVE_META_CONNECTION_DRIVERNAME}' >> ~/.bashrc && \
    echo 'export HIVE_META_CONNECTION_USERNAME=${HIVE_META_CONNECTION_USERNAME}' >> ~/.bashrc && \
    echo 'export HIVE_META_CONNECTION_PASSWORD=${HIVE_META_CONNECTION_PASSWORD}' >> ~/.bashrc && \
    echo 'export SPARK_HOME=/usr/local/spark' >> ~/.bashrc && \
    echo 'export SPARK_CONF_DIR=$SPARK_HOME/conf' >> ~/.bashrc && \
    echo 'export PATH=$PATH:$JAVA_HOME/bin:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$SQOOP_HOME/bin:$HIVE_HOME/bin:$SPARK_HOME/bin:$SPARK_HOME/sbin:/usr/bin/python3:/usr/local' >> ~/.bashrc && \
	echo 'export PYTHONPATH=/usr/bin/python3' >> ~/.bashrc && \
    echo 'export PYSPARK_PYTHON=/usr/bin/python3' >> ~/.bashrc && \
    echo 'export ZEPPELIN_HOME=/usr/local/zeppelin' >> ~/.bashrc && \
    echo 'export ZEPPELIN_CONF_DIR=$ZEPPELIN_HOME/conf' >> ~/.bashrc

# 설정파일 복사(hdfs,sqoop,hive)
COPY config/hdfs/*.xml ${HADOOP_CONF_DIR}/
COPY config/hdfs/hadoop-env.sh ${HADOOP_CONF_DIR}/hadoop-env.sh
COPY config/sqoop/* $SQOOP_HOME/conf/
COPY config/hive/* $HIVE_HOME/conf/

# 설정파일 복사(spark)
COPY config/spark/* ${SPARK_CONF_DIR}/
RUN mkdir -p /usr/loca/spark/logs && chown -R $USER:$USER /usr/local/spark/ && \
    echo "\n${HDFS_DN1_NAME}\n${HDFS_DN2_NAME}\n${HDFS_DN3_NAME}" >> /${SPARK_CONF_DIR}/workers


# 설정파일 복사(zeppelin)
COPY config/zeppelin/* ${ZEPPELIN_CONF_DIR}/


# 초기 실행파일 복사
COPY start.sh /usr/local/hadoop/start.sh
COPY bin/*.sh /usr/local/

# commons-lang 설치
RUN wget https://mirror.navercorp.com/apache//commons/lang/binaries/commons-lang-2.6-bin.tar.gz && \
    tar -xvf commons-lang-2.6-bin.tar.gz && \
    cp commons-lang-2.6/commons-lang-2.6.jar $SQOOP_HOME/lib && \
    mv $SQOOP_HOME/lib/commons-lang3-3.4.jar commons-lang3-3.4.jar.bak && \
    rm -r commons-lang-2.6 && \
    rm commons-lang-2.6-bin.tar.gz


# ojdbc 7 설치
RUN wget https://fruitdev.tistory.com/attachment/cfile29.uf@2163EB425418EB0E12A98B.jar && \
    mv cfile29.uf@2163EB425418EB0E12A98B.jar ojdbc7.jar && \
    cp ojdbc7.jar $SQOOP_HOME/lib/ && \
    cp ojdbc7.jar $HIVE_HOME/lib/ && \
    cp $SQOOP_HOME/sqoop-1.4.7.jar $HADOOP_HOME/share/hadoop/tools/lib/ && \
    rm ojdbc7.jar


# namenode 초기화
#RUN $HADOOP_HOME/bin/hdfs namenode -format -force

# hdfs workers,matsers 설정
WORKDIR $HADOOP_HOME/etc/hadoop
RUN echo "${HDFS_DN1_NAME}\n${HDFS_DN2_NAME}\n${HDFS_DN3_NAME}" > workers && \
    echo "${HDFS_NN1_NAME}\n${HDFS_NN2_NAME}" > masters

RUN mkdir /var/run/sshd

#RUN /usr/sbin/sshd
#ENTRYPOINT tail -f /dev/null

WORKDIR $HADOOP_HOME

EXPOSE 22


CMD ["bash","start.sh"]

#ENTRYPOINT ["/usr/sbin/sshd","-D"]


#    start-all.sh && \
#    mr-jobhistory-daemon.sh start historyserver && \
#    /bin/bash
