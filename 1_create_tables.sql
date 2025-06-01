-- 如果表存在，先删除旧表
DROP TABLE IF EXISTS retail_sales;

-- 创建表结构
CREATE TABLE retail_sales (
  transactions_id     INT PRIMARY KEY,
  sale_date           DATE,
  sale_time           TIME,
  customer_id         INT,
  gender              VARCHAR(15),
  age                 INT,
  category            VARCHAR(15),
  quantity            INT,
  price_per_unit      FLOAT,	
  cogs                FLOAT,
  total_sale          FLOAT
);