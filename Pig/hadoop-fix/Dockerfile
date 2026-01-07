FROM apache/hadoop:3.3.6

# Stay as root to allow permission fixing at runtime
USER root

# Installer Python 3 (nécessaire pour Hadoop Streaming)
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-* && \
    yum clean all && \
    yum update -y && \
    yum install -y wget which python3

# =============================================================================
RUN wget -q https://archive.apache.org/dist/pig/pig-0.17.0/pig-0.17.0.tar.gz && \
    tar -xzf pig-0.17.0.tar.gz -C /opt && \
    mv /opt/pig-0.17.0 /opt/pig && \
    rm pig-0.17.0.tar.gz && \
    chown -R hadoop:users /opt/pig

# Set Pig Environment Variables
ENV PIG_HOME=/opt/pig
ENV PATH=$PIG_HOME/bin:$PATH
ENV PIG_CLASSPATH=/opt/hadoop/etc/hadoop
# =============================================================================

# 1. Install the entrypoint script
COPY entrypoint.sh /usr/local/bin/custom-entrypoint.sh
RUN chmod +x /usr/local/bin/custom-entrypoint.sh

# 2. Ensure config directory is writable (for our python hack)
RUN chown -R hadoop:users /opt/hadoop/etc/hadoop

# 3. Create the data directories explicitly
RUN mkdir -p /hadoop/dfs/name /hadoop/dfs/data

# NOTE: We do NOT switch to 'USER hadoop' here.
# We let entrypoint.sh handle the user switching.

ENTRYPOINT ["/usr/local/bin/custom-entrypoint.sh"]