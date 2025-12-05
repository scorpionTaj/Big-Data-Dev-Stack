FROM bde2020/hadoop-base:2.0.0-hadoop3.2.1-java8

# -----------------------------------------------------------------------------
# 1. FIX REPOS (Debian Stretch EOL)
# -----------------------------------------------------------------------------
RUN echo "deb http://archive.debian.org/debian stretch main" > /etc/apt/sources.list \
    && echo "deb http://archive.debian.org/debian-security stretch/updates main" >> /etc/apt/sources.list \
    && apt-get -o Acquire::Check-Valid-Until=false update

# -----------------------------------------------------------------------------
# 2. INSTALL TOOLS (Wget, Sqoop, Flume, JDBC)
# -----------------------------------------------------------------------------
RUN apt-get -o Acquire::Check-Valid-Until=false install -y \
    wget \
    sqoop \
    flume \
    libpostgresql-jdbc-java \
    && ln -s /usr/share/java/postgresql-jdbc4.jar /usr/lib/sqoop/lib/postgresql-jdbc4.jar

# -----------------------------------------------------------------------------
# 3. INSTALL PIG (Manual Download)
# -----------------------------------------------------------------------------
ENV PIG_VERSION=0.17.0
RUN wget --no-check-certificate https://archive.apache.org/dist/pig/pig-${PIG_VERSION}/pig-${PIG_VERSION}.tar.gz \
    && tar -xzf pig-${PIG_VERSION}.tar.gz -C /opt \
    && mv /opt/pig-${PIG_VERSION} /opt/pig \
    && rm pig-${PIG_VERSION}.tar.gz \
    && mkdir -p /pig/scripts

# -----------------------------------------------------------------------------
# 4. ENV VARIABLES
# -----------------------------------------------------------------------------
ENV PIG_HOME=/opt/pig
ENV SQOOP_HOME=/usr/lib/sqoop
ENV FLUME_HOME=/usr/lib/flume
ENV PATH=$PATH:$PIG_HOME/bin:$SQOOP_HOME/bin:$FLUME_HOME/bin
ENV HADOOP_CONF_DIR=/opt/hadoop/etc/hadoop

# Default configs for clients
ENV CORE_CONF_fs_defaultFS=hdfs://namenode:9000
ENV YARN_CONF_yarn_resourcemanager_hostname=resourcemanager
ENV MAPRED_CONF_mapreduce_framework_name=yarn

WORKDIR /pig/scripts

# Keep container running
CMD ["/bin/bash", "-c", "tail -f /dev/null"]