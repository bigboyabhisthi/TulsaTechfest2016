#!/bin/bash
#Clean Environment
hadoop fs -rm -R -skipTrash /user/hdfs/.staging/*
hive -e "drop database if exists northwind cascade"
rm -f /home/hdfs/customers_clean.csv
