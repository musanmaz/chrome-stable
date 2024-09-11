FROM ubuntu

# Set JAVA_HOME for Java 11
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

USER root

# Install Java 11 and Maven
RUN set -xe \
    && apt-get update \
    && apt-get install -y --no-install-recommends openjdk-11-jdk maven

# Install git, wget, unzip
RUN set -xe \
    && apt-get update \
    && apt-get install -y git wget unzip

RUN set -xe \
    && apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates curl socat gnupg gnupg2 gnupg1 \
    && apt-get install -y --no-install-recommends xvfb x11vnc fluxbox xterm \
    && apt-get install -y --no-install-recommends sudo \
    && apt-get install -y --no-install-recommends supervisor \
    && rm -rf /var/lib/apt/lists/*

# Install Google Chrome
RUN set -xe \
    && curl -fsSL https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update \
    && apt-get install -y google-chrome-stable 

# Copy the supervisor configuration and entry script
COPY supervisord.conf /etc/
COPY entry.sh /

CMD ["/entry.sh"]
