/*To Run

mvn clean package
pscp -P 2222 .\target\map-reduce-example-0.0.1-SNAPSHOT.jar root@127.0.0.1:/home/hdfs/

hadoop fs -rm -R -skipTrash /user/hdfs/.staging/welldata/volumebymonthunpivoted/ 
hadoop fs -rm -R -skipTrash /apps/hive/warehouse/welldata.db/volumebymonthunpivoted/*

yarn jar /home/hdfs/map-reduce-example-0.0.1-SNAPSHOT.jar \
  com.idledeveloper.techfest.map_reduce_example.VolumeByMonthUnpivot \
  /apps/hive/warehouse/welldata.db/volumebymonthpivoted/ \
  /user/hdfs/.staging/welldata/volumebymonthunpivoted/

hadoop fs -mv /user/hdfs/.staging/welldata/volumebymonthunpivoted/* \
  /apps/hive/warehouse/welldata.db/volumebymonthunpivoted/

hadoop fs -cat /apps/hive/warehouse/welldata.db/volumebymonthunpivoted/* | head | cat -A

*/

package com.idledeveloper.techfest.map_reduce_example;

import java.io.IOException;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
//import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

public class VolumeByMonthUnpivot {

	public static class VolumeMapper extends Mapper<Object, Text, Text, Text> {
		private static final String delim = ",";
		public void map(Object key, Text value, Context context) throws IOException, InterruptedException {
			
			String[] attributes = value.toString().split(delim);
			String outKey = (attributes[0] + delim + attributes[1] + delim + attributes[2]);
			for (int i = 0; i < 12; i++) {
				String month = Integer.toString(i + 1);
				context.write(new Text(outKey)
					, new Text(month + delim + attributes[i + 3])
				);
			}
		}
	}

	public static void main(String[] args) throws Exception {
		Configuration conf = new Configuration();
		conf.set("mapreduce.output.textoutputformat.separator", ",");
		Job job = Job.getInstance(conf, "Unpivot Monthly Prod");
		job.setJarByClass(VolumeByMonthUnpivot.class);
		job.setMapperClass(VolumeMapper.class);
		job.setNumReduceTasks(0);
		// job.setCombinerClass(IntSumReducer.class);
		// job.setReducerClass(IntSumReducer.class);
		job.setOutputKeyClass(Text.class);
		job.setOutputValueClass(Text.class);
		FileInputFormat.addInputPath(job, new Path(args[0]));
		FileOutputFormat.setOutputPath(job, new Path(args[1]));
		System.exit(job.waitForCompletion(true) ? 0 : 1);
	}
}
