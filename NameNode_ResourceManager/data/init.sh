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

echo "Start YARN"
start-yarn.sh

echo "HDFS report"
hdfs dfsadmin -report

echo "YARN nodes"
yarn node -list

echo "Adding directories to HDFS"
mkdir /books
wget -O /books/alice.txt https://www.gutenberg.org/files/11/11-0.txt  
wget -O /books/holmes.txt https://www.gutenberg.org/ebooks/1661.txt.utf-8
wget -O /books/frankenstein.txt https://www.gutenberg.org/ebooks/84.txt.utf-8
hdfs dfs -mkdir -p /user/maany/books
hdfs dfs -put /books/alice.txt /books/holmes.txt /books/frankenstein.txt /user/maany/books

echo "All Done!"
