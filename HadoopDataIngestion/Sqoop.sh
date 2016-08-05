#!/bin/bash
#https://sqoop.apache.org/docs/1.4.6/SqoopUserGuide.html

############################################################################
#CUSTOMERS
############################################################################
hive -e "drop table if exists northwind.customers"
hadoop fs -rm -r -skipTrash /user/hdfs/.staging/northwind/customers
hadoop fs -rm -r -skipTrash /apps/hive/warehouse/northwind.db/customers

sqoop import -P \
--username hdfs \
--connect jdbc:postgresql://localhost:5432/northwind \
--driver org.postgresql.Driver \
--target-dir /user/hdfs/.staging/northwind/customers \
--escaped-by '\' \
--null-string "" \
--split-by CUSTOMERID \
--num-mappers 2 \
--query "SELECT * FROM customers WHERE \$CONDITIONS"

hadoop fs -mv /user/hdfs/.staging/northwind/customers/* /apps/hive/warehouse/northwind.db/customers/
hadoop fs -cat /user/hdfs/.staging/northwind/customers/* | head | cat -A


############################################################################
#ORDERS
############################################################################
hive -e "drop table if exists northwind.orders"
hadoop fs -rm -R /user/hdfs/.staging/northwind/orders/

sqoop import -P \
--hive-import \
--hive-table northwind.orders \
--username hdfs \
--connect jdbc:postgresql://localhost:5432/northwind \
--driver org.postgresql.Driver \
--target-dir /user/hdfs/.staging/northwind/orders \
--null-string "" \
--fields-terminated-by "," \
--escaped-by "\\" \
--split-by ORDERID \
--num-mappers 2 \
--query "SELECT * FROM orders WHERE \$CONDITIONS"

hive -e 'ALTER TABLE northwind.orders SET SERDEPROPERTIES ("escape.delim"="\\")'
hive -e "select * from northwind.orders limit 10;"


############################################################################
#ORDERDETAILS
############################################################################
hive -e "drop table if exists northwind.orderdetails"
hadoop fs -rm -R /user/hdfs/.staging/northwind/orderdetails/

sqoop import -P \
--hive-import \
--hive-table northwind.orderdetails \
--username hdfs \
--connect jdbc:postgresql://localhost:5432/northwind \
--driver org.postgresql.Driver \
--target-dir /user/hdfs/.staging/northwind/orderdetails \
--null-string "" \
--fields-terminated-by "," \
--escaped-by "\\" \
--split-by ORDERID \
--num-mappers 2 \
--query "SELECT * FROM orderdetails WHERE \$CONDITIONS"

hive -e 'ALTER TABLE northwind.orderdetails SET SERDEPROPERTIES ("escape.delim"="\\")'
hive -e "select * from northwind.orderdetails limit 10;"


