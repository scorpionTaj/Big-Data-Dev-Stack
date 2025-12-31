#!/bin/bash

# 1. Clean environment
unset LS_COLORS
unset KV
unset FISH_VERSION

# 2. [FIX] REPAIR VOLUME PERMISSIONS
echo "Fixing permissions for /hadoop/dfs..."
chown -R hadoop:users /hadoop/dfs

# 3. Generate Configs (Ignore errors)
/opt/envtoconf.py --destination /opt/hadoop/etc/hadoop || true

# -----------------------------------------------------------------------------
# MANUAL CONFIGURATION OVERRIDES (Brute Force Fix)
# -----------------------------------------------------------------------------

# 4. Write core-site.xml (Connects to NameNode)
echo '<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://namenode:9000</value>
    </property>
</configuration>' > /opt/hadoop/etc/hadoop/core-site.xml

# 5. Write hdfs-site.xml (Storage Paths)
echo '<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
    <property>
        <name>dfs.namenode.name.dir</name>
        <value>file:///hadoop/dfs/name</value>
    </property>
    <property>
        <name>dfs.datanode.data.dir</name>
        <value>file:///hadoop/dfs/data</value>
    </property>
    <property>
        <name>dfs.replication</name>
        <value>1</value>
    </property>
</configuration>' > /opt/hadoop/etc/hadoop/hdfs-site.xml

# 6. [NEW] Write yarn-site.xml (Connects NodeManager -> ResourceManager)
echo '<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
    <property>
        <name>yarn.resourcemanager.hostname</name>
        <value>resourcemanager</value>
    </property>
    <property>
        <name>yarn.resourcemanager.bind-host</name>
        <value>0.0.0.0</value>
    </property>
    <property>
        <name>yarn.resourcemanager.webapp.address</name>
        <value>0.0.0.0:8088</value>
    </property>
    <property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
    </property>
    <property>
        <name>yarn.nodemanager.env-whitelist</name>
        <value>JAVA_HOME,HADOOP_COMMON_HOME,HADOOP_HDFS_HOME,HADOOP_CONF_DIR,CLASSPATH_PREPEND_DISTCACHE,HADOOP_YARN_HOME,HADOOP_MAPRED_HOME</value>
    </property>
</configuration>' > /opt/hadoop/etc/hadoop/yarn-site.xml

# 7. [NEW] Write mapred-site.xml (Tells Hadoop to use YARN)
echo '<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
    <property>
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
    </property>
    <property>
        <name>mapreduce.application.classpath</name>
        <value>$HADOOP_MAPRED_HOME/share/hadoop/mapreduce/*:$HADOOP_MAPRED_HOME/share/hadoop/mapreduce/lib/*</value>
    </property>
</configuration>' > /opt/hadoop/etc/hadoop/mapred-site.xml

# -----------------------------------------------------------------------------

# 8. Format NameNode (Run as user 'hadoop')
if [[ "$1" == "hdfs" && "$2" == "namenode" ]]; then
    if [ ! -d "/hadoop/dfs/name/current" ]; then
        echo "Formatting NameNode..."
        su hadoop -c "/opt/hadoop/bin/hdfs namenode -format -force"
    fi
fi

# 9. Start the Service (Switch from root -> hadoop)
echo "Starting service as user hadoop..."
exec su hadoop -c "exec $*"