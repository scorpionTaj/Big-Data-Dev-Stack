# 🐘 Local Big Data Dev Stack

<p align="center">
  <img src="https://img.shields.io/badge/Hadoop-3.2.1-yellow?style=for-the-badge&logo=apache-hadoop&logoColor=white" alt="Hadoop"/>
  <img src="https://img.shields.io/badge/Spark-3.0.0-orange?style=for-the-badge&logo=apache-spark&logoColor=white" alt="Spark"/>
  <img src="https://img.shields.io/badge/Hive-2.3.2-green?style=for-the-badge&logo=apache-hive&logoColor=white" alt="Hive"/>
  <img src="https://img.shields.io/badge/HBase-1.2.6-red?style=for-the-badge&logo=apache&logoColor=white" alt="HBase"/>
  <img src="https://img.shields.io/badge/Cassandra-4.0-blue?style=for-the-badge&logo=apache-cassandra&logoColor=white" alt="Cassandra"/>
  <img src="https://img.shields.io/badge/Neo4j-5.15-008CC1?style=for-the-badge&logo=neo4j&logoColor=white" alt="Neo4j"/>
  <img src="https://img.shields.io/badge/Kafka-2.4.1-231F20?style=for-the-badge&logo=apache-kafka&logoColor=white" alt="Kafka"/>
  <img src="https://img.shields.io/badge/Pig-0.17-pink?style=for-the-badge&logo=apache&logoColor=white" alt="Pig"/>
  <img src="https://img.shields.io/badge/Flume-1.9-lightblue?style=for-the-badge&logo=apache&logoColor=white" alt="Flume"/>
  <img src="https://img.shields.io/badge/Oozie-4.3.0-purple?style=for-the-badge&logo=apache&logoColor=white" alt="Oozie"/>
  <img src="https://img.shields.io/badge/Hue-4.10.0-cyan?style=for-the-badge&logo=cloudera&logoColor=white" alt="Hue"/>
  <img src="https://img.shields.io/badge/Sqoop-1.4-brown?style=for-the-badge&logo=apache&logoColor=white" alt="Sqoop"/>
</p>

<p align="center">
  <strong>A modular Big Data ecosystem orchestrated with Docker Compose</strong><br>
  <em>Start only what you need • Hadoop • Hive • HBase • Spark • Kafka • Cassandra • Neo4j • Pig • Flume • Oozie • Hue • Sqoop</em>
</p>

---

## 📋 Table of Contents

