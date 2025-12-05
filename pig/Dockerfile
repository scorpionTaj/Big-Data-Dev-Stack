FROM eclipse-temurin:8-jdk

# Environment variables
ENV HADOOP_VERSION=3.2.1
ENV PIG_VERSION=0.17.0
ENV HADOOP_HOME=/opt/hadoop
ENV PIG_HOME=/opt/pig
ENV PATH=$PATH:$HADOOP_HOME/bin:$PIG_HOME/bin

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Download and install Hadoop (client libraries only)
RUN wget -q https://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz \
    && tar -xzf hadoop-${HADOOP_VERSION}.tar.gz \
    && mv hadoop-${HADOOP_VERSION} ${HADOOP_HOME} \
    && rm hadoop-${HADOOP_VERSION}.tar.gz

# Download and install Pig
RUN wget -q https://archive.apache.org/dist/pig/pig-${PIG_VERSION}/pig-${PIG_VERSION}.tar.gz \
    && tar -xzf pig-${PIG_VERSION}.tar.gz \
    && mv pig-${PIG_VERSION} ${PIG_HOME} \
    && rm pig-${PIG_VERSION}.tar.gz

# Create scripts directory
RUN mkdir -p /pig/scripts

# Set working directory
WORKDIR /pig/scripts

# Default command - keep container running
CMD ["tail", "-f", "/dev/null"]
