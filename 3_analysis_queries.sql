-- 数据浏览：初步分析

-- 总销售记录数量
SELECT COUNT(*) AS total_sale 
FROM retail_sales;

-- 唯一客户数量
SELECT COUNT(DISTINCT customer_id) AS customer 
FROM retail_sales;

-- 商品类别
SELECT DISTINCT category 
FROM retail_sales;


-- 数据分析与业务问题

-- Q1：查询特定日期的所有销售记录（2022-11-05）
SELECT * 
FROM retail_sales
WHERE sale_date = '2022-11-05';

-- Q2：查询2022年11月中，购买“Clothing”类且数量≥4的记录
SELECT * 
FROM retail_sales
WHERE 
  category = 'Clothing' AND
  quantity >= 4 AND
  sale_date BETWEEN '2022-11-01' AND '2022-11-30';

-- Q3：统计每个类别的总销售额与订单数
SELECT 
  category,
  SUM(total_sale) AS total_sale,
  COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;

-- Q4：统计购买 Beauty 类别商品的顾客的平均年龄
SELECT 
  ROUND(AVG(age), 2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';

-- Q5：查询单笔销售额大于 1000 的记录
SELECT * 
FROM retail_sales
WHERE total_sale > 1000;

-- Q6：统计每个性别在各类商品中的购买订单数
SELECT 
  category,
  gender,
  COUNT(*) AS total_transactions
FROM retail_sales
GROUP BY category, gender
ORDER BY category, gender;

-- Q7：找出每年中销售额平均值最高的月份
SELECT 
  year,
  month,
  avg_sale
FROM (
  SELECT
    YEAR(sale_date) AS year,
    MONTH(sale_date) AS month,
    AVG(total_sale) AS avg_sale,
    RANK() OVER (
      PARTITION BY YEAR(sale_date)
      ORDER BY AVG(total_sale) DESC
    ) AS rank_num
  FROM retail_sales
  GROUP BY YEAR(sale_date), MONTH(sale_date)
) AS t
WHERE rank_num = 1;

-- Q8（方法一）：找出总销售额前 5 的客户（排序 + LIMIT）
SELECT 
  customer_id,
  SUM(total_sale) AS total_sale
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sale DESC
LIMIT 5;

-- Q8（方法二）：使用窗口函数实现客户销售额排行
SELECT 
  customer_id,
  total_sale,
  rnk
FROM (
  SELECT 
    customer_id,
    SUM(total_sale) AS total_sale,
    RANK() OVER (ORDER BY SUM(total_sale) DESC) AS rnk
  FROM retail_sales
  GROUP BY customer_id
) AS t2
WHERE rnk <= 5;

-- Q9：每类商品中的唯一客户数
SELECT 
  category,
  COUNT(DISTINCT customer_id) AS customer_num
FROM retail_sales
GROUP BY category;

-- Q9 延伸：查询购买所有类别的顾客数量
SELECT 
  COUNT(*) AS full_category_customer_num
FROM (
  SELECT customer_id
  FROM retail_sales
  GROUP BY customer_id
  HAVING COUNT(DISTINCT category) = (
    SELECT COUNT(DISTINCT category) 
    FROM retail_sales
  )
) AS t;

-- Q10：按销售时间划分shift（早/午/晚），统计各shift的订单数量
WITH hourly_sale AS (
  SELECT 
    CASE 
      WHEN HOUR(sale_time) < 12 THEN 'Morning'
      WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
      ELSE 'Evening'
    END AS shift
  FROM retail_sales
)
SELECT 
  shift,
  COUNT(*) AS order_count
FROM hourly_sale
GROUP BY shift;
-- END
