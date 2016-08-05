#!/usr/bin/python
#FileName=volumeByMonthUnpivot.py
#To Run:
#yarn jar /usr/hdp/current/hadoop-mapreduce-client/hadoop-streaming.jar \
#  -D stream.map.output.field.separator=, \
#  -D mapred.textoutputformat.separator=, \
#  -mapper volumeByMonthUnpivot.py \
#  -input /apps/hive/warehouse/welldata.db/volumebymonthpivoted/ \
#  -output /user/hdfs/.staging/volumebymonthunpivoted \
#  -numReduceTasks 0 \
#  -file volumeByMonthUnpivot.py

import sys

for line in sys.stdin:
        delim = ","
        attributes = line.strip().split(delim)
        rKey = delim.join([attributes[0], attributes[1], attributes[2]])
        for i in range(0,12):
                month = str(i+1)
                print(delim.join([rKey,month,attributes[i+3]]))
