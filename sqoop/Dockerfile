FROM bde2020/hadoop-base:2.0.0-hadoop3.2.1-java8

# Fix Debian Stretch Repos
RUN echo "deb http://archive.debian.org/debian stretch main" > /etc/apt/sources.list \
    && echo "deb http://archive.debian.org/debian-security stretch/updates main" >> /etc/apt/sources.list \
    && apt-get -o Acquire::Check-Valid-Until=false update

# Install Sqoop & Postgres Driver
RUN apt-get install -y wget sqoop libpostgresql-jdbc-java \
    && ln -s /usr/share/java/postgresql-jdbc4.jar /usr/lib/sqoop/lib/postgresql-jdbc4.jar

ENV SQOOP_HOME=/usr/lib/sqoop
ENV PATH=$PATH:$SQOOP_HOME/bin
ENV HADOOP_CONF_DIR=/opt/hadoop/etc/hadoop

CMD ["/bin/bash", "-c", "tail -f /dev/null"]