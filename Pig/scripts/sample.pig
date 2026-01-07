-- Sample Pig Script
-- This is a basic example to test Pig functionality

-- Load data from HDFS
raw_data = LOAD '/user/hadoop/input/*' AS (name:chararray, age:int, salary:double);

-- Filter records
filtered_data = FILTER raw_data BY age > 25;

-- Group by name
grouped_data = GROUP filtered_data BY name;

-- Calculate average salary
avg_salary = FOREACH grouped_data GENERATE group AS name, AVG(filtered_data.salary) AS avg_sal;

-- Store result to HDFS
STORE avg_salary INTO '/user/hadoop/output/pig_result';
