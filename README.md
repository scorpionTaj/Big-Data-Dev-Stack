# 🐘 Local Big Data Dev Stack

<p align="center">
  <img src="https://img.shields.io/badge/Hadoop-3.2.1-yellow?style=for-the-badge&logo=apache-hadoop&logoColor=white" alt="Hadoop"/>
  <img src="https://img.shields.io/badge/Spark-3.0.0-orange?style=for-the-badge&logo=apache-spark&logoColor=white" alt="Spark"/>
  <img src="https://img.shields.io/badge/Hive-2.3.2-green?style=for-the-badge&logo=apache-hive&logoColor=white" alt="Hive"/>
  <img src="https://img.shields.io/badge/HBase-1.2.6-red?style=for-the-badge&logo=apache&logoColor=white" alt="HBase"/>
  <img src="https://img.shields.io/badge/Cassandra-4.0-blue?style=for-the-badge&logo=apache-cassandra&logoColor=white" alt="Cassandra"/>
</p>

<p align="center">
  <strong>A complete Big Data ecosystem orchestrated with Docker Compose</strong><br>
  <em>Hadoop • Hive • HBase • Spark • Cassandra</em>
</p>

---

## 📋 Table of Contents

- [Prerequisites](#-prerequisites)
- [Quick Start](#-quick-start)
- [Architecture](#-architecture)
- [Access Points & UIs](#-access-points--uis)
- [CLI Access](#-cli-access)
- [Configuration Notes](#-configuration-notes)
- [Troubleshooting](#-troubleshooting)

---

## ⚠️ Prerequisites

| Requirement       | Minimum  | Recommended |
| ----------------- | -------- | ----------- |
| 🐳 Docker         | Latest   | Latest      |
| 🔧 Docker Compose | v2.0+    | v2.0+       |
| 💾 RAM            | 10-12 GB | 16 GB       |
| 🖥️ CPUs           | 4 cores  | 6+ cores    |

> **💡 Tip:** If you have less than 16GB RAM, consider commenting out services in `docker-compose.yml` that you aren't currently using (e.g., disable Cassandra if you're only working with Hive).

---

## 🚀 Quick Start

### 1️⃣ Start the cluster

```bash
docker-compose up -d
```

### 2️⃣ Wait for initialization

⏳ Allow **2-3 minutes** for all services to initialize:

- Hadoop SafeMode exit
- Hive Metastore schema initialization
- HBase region assignment

### 3️⃣ Verify services

```bash
docker-compose ps
```

### 🛑 Stop the cluster

```bash
# Stop containers (preserves data)
docker-compose down

# Stop and remove all data (⚠️ destructive)
docker-compose down -v
```

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        bigdata-net (Docker Network)              │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌──────────────┐     ┌──────────────┐     ┌──────────────┐     │
│  │  Zookeeper   │     │   NameNode   │     │   DataNode   │     │
│  │    :2181     │     │    :9870     │     │              │     │
│  └──────────────┘     └──────────────┘     └──────────────┘     │
│         │                    │                    │              │
│         ▼                    ▼                    ▼              │
│  ┌──────────────┐     ┌─────────────────────────────────┐       │
│  │ HBase Master │     │           HDFS Cluster          │       │
│  │   :16010     │◄────│                                 │       │
│  └──────────────┘     └─────────────────────────────────┘       │
│         │                           │                            │
│         ▼                           ▼                            │
│  ┌──────────────┐     ┌──────────────┐     ┌──────────────┐     │
│  │   HBase      │     │    Hive      │     │    Spark     │     │
│  │ RegionServer │     │   Server     │     │   Master     │     │
│  └──────────────┘     │   :10000     │     │    :8080     │     │
│                       └──────────────┘     └──────────────┘     │
│                              │                    │              │
│                              ▼                    ▼              │
│                       ┌──────────────┐     ┌──────────────┐     │
│                       │  PostgreSQL  │     │    Spark     │     │
│                       │  (Metastore) │     │   Worker     │     │
│                       └──────────────┘     │    :8081     │     │
│                                            └──────────────┘     │
│  ┌──────────────┐                                               │
│  │  Cassandra   │  (Standalone NoSQL)                           │
│  │    :9042     │                                               │
│  └──────────────┘                                               │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## 🔌 Access Points & UIs

### 🌐 Web Interfaces

|   Service    |  Component  |                       URL                        | Description                 |
| :----------: | :---------: | :----------------------------------------------: | :-------------------------- |
| 🗂️ **HDFS**  | NameNode UI |  [http://localhost:9870](http://localhost:9870)  | Browse the file system      |
| ⚡ **Spark** |  Master UI  |  [http://localhost:8080](http://localhost:8080)  | View Spark jobs & workers   |
| ⚡ **Spark** |  Worker UI  |  [http://localhost:8081](http://localhost:8081)  | View worker details         |
| 📊 **HBase** |  Master UI  | [http://localhost:16010](http://localhost:16010) | View HBase tables & regions |

### 🔗 Connection Ports

|     Service      |  Port   | Protocol | Connect With               |
| :--------------: | :-----: | :------: | :------------------------- |
|   🐝 **Hive**    | `10000` |   JDBC   | Beeline, DBeaver, DataGrip |
|   🐝 **Hive**    | `10002` |   HTTP   | Web UI                     |
| 🔵 **Cassandra** | `9042`  |   CQL    | cqlsh, drivers             |
|   🗂️ **HDFS**    | `9000`  |   RPC    | Hadoop clients             |
|   ⚡ **Spark**   | `7077`  |   RPC    | spark-submit               |
| 🦁 **Zookeeper** | `2181`  |   TCP    | ZK clients                 |

---

## 🛠️ CLI Access

### 📁 1. Accessing HDFS

```bash
# Enter the NameNode container
docker exec -it namenode bash
```

```bash
# Inside container - HDFS commands
hdfs dfs -ls /
hdfs dfs -mkdir /user
hdfs dfs -mkdir /test_input
hdfs dfs -put localfile.txt /test_input/
```

---

### 🐝 2. Accessing Hive (SQL)

```bash
# Enter the Hive Server container
docker exec -it hive-server bash
```

```bash
# Inside container - Connect via Beeline
/opt/hive/bin/beeline -u jdbc:hive2://localhost:10000
```

```sql
-- Example Hive commands
SHOW DATABASES;
CREATE DATABASE testdb;
USE testdb;
CREATE TABLE test (id INT, name STRING);
```

> **📝 Note:** It may take a moment for HiveServer2 to be ready to accept connections after startup.

---

### ⚡ 3. Accessing Spark

```bash
# Enter the Spark Master container
docker exec -it spark-master bash
```

```bash
# Inside container - Launch Spark Shell (Scala)
spark-shell --master spark://spark-master:7077

# Or PySpark
pyspark --master spark://spark-master:7077
```

```scala
// Example Spark commands
val data = Seq(1, 2, 3, 4, 5)
val rdd = sc.parallelize(data)
rdd.reduce(_ + _)
```

---

### 📊 4. Accessing HBase

```bash
# Enter the HBase Master container
docker exec -it hbase-master bash
```

```bash
# Inside container - Launch HBase Shell
hbase shell
```

```ruby
# Example HBase commands
status
list
create 'users', 'info', 'contact'
put 'users', 'user1', 'info:name', 'John Doe'
scan 'users'
```

---

### 🔵 5. Accessing Cassandra

```bash
# Connect directly to CQL shell
docker exec -it cassandra cqlsh
```

```sql
-- Example CQL commands
DESCRIBE KEYSPACES;
CREATE KEYSPACE testks WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};
USE testks;
CREATE TABLE users (id UUID PRIMARY KEY, name TEXT);
```

---

## 📝 Configuration Notes

### 🔗 Integration

| Component | Storage Backend                     | Coordination           |
| --------- | ----------------------------------- | ---------------------- |
| HBase     | HDFS (`hdfs://namenode:9000/hbase`) | Zookeeper              |
| Hive      | HDFS (`hdfs://namenode:9000`)       | PostgreSQL (Metastore) |
| Spark     | HDFS (`hdfs://namenode:9000`)       | Standalone             |

### 🌐 Networking

All containers communicate through the `bigdata-net` Docker bridge network.

### 💾 Persistence

| Volume          | Purpose                |
| --------------- | ---------------------- |
| `namenode_data` | HDFS NameNode metadata |
| `datanode_data` | HDFS DataNode blocks   |

> **⚠️ Warning:** Running `docker-compose down -v` will **delete all data** in these volumes!

---

## 🔧 Troubleshooting

### ❌ Common Issues

<details>
<summary><strong>🔴 Container keeps restarting</strong></summary>

Check logs for the specific container:

```bash
docker logs <container_name>
```

Most common causes:

- Insufficient memory allocated to Docker
- Dependency service not ready yet
</details>

<details>
<summary><strong>🔴 Cannot connect to Hive</strong></summary>

HiveServer2 takes time to initialize. Check if it's ready:

```bash
docker logs hive-server 2>&1 | grep -i "started"
```

</details>

<details>
<summary><strong>🔴 HDFS in Safe Mode</strong></summary>

Wait for the cluster to exit safe mode, or force it:

```bash
docker exec -it namenode hdfs dfsadmin -safemode leave
```

</details>

<details>
<summary><strong>🔴 HBase tables not accessible</strong></summary>

Ensure Zookeeper is running and HBase can connect:

```bash
docker logs hbase-master 2>&1 | grep -i "zookeeper"
```

</details>

---

## 📚 Additional Resources

- 📖 [Apache Hadoop Documentation](https://hadoop.apache.org/docs/)
- 📖 [Apache Spark Documentation](https://spark.apache.org/docs/latest/)
- 📖 [Apache Hive Documentation](https://cwiki.apache.org/confluence/display/Hive)
- 📖 [Apache HBase Documentation](https://hbase.apache.org/book.html)
- 📖 [Apache Cassandra Documentation](https://cassandra.apache.org/doc/latest/)

---

<p align="center">
  <sub>Made with ❤️ for Big Data enthusiasts</sub>
</p>
