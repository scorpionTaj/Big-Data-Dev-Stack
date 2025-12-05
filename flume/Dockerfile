FROM bde2020/hadoop-base:2.0.0-hadoop3.2.1-java8

# Fix Debian Stretch Repos
RUN echo "deb http://archive.debian.org/debian stretch main" > /etc/apt/sources.list \
    && echo "deb http://archive.debian.org/debian-security stretch/updates main" >> /etc/apt/sources.list \
    && apt-get -o Acquire::Check-Valid-Until=false update

# Install Flume
RUN apt-get install -y flume

ENV FLUME_HOME=/usr/lib/flume
ENV PATH=$PATH:$FLUME_HOME/bin

# Default command: just start a dummy agent or tail
CMD ["/bin/bash", "-c", "tail -f /dev/null"]