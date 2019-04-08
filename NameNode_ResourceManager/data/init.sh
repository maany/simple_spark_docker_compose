#!/bin/bash
echo "Copy Hadoop conf files to /root/hadoop/etc/hadoop/"
cp /data/hadoop-env.sh /root/hadoop/etc/hadoop/
cp /data/core-site.xml /root/hadoop/etc/hadoop/
cp /data/hdfs-site.xml /root/hadoop/etc/hadoop/
cp /data/mapred-site.xml /root/hadoop/etc/hadoop/
cp -f /data/yarn-site.xml /root/hadoop/etc/hadoop/
cp -f /data/slaves /root/hadoop/etc/hadoop/
echo "Formatting HDFS"
hdfs namenode -format

echo "Adding known_hosts"
ssh-keyscan -H 192.0.2.12 >> ~/.ssh/known_hosts
ssh-keyscan -H 192.0.2.13 >> ~/.ssh/known_hosts

echo "Starting HDFS"
start-dfs.sh
echo "HDFS report"
hdfs dfsadmin -report

echo "All Done!"
