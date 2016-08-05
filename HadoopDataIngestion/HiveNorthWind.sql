DROP DATABASE IF EXISTS WHITSKL CASCADE;
CREATE DATABASE IF NOT EXISTS WHITSKL;
USE WHITSKL;

--############################################################################
--#CUSTOMERS
--############################################################################

DROP TABLE IF EXISTS CUSTOMERS;
CREATE EXTERNAL TABLE IF NOT EXISTS CUSTOMERS
(
     CUSTOMERID STRING,
     COMPANYNAME STRING,
     CONTACTNAME STRING,
     CONTACTTITLE STRING,
     ADDRESS STRING,
     CITY STRING,
     REGION STRING,
     POSTALCODE STRING,
     COUNTRY STRING,
     PHONE STRING,
     FAX STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
ESCAPED BY "\\"
LINES TERMINATED BY '\n'
STORED AS TEXTFILE
LOCATION '/user/kl_whits/stage/whitskl/customers';


--############################################################################
--#ORDERS
--############################################################################

DROP TABLE IF EXISTS ORDERS;
CREATE EXTERNAL TABLE IF NOT EXISTS ORDERS
(
     ORDERID INT,
     CUSTOMERID STRING,
     EMPLOYEEID INT,
     ORDERDATE TIMESTAMP,
     REQUIREDDATE TIMESTAMP,
     SHIPPEDDATE TIMESTAMP,
     SHIPVIA INT,
     FREIGHT DECIMAL,
     SHIPNAME STRING,
     SHIPADDRESS STRING,
     SHIPCITY STRING,
     SHIPREGION STRING,
     SHIPPOSTALCODE STRING,
     SHIPCOUNTRY STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
ESCAPED BY "\\"
LINES TERMINATED BY '\n'
STORED AS TEXTFILE
LOCATION '/user/kl_whits/stage/whitskl/orders';


--############################################################################
--#ORDERDETAILS
--############################################################################

DROP TABLE IF EXISTS ORDERDETAILS;
CREATE EXTERNAL TABLE IF NOT EXISTS ORDERDETAILS
(
     ORDERID INT,
     PRODUCTID INT,
     PRODUCTNAME STRING,
     UNITPRICE DOUBLE,
     QUANTITY INT,
     DISCOUNT DOUBLE,
     EXTENDEDPRICE DOUBLE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
ESCAPED BY "\\"
LINES TERMINATED BY '\n'
STORED AS TEXTFILE
LOCATION '/user/kl_whits/stage/whitskl/orderdetails';



--############################################################################
--#CUSTOMERS2
--############################################################################
USE WHITSKL;
DROP TABLE IF EXISTS CUSTOMERS2;
CREATE EXTERNAL TABLE IF NOT EXISTS CUSTOMERS2
(
     CUSTOMERID STRING,
     COMPANYNAME STRING,
     CONTACTNAME STRING,
     CONTACTTITLE STRING,
     ADDRESS STRING,
     CITY STRING,
     REGION STRING,
     POSTALCODE STRING,
     COUNTRY STRING,
     PHONE STRING,
     FAX STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
ESCAPED BY "\\"
LINES TERMINATED BY '\n'
STORED AS TEXTFILE
LOCATION '/user/kl_whits/stage/customers'
tblproperties ("skip.header.line.count"="1");