- [Prerequisites](#-prerequisites)
- [Project Structure](#-project-structure)
- [Quick Start](#-quick-start)
- [Architecture](#-architecture)
- [Access Points & UIs](#-access-points--uis)
- [CLI Access](#-cli-access)
- [Configuration Notes](#-configuration-notes)
- [Troubleshooting](#-troubleshooting)

---

## ⚠️ Prerequisites

|    Requirement    | Minimum | Recommended |
| :---------------: | :-----: | :---------: |
|     🐳 Docker     | Latest  |   Latest    |
| 🔧 Docker Compose |  v2.0+  |    v2.0+    |
|      💾 RAM       | 4-6 GB  |   8-16 GB   |
|      🖥️ CPUs      | 2 cores |  4+ cores   |

> **💡 Tip:** With the modular setup, you can now run individual services with much lower resource requirements!

---

## 📁 Project Structure

```
BigData_Docker/
├── 📄 README.md
│
├── 📂 AIO/                     # 🚀 All-In-One (Full Stack)
│   ├── docker-compose.yml
│   └── pig.Dockerfile
│
├── 📂 hadoop/                  # HDFS Cluster
│   └── docker-compose.yml
│
├── 📂 zookeeper/               # Coordination Service
│   └── docker-compose.yml
│
├── 📂 hive/                    # Data Warehousing
│   └── docker-compose.yml
│
├── 📂 spark/                   # Distributed Processing
│   └── docker-compose.yml
│
├── 📂 hbase/                   # NoSQL Column Store
│   └── docker-compose.yml
│
├── 📂 cassandra/               # NoSQL Wide-Column
│   └── docker-compose.yml
│
├── 📂 neo4j/                   # Graph Database
│   └── docker-compose.yml
│
├── 📂 kafka/                   # Message Streaming
│   └── docker-compose.yml
│
├── 📂 pig/                     # Data Flow Scripting
│   ├── docker-compose.yml
│   └── Dockerfile
│
├── 📂 flume/                   # Log/Data Ingestion
│   ├── docker-compose.yml
│   └── Dockerfile
│
├── 📂 oozie/                   # Workflow Scheduler
│   └── docker-compose.yml
│
├── 📂 hue/                     # Web UI for Hadoop
│   └── docker-compose.yml
│
└── 📂 sqoop/                   # Data Transfer Tool
    ├── docker-compose.yml
    └── Dockerfile
```

---

## 🚀 Quick Start

### 🎯 Option 1: Start Individual Services (Recommended)

Start only the services you need with minimal resources:

|     Service      |                Command                 |    Dependencies    |   RAM   |
| :--------------: | :------------------------------------: | :----------------: | :-----: |
|  🗂️ **Hadoop**   |  `cd hadoop && docker-compose up -d`   |        None        |  ~2 GB  |
| 🦁 **Zookeeper** | `cd zookeeper && docker-compose up -d` |        None        | ~512 MB |
|   ⚡ **Spark**   |   `cd spark && docker-compose up -d`   |       Hadoop       |  ~2 GB  |
|   🐝 **Hive**    |   `cd hive && docker-compose up -d`    |       Hadoop       |  ~2 GB  |
|   📊 **HBase**   |   `cd hbase && docker-compose up -d`   | Hadoop + Zookeeper |  ~1 GB  |
| 🔵 **Cassandra** | `cd cassandra && docker-compose up -d` | None (standalone)  |  ~1 GB  |
|   🕸️ **Neo4j**   |   `cd neo4j && docker-compose up -d`   | None (standalone)  |  ~1 GB  |
|   📨 **Kafka**   |   `cd kafka && docker-compose up -d`   |     Zookeeper      |  ~1 GB  |
|    🐷 **Pig**    |    `cd pig && docker-compose up -d`    |       Hadoop       | ~512 MB |
|   🌊 **Flume**   |   `cd flume && docker-compose up -d`   |       Hadoop       | ~512 MB |
|   📅 **Oozie**   |   `cd oozie && docker-compose up -d`   |       Hadoop       |  ~1 GB  |
|    🎨 **Hue**    |    `cd hue && docker-compose up -d`    |       Hadoop       |  ~1 GB  |
|   🔄 **Sqoop**   |   `cd sqoop && docker-compose up -d`   |       Hadoop       | ~512 MB |

#### 📋 Example: Start Hadoop + Spark

```bash
# 1. Start Hadoop first (creates the network)
cd hadoop && docker-compose up -d

# 2. Wait for Hadoop to be ready (~1 min)
docker logs -f namenode  # Wait until "Safe mode is OFF"

# 3. Start Spark
cd ../spark && docker-compose up -d
```

#### 📋 Example: Start HBase Stack

```bash
# 1. Start Hadoop (creates the network)
cd hadoop && docker-compose up -d

# 2. Start Zookeeper
cd ../zookeeper && docker-compose up -d

# 3. Start HBase
cd ../hbase && docker-compose up -d
```

---

### 🌐 Option 2: All-In-One (Full Stack)

Start **all services at once** using the `AIO` folder (requires 10-12 GB RAM):

```bash
# Navigate to the AIO folder
cd AIO

# Build and start all services
docker-compose up -d --build
```

> **📦 What's included in AIO:**
>
> - Hadoop (NameNode + DataNode)
> - Zookeeper
> - Hive (Metastore + Server + PostgreSQL)
> - Spark (Master + Worker)
> - HBase (Master + RegionServer)
> - Cassandra
> - Neo4j
> - Pig

⏳ Allow **2-3 minutes** for all services to initialize:

- Hadoop SafeMode exit
- Hive Metastore schema initialization
- HBase region assignment

### ✅ Verify Services

```bash
docker-compose ps

# Or check specific service
cd hadoop && docker-compose ps
```

### 🛑 Stop Services

```bash
# Stop individual service (preserves data)
cd hadoop && docker-compose down

# Stop all services from root
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
│  ┌──────────────┐     ┌──────────────┐                          │
│  │  Cassandra   │     │    Neo4j     │  (Standalone DBs)        │
│  │    :9042     │     │    :7474     │                          │
│  └──────────────┘     └──────────────┘                          │
│                                                                  │
│  ┌──────────────┐                                               │
│  │     Pig      │────────────────────────► HDFS                 │
│  │  (Scripting) │                                               │
│  └──────────────┘                                               │
│                                                                  │
│  ┌──────────────┐     ┌──────────────┐     ┌──────────────┐     │
│  │    Flume     │     │    Oozie     │     │     Hue      │     │
│  │  (Ingestion) │     │  (Workflow)  │     │   (Web UI)   │     │
│  │              │     │   :11000     │     │    :8888     │     │
│  └──────────────┘     └──────────────┘     └──────────────┘     │
│         │                    │                    │              │
│         └────────────────────┼────────────────────┘              │
│                              ▼                                   │
│                       ┌──────────────┐                          │
│                       │    Sqoop     │────────► RDBMS           │
│                       │  (Transfer)  │                          │
│                       └──────────────┘                          │
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
| 🕸️ **Neo4j** |   Browser   |  [http://localhost:7474](http://localhost:7474)  | Graph database browser      |
| 📅 **Oozie** | Web Console | [http://localhost:11000](http://localhost:11000) | Workflow management         |
|  🎨 **Hue**  |   Browser   |  [http://localhost:8888](http://localhost:8888)  | Hadoop Web UI               |

### 🔗 Connection Ports

|     Service      |  Port   | Protocol | Connect With               |
| :--------------: | :-----: | :------: | :------------------------- |
|   🐝 **Hive**    | `10000` |   JDBC   | Beeline, DBeaver, DataGrip |
|   🐝 **Hive**    | `10002` |   HTTP   | Web UI                     |
| 🔵 **Cassandra** | `9042`  |   CQL    | cqlsh, drivers             |
|   🗂️ **HDFS**    | `9000`  |   RPC    | Hadoop clients             |
|   ⚡ **Spark**   | `7077`  |   RPC    | spark-submit               |
| 🦁 **Zookeeper** | `2181`  |   TCP    | ZK clients                 |
|   📨 **Kafka**   | `9092`  |   TCP    | Kafka clients, producers   |
|   🕸️ **Neo4j**   | `7687`  |   Bolt   | Cypher Shell, drivers      |
|   📅 **Oozie**   | `11000` |   HTTP   | REST API, Web UI           |
|    🎨 **Hue**    | `8888`  |   HTTP   | Web browser                |

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

### 🕸️ 6. Accessing Neo4j

```bash
# Open browser UI
# Navigate to http://localhost:7474
# Default credentials: neo4j / password123
```

```bash
# Or use cypher-shell from container
docker exec -it neo4j cypher-shell -u neo4j -p password123
```

```cypher
// Example Cypher commands
CREATE (p:Person {name: 'John', age: 30});
CREATE (p:Person {name: 'Jane', age: 25});
MATCH (a:Person {name: 'John'}), (b:Person {name: 'Jane'})
CREATE (a)-[:KNOWS]->(b);
MATCH (n) RETURN n;
```

---

### 🐷 9. Accessing Pig

```bash
# Enter interactive Pig shell (Grunt)
docker exec -it pig pig
```

```bash
# Or run in local mode (no HDFS required)
docker exec -it pig pig -x local
```

```pig
-- Example Pig Latin commands
data = LOAD '/test_input/data.txt' USING PigStorage(',') AS (id:int, name:chararray);
filtered = FILTER data BY id > 10;
grouped = GROUP filtered BY name;
counts = FOREACH grouped GENERATE group, COUNT(filtered);
DUMP counts;
```

> **📝 Note:** For HDFS mode, ensure Hadoop is running first. Use `-x local` for standalone testing.

---

### 📨 8. Accessing Kafka

```bash
# Enter the Kafka container
docker exec -it kafka bash
```

```bash
# Create a topic
kafka-topics.sh --create --topic my-topic --bootstrap-server localhost:9093 --partitions 1 --replication-factor 1

# List topics
kafka-topics.sh --list --bootstrap-server localhost:9093

# Produce messages
kafka-console-producer.sh --topic my-topic --bootstrap-server localhost:9093

# Consume messages (in another terminal)
kafka-console-consumer.sh --topic my-topic --from-beginning --bootstrap-server localhost:9093
```

> **📝 Note:** Use port `9093` inside the container, `9092` from your host machine.

---

### 🌊 9. Accessing Flume

```bash
# Enter the Flume container
docker exec -it flume bash
```

```bash
# Flume is typically configured via agent configuration files
# Example: Start an agent with a specific config
flume-ng agent --conf conf --conf-file /path/to/flume.conf --name agent1 -Dflume.root.logger=INFO,console
```

> **📝 Note:** Flume requires configuration files for sources, channels, and sinks. Mount your config files when starting the container.

---

### 📅 10. Accessing Oozie

```bash
# Enter the Oozie container
docker exec -it oozie bash
```

```bash
# Check Oozie status
oozie admin -status

# Submit a workflow
oozie job -oozie http://localhost:11000/oozie -config job.properties -run

# Check job status
oozie job -oozie http://localhost:11000/oozie -info <job-id>
```

```bash
# Access Oozie Web UI
# Navigate to http://localhost:11000/oozie
```

> **📝 Note:** Oozie requires workflow definitions (XML) and job properties files.

---

### 🎨 11. Accessing Hue

```bash
# Access Hue Web UI
# Navigate to http://localhost:8888
# Create admin account on first login
```

Hue provides a web interface for:

- 📁 HDFS file browser
- 🐝 Hive query editor
- 📊 HBase browser
- 📅 Oozie workflow editor
- 📨 Kafka topics viewer

> **📝 Note:** Configure Hue to connect to your Hadoop services via environment variables.

---

### 🔄 12. Accessing Sqoop

```bash
# Enter the Sqoop container
docker exec -it sqoop bash
```

```bash
# Import data from MySQL to HDFS
sqoop import \
  --connect jdbc:mysql://mysql-host:3306/database \
  --username user --password pass \
  --table tablename \
  --target-dir /user/sqoop/tablename

# Export data from HDFS to MySQL
sqoop export \
  --connect jdbc:mysql://mysql-host:3306/database \
  --username user --password pass \
  --table tablename \
  --export-dir /user/sqoop/tablename

# List databases
sqoop list-databases --connect jdbc:mysql://mysql-host:3306/ --username user --password pass
```

> **📝 Note:** Sqoop requires JDBC drivers for the target database. Ensure Hadoop is running for HDFS operations.

---

## 📝 Configuration Notes

### 🔗 Service Dependencies

```
┌─────────────────────────────────────────────────────────────┐
│                    SERVICE DEPENDENCY MAP                   │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌───────────┐         ┌───────────┐                        │
│  │  Hadoop   │◄────────│   Spark   │                        │
│  │  (HDFS)   │         └───────────┘                        │
│  └─────┬─────┘                                              │
│        │               ┌───────────┐                        │
│        ├───────────────│   Hive    │                        │
│        │               └───────────┘                        │
│        │                                                    │
│        │  ┌───────────┐                                     │
│        └──│   HBase   │◄────┐                               │
│           └───────────┘     │                               │
│                             │                               │
│           ┌───────────┐     │                               │
│           │ Zookeeper │─────┘                               │
│           └───────────┘                                     │
│                                                             │
│  ┌───────────┐                                              │
│  │ Cassandra │  (Standalone - no dependencies)              │
│  └───────────┘                                              │
│                                                             │
│  ┌───────────┐                                              │
│  │   Neo4j   │  (Standalone - no dependencies)              │
│  └───────────┘                                              │
│                                                             │
│  ┌───────────┐         ┌───────────┐                        │
│  │ Zookeeper │◄────────│   Kafka   │                        │
│  └───────────┘         └───────────┘                        │
│                                                             │
│  ┌───────────┐         ┌───────────┐                        │
│  │  Hadoop   │◄────────│    Pig    │                        │
│  │  (HDFS)   │         └───────────┘                        │
│  └───────────┘                                              │
│                                                             │
│  ┌───────────┐         ┌───────────┐                        │
│  │  Hadoop   │◄────────│   Flume   │                        │
│  │  (HDFS)   │         └───────────┘                        │
│  └───────────┘                                              │
│                                                             │
│  ┌───────────┐         ┌───────────┐                        │
│  │  Hadoop   │◄────────│   Oozie   │                        │
│  │  (HDFS)   │         └───────────┘                        │
│  └───────────┘                                              │
│                                                             │
│  ┌───────────┐         ┌───────────┐                        │
│  │  Hadoop   │◄────────│    Hue    │                        │
│  │  (HDFS)   │         └───────────┘                        │
│  └───────────┘                                              │
│                                                             │
│  ┌───────────┐         ┌───────────┐                        │
│  │  Hadoop   │◄────────│   Sqoop   │ ────────► RDBMS        │
│  │  (HDFS)   │         └───────────┘                        │
│  └───────────┘                                              │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### 📊 Start Order by Use Case

| Use Case               | Start Order                      |
| :--------------------- | :------------------------------- |
| 🔥 **Spark Jobs**      | `hadoop` → `spark`               |
| 🐝 **Hive Queries**    | `hadoop` → `hive`                |
| 📊 **HBase Tables**    | `hadoop` → `zookeeper` → `hbase` |
| 🔵 **Cassandra**       | `cassandra` (standalone)         |
| 🕸️ **Neo4j Graphs**    | `neo4j` (standalone)             |
| 📨 **Kafka Streams**   | `zookeeper` → `kafka`            |
| 🐷 **Pig Scripts**     | `hadoop` → `pig`                 |
| 🌊 **Flume Ingestion** | `hadoop` → `flume`               |
| 📅 **Oozie Workflows** | `hadoop` → `oozie`               |
| 🎨 **Hue Web UI**      | `hadoop` → `hue`                 |
| 🔄 **Sqoop Transfer**  | `hadoop` → `sqoop`               |
| 🌐 **Full Stack**      | Root `docker-compose.yml`        |

### 🔗 Integration Details

| Component |           Storage Backend           |      Coordination      |
| :-------: | :---------------------------------: | :--------------------: |
|   HBase   | HDFS (`hdfs://namenode:9000/hbase`) |       Zookeeper        |
|   Hive    |    HDFS (`hdfs://namenode:9000`)    | PostgreSQL (Metastore) |
|   Spark   |    HDFS (`hdfs://namenode:9000`)    |       Standalone       |

### 🌐 Networking

All services share the `bigdata-net` Docker bridge network. The network is created by the first service you start (Hadoop or Cassandra).

### 💾 Persistence

|  Service  |        Volume        | Purpose                |
| :-------: | :------------------: | :--------------------- |
|  Hadoop   |   `namenode_data`    | HDFS NameNode metadata |
|  Hadoop   |   `datanode_data`    | HDFS DataNode blocks   |
| Zookeeper |   `zookeeper_data`   | ZK transaction logs    |
|   Hive    | `hive_postgres_data` | Metastore database     |
| Cassandra |   `cassandra_data`   | Cassandra data files   |
|   Neo4j   |     `neo4j_data`     | Graph database files   |
|    Pig    |    `pig_scripts`     | Pig Latin scripts      |

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
- 📖 [Neo4j Documentation](https://neo4j.com/docs/)
- 📖 [Apache Kafka Documentation](https://kafka.apache.org/documentation/)
- 📖 [Apache Pig Documentation](https://pig.apache.org/docs/latest/)
- 📖 [Apache Flume Documentation](https://flume.apache.org/documentation.html)
- 📖 [Apache Oozie Documentation](https://oozie.apache.org/docs/)
- 📖 [Hue Documentation](https://docs.gethue.com/)
- 📖 [Apache Sqoop Documentation](https://sqoop.apache.org/docs/)

---

<p align="center">
  <sub>Made with ❤️ for Big Data enthusiasts</sub>
</p>
