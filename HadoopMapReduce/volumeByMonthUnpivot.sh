#!/bin/awk -f
#FileName=volumeByMonthUnpivot.sh
#To Test
#./volumeByMonthUnpivot.sh volumeByMonthPivoted.csv
#To Run:
#yarn jar /usr/hdp/current/hadoop-mapreduce-client/hadoop-streaming.jar \
#  -D stream.map.output.field.separator=, \
#  -D mapred.textoutputformat.separator=, \
#  -mapper volumeByMonthUnpivot.sh \
#  -input /apps/hive/warehouse/welldata.db/volumebymonthpivoted/ \
#  -output /user/hdfs/.staging/volumebymonthunpivoted \
#  -numReduceTasks 0 \
#  -file volumeByMonthUnpivot.sh

BEGIN { FS = "," }{ for(i=0;i<12;i++) print $1 "," $2 "," $3 "," i+1 "," $(4+i)}
