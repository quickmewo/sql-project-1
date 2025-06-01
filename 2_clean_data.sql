-- 修正拼写错误字段名
ALTER TABLE retail_sales
CHANGE quantiy quantity INT;

-- 数据清洗：查看是否存在缺失值
SELECT * 
FROM retail_sales
WHERE 
  transactions_id IS NULL OR
  sale_date IS NULL OR
  sale_time IS NULL OR
  customer_id IS NULL OR
  gender IS NULL OR
  age IS NULL OR
  category IS NULL OR
  quantity IS NULL OR
  price_per_unit IS NULL OR
  cogs IS NULL OR
  total_sale IS NULL;