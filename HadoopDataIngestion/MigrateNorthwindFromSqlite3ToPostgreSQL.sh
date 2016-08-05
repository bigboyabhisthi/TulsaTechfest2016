
psql northwind

CREATE TABLE CUSTOMERS
(CUSTOMERID varchar, COMPANYNAME varchar, CONTACTNAME varchar,
CONTACTTITLE varchar, ADDRESS varchar, CITY varchar, REGION varchar,
POSTALCODE varchar, COUNTRY varchar, PHONE varchar, FAX varchar
)

sqlite3 Northwind.Sqlite3.db .dump > Northwind.dump
iconv -f ISO-8859-1 -t UTF-8 Northwind.dump \
| grep -i'insert into "customers"' \
| sed 's/.*://' \
| sed 's/"Customers"/Customers/' \
| psql northwind




CREATE TABLE Orders (
   ORDERID integer, CUSTOMERID varchar, EMPLOYEEID integer,
   ORDERDATE timestamp, REQUIREDDATE timestamp,
   SHIPPEDDATE timestamp, SHIPVIA integer,
   FREIGHT double precision, SHIPNAME varchar,
   SHIPADDRESS varchar, SHIPCITY varchar, SHIPREGION varchar,
   SHIPPOSTALCODE varchar, SHIPCOUNTRY varchar
 );


sqlite3 Northwind.Sqlite3.db .dump > Northwind.dump
iconv -f ISO-8859-1 -t UTF-8 Northwind.dump \
| grep -i'insert into "orders"' \
| sed 's/.*INSERT INTO "Orders" VALUES/INSERT INTO Orders VALUES/' \
| psql northwind


CREATE TABLE OrderDetails(
   OrderID integer, ProductID integer, UnitPrice double precision,
   Quantity integer, Discount double precision
);


sqlite3 Northwind.Sqlite3.db .dump > Northwind.dump
iconv -f ISO-8859-1 -t UTF-8 Northwind.dump \
| grep -i'insert into "order details"' \
| sed 's/.*INSERT INTO "Order Details" VALUES/INSERT INTO OrderDetails VALUES/' \
| psql northwind

