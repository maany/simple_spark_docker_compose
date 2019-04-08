#!/bin/bash
docker build -t simple_spark_hadoop_master .
docker stop simple_spark_hadoop_master && docker rm simple_spark_hadoop_master
docker run -itd \
    --name simple_spark_hadoop_master \
    simple_spark_hadoop_master \
    /bin/bash

docker exec -it simple_spark_hadoop_master bash