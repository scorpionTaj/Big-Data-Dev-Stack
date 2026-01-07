# Pig + Hue Integration Guide

This guide explains how to use Pig with Hue for a better development experience.

## 🎯 Overview

Hue now integrates with Pig, providing:

- **YARN Job Monitoring**: View Pig job status in real-time
- **HDFS Browser**: Browse input/output data files
- **Logs & Debugging**: View job logs and error messages
- **Pig Editor**: Write and test Pig scripts (via Hue's query editor)

## 🚀 Quick Start

### 1. Start the Services

```bash
# Start Hadoop (required for all operations)
cd hadoop && docker-compose up -d

# Start Pig and Hue
cd ../Pig && docker-compose up -d
cd ../hue && docker-compose up -d
```

### 2. Access Hue

Open your browser and navigate to: **http://localhost:8889**

### 3. Monitor Pig Jobs

In Hue:

1. Click **Job Browser** (left sidebar)
2. View running and completed Pig jobs
3. Click on a job to see logs and detailed metrics

## 📊 Monitoring Pig Jobs in Hue

### Job Browser

- **Location**: Hue Dashboard → Job Browser
- **Shows**: All MapReduce jobs (including those submitted by Pig)
- **Details**:
  - Job ID and status
  - Progress and resource usage
  - Application logs
  - Task breakdowns

### HDFS File Browser

- **Location**: Hue Dashboard → File Browser
- **Use Cases**:
  - Browse `/user/hadoop/input` for input data
  - Browse `/user/hadoop/output` for Pig results
  - Upload test files
  - View file contents

## 🐷 Running Pig Scripts with Hue

### Method 1: Direct Pig Execution

```bash
# Enter Pig container
docker exec -it pig bash

# Run Pig script (jobs appear in Hue's Job Browser)
pig /opt/pig-scripts/sample.pig
```

### Method 2: Using Hue Query Editor (for Hive/SQL)

While Hue doesn't have a native Pig script editor, you can:

1. Use **File Browser** to manage Pig scripts
2. Use **Job Browser** to monitor execution
3. Use **Metastore Browser** to view output tables

## 📁 File Organization

Create organized directories in HDFS for Pig workflows:

```bash
# Inside Pig container
docker exec -it pig bash

# Create directories
hdfs dfs -mkdir -p /user/hue/pig/scripts
hdfs dfs -mkdir -p /user/hue/pig/udf
hdfs dfs -mkdir -p /user/hue/pig/data/input
hdfs dfs -mkdir -p /user/hue/pig/data/output

# Upload scripts
hdfs dfs -put /opt/pig-scripts/sample.pig /user/hue/pig/scripts/
```

## 🔍 Example Workflow

### Step 1: Prepare Input Data

```bash
# In Pig container
docker exec -it pig bash

# Create sample data
echo -e "Alice,25,50000\nBob,30,60000\nCharlie,28,55000" > /tmp/data.csv

# Upload to HDFS
hdfs dfs -put /tmp/data.csv /user/hadoop/input/
```

### Step 2: Create Pig Script

**File**: `/opt/pig-scripts/example.pig`

```pig
-- Load data
employees = LOAD '/user/hadoop/input/data.csv'
    USING PigStorage(',')
    AS (name:chararray, age:int, salary:int);

-- Filter employees with salary > 55000
high_earners = FILTER employees BY salary > 55000;

-- Group and count
salary_stats = GROUP high_earners BY name;

-- Store results
STORE salary_stats INTO '/user/hadoop/output/high_earners';
```

### Step 3: Execute and Monitor

```bash
# In Pig container
pig /opt/pig-scripts/example.pig
```

### Step 4: View Results in Hue

1. Open **http://localhost:8889**
2. Go to **File Browser**
3. Navigate to `/user/hadoop/output/high_earners`
4. View the results
5. Go to **Job Browser** to see job stats

## 🛠️ Configuration Details

### Hue Pig Settings

Location: `/hue/hue-overrides.ini` and `/AIO/hue-overrides.ini`

```ini
[pig]
# Pig script execution type
exec_type=mapreduce

# Directory for UDF (User Defined Functions)
udf_dir=/user/hue/pig/udf

# Directory for Pig scripts
script_dir=/user/hue/pig/scripts
```

### Service Dependencies

The Hue container now depends on:

- `namenode` - For HDFS browsing
- `resourcemanager` - For job monitoring
- `hive-server` - For metastore integration
- `pig` - For Pig script execution

## 📚 Useful Hue Views

| View             | Purpose           | URL                               |
| ---------------- | ----------------- | --------------------------------- |
| **Job Browser**  | Monitor Pig jobs  | http://localhost:8889/jobsub/jobs |
| **File Browser** | Browse HDFS files | http://localhost:8889/filebrowser |
| **Metastore**    | View Hive tables  | http://localhost:8889/metastore   |
| **Query Editor** | Run HiveQL/SQL    | http://localhost:8889/notebook    |

## 🔗 Accessing Both UIs

- **Hadoop HDFS NameNode UI**: http://localhost:9870
- **YARN ResourceManager UI**: http://localhost:8088 (Job monitoring)
- **Hue Dashboard**: http://localhost:8889 (Better UX for all operations)

## ⚠️ Troubleshooting

### Pig Jobs Not Appearing in Hue

1. **Check Pig is running**:

   ```bash
   docker ps | grep pig
   ```

2. **Check Hadoop services**:

   ```bash
   docker logs namenode
   docker logs resourcemanager
   ```

3. **Review Pig logs**:
   ```bash
   docker exec pig tail -f /var/log/pig/pig.log
   ```

### Cannot Connect to Hue

1. Ensure all dependencies are running:

   ```bash
   docker-compose ps
   ```

2. Check Hue logs:

   ```bash
   docker logs hue
   ```

3. Verify network connectivity:
   ```bash
   docker exec hue ping namenode
   docker exec hue ping resourcemanager
   ```

## 📖 Additional Resources

- [Hue Documentation](https://docs.gethue.com/)
- [Apache Pig Documentation](https://pig.apache.org/)
- [Hadoop Job Tracking](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-yarn/index.html)
