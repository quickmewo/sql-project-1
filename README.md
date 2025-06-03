# 零售销售数据分析｜SQL 项目

本项目围绕一份零售交易数据构建，模拟真实业务场景中常见的客户行为分析、销售趋势洞察与品类表现评估等任务，涵盖完整的 SQL 分析流程，包括数据建库、清洗、浏览与多维度问题建模与解决。

---

## 项目目标

- 建立并初始化结构化销售数据库  
- 进行字段清洗与数据完整性检查  
- 浏览整体销售分布与顾客结构  
- 设计并解决 10 个典型业务分析问题  

---

## 数据结构

数据表：`retail_sales`

| 字段名           | 类型         | 描述           |
|------------------|--------------|----------------|
| transactions_id  | INT          | 唯一交易编号   |
| sale_date        | DATE         | 销售日期       |
| sale_time        | TIME         | 销售时间       |
| customer_id      | INT          | 顾客编号       |
| gender           | VARCHAR(15)  | 性别           |
| age              | INT          | 年龄           |
| category         | VARCHAR(15)  | 商品类别       |
| quantity         | INT          | 购买数量       |
| price_per_unit   | FLOAT        | 单价           |
| cogs             | FLOAT        | 成本           |
| total_sale       | FLOAT        | 总销售额       |

---

## 分析流程概览

### 1. 数据库初始化、结构化建表与字段修正

```sql
-- 创建数据库并切换
CREATE DATABASE sql_project_1;
USE sql_project_1;

-- 若表已存在，先删除旧表
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
  quantiy             INT,  -- 注意：原始字段拼写错误
  price_per_unit      FLOAT,
  cogs                FLOAT,
  total_sale          FLOAT
);

-- 字段修正：将拼写错误的 quantiy 改为 quantity
ALTER TABLE retail_sales
CHANGE quantiy quantity INT;
```

---

### 2. 数据清洗与完整性检查

```sql
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
```

---

### 3. 数据浏览与结构分析

```sql
-- 总交易记录数
SELECT COUNT(*) FROM retail_sales;

-- 唯一顾客数
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;

-- 商品类别分布
SELECT DISTINCT category FROM retail_sales;
```

---

## 关键分析问题

| 编号 | 业务问题描述                              | 涉及操作                    |
|------|-------------------------------------------|-----------------------------|
| Q1   | 查询指定日期的销售记录                    | 条件筛选                    |
| Q2   | 查询 Clothing 类且数量 ≥4 的订单          | 多条件 WHERE 查询          |
| Q3   | 统计每类商品的总销售额与订单数            | GROUP BY + SUM + COUNT     |
| Q4   | 计算 Beauty 类商品顾客的平均年龄          | 条件过滤 + 平均值计算      |
| Q5   | 查询单笔销售额大于 1000 的记录            | 数值比较                    |
| Q6   | 不同性别在各类商品中的购买笔数分布        | GROUP BY 多字段            |
| Q7   | 每年平均销售额最高的月份                  | 窗口函数 + RANK 排名       |
| Q8   | 销售额前 5 的顾客                         | ORDER BY + LIMIT / 窗口函数|
| Q9   | 各类唯一顾客数 + 购买全品类的顾客数量     | DISTINCT + 子查询 + HAVING |
| Q10  | 按时间段划分销售（早/午/晚）并统计订单数  | CASE WHEN + 时间函数       |

示例（Q7）：

```sql
SELECT year, month, avg_sale
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
```

---

## 能力展示

- 构建并操作结构化数据库，具备完整建表与清洗能力  
- 使用 SQL 实现多维度业务问题建模与解决  
- 掌握分组聚合、条件筛选、窗口函数与时间字段处理  
- 能独立完成从数据理解 → 清洗 → 建模 → 输出的分析全流程  

---

如需查看完整 SQL 脚本与查询语句，请参阅本项目内的 `analysis.sql` 文件。
