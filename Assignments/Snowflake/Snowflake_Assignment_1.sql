USE DATABASE MYDB;
USE WAREHOUSE MYWAREHOUSE;

-- Load the given dataset into snowflake with a primary key to Order Date column.

CREATE OR REPLACE TABLE JJ_SALES_DATA (
    ORDER_ID VARCHAR(30),
    ORDER_DATE DATE PRIMARY KEY,
    SHIP_DATE DATE,
    SHIP_MODE STRING,
    CUSTOMER_NAME STRING,
    SEGMENT CHAR(20),
    STATE CHAR(40),
    COUNTRY CHAR(40),
    MARKET CHAR(40),
    REGION CHAR(40),
    PRODUCT_ID VARCHAR(40),
    CATEGORY CHAR(40),
    SUB_CATEGORY CHAR(40),
    PRODUCT_NAME STRING,
    SALES NUMBER(10),
    QUANTITY NUMBER(10),
    DISCOUNT NUMBER(10),
    PROFIT NUMBER(10),
    SHIPPING_COST NUMBER(10),
    ORDER_PRIORITY CHAR(20),
    YEAR NUMBER(5)

);

DESCRIBE TABLE JJ_SALES_DATA;

SELECT * FROM JJ_SALES_DATA;

-- Change the Primary key to Order Id Column.

ALTER TABLE JJ_SALES_DATA DROP PRIMARY KEY;

ALTER TABLE JJ_SALES_DATA ADD PRIMARY KEY(ORDER_ID);

-- Check the data type for Order date and Ship date and mention in what data type it should be?

DESCRIBE TABLE JJ_SALES_DATA; 

-- ORDER_DATE DATE --> It should be on DATE DATATYPE and it is 
-- SHIP_DATE DATE --> It should be on DATE DATATYPE and it is

-- Create a new column called order_extract and extract the number after the last ‘–‘from Order ID column.

SELECT ORDER_ID FROM JJ_SALES_DATA;

ALTER TABLE JJ_SALES_DATA ADD COLUMN ORDER_EXTRACT NUMBER(20);

SELECT ORDER_ID,SUBSTRING(ORDER_ID,9) AS ORDER_EXTRACT FROM JJ_SALES_DATA;

UPDATE JJ_SALES_DATA SET ORDER_EXTRACT = SUBSTRING(ORDER_ID,9);

-- Create a new column called Discount Flag and categorize it based on discount. Use ‘Yes’ if the discount is greater than zero else ‘No’.

SELECT DISCOUNT FROM JJ_SALES_DATA;

SELECT DISCOUNT,
    CASE 
        WHEN DISCOUNT > 0 THEN 'YES'
        ELSE 'NO'
    END AS DISCOUNT_FLAG
FROM JJ_SALES_DATA;`


-- Create a new column called process days and calculate how many days it takes for each order id to process from the order to its shipment.

SELECT DATEDIFF('DAY',ORDER_DATE,SHIP_DATE) AS PROCESS_DAYS FROM JJ_SALES_DATA;

ALTER TABLE JJ_SALES_DATA ADD COLUMN PROCESS_DAYS NUMBER(10);

UPDATE JJ_SALES_DATA  SET PROCESS_DAYS = DATEDIFF('DAY',ORDER_DATE,SHIP_DATE);


-- Create a new column called Rating and then based on the Process dates give rating like given below.

ALTER TABLE JJ_SALES_DATA ADD COLUMN RATING NUMBER(10);

UPDATE JJ_SALES_DATA SET RATING =  
                                 CASE 
                                     WHEN PROCESS_DAYS <= 3 THEN '5'
                                     WHEN PROCESS_DAYS > 3 AND PROCESS_DAYS <= 6 THEN '4'
                                     WHEN PROCESS_DAYS > 6 AND PROCESS_DAYS <= 10 THEN '3'
                                 ELSE '2'
END ;
                                 
                                     
