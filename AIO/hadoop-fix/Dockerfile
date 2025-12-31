FROM apache/hadoop:3.3.6

# Stay as root to allow permission fixing at runtime
USER root

# Installer Python 3 (nécessaire pour Hadoop Streaming)
RUN yum update -y && yum install -y python3

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