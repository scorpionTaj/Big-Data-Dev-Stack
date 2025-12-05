FROM bde2020/hadoop-base:2.0.0-hadoop3.2.1-java8

RUN echo "deb http://archive.debian.org/debian stretch main" > /etc/apt/sources.list \
    && echo "deb http://archive.debian.org/debian-security stretch/updates main" >> /etc/apt/sources.list \
    && apt-get -o Acquire::Check-Valid-Until=false update \
    && apt-get -o Acquire::Check-Valid-Until=false install -y wget \
    && wget --no-check-certificate https://archive.apache.org/dist/pig/pig-0.17.0/pig-0.17.0.tar.gz \
    && tar -xzf pig-0.17.0.tar.gz -C /opt \
    && mv /opt/pig-0.17.0 /opt/pig \
    && rm pig-0.17.0.tar.gz \
    && mkdir -p /pig/scripts

# Metadata
ENV PIG_HOME=/opt/pig
ENV PATH=$PATH:$PIG_HOME/bin

WORKDIR /pig/scripts

# Keep container running
CMD ["/bin/bash", "-c", "tail -f /dev/null"]