FROM microbox/jdk

ENV LANG="en_US.UTF-8" \
    LANGUAGE="en_US.UTF-8" \
    LC_COLLATE="C" \
    LC_CTYPE="en_US.UTF-8"

# TeamCity Version
ENV TEAMCITY_VERSION 9.1.7
RUN curl -jksSL https://download.jetbrains.com/teamcity/TeamCity-${TEAMCITY_VERSION}.tar.gz \
    | tar -xzf - -C /usr/share

# Update dependencies
RUN yum groupinstall -y 'Development Tools' && \
    yum install -y git && \
    yum clean all

ENV TEAMCITY_HOME="/usr/share/TeamCity" \
    TEAMCITY_DATA_PATH="/data" \
    JAVA_OPTS="-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom" \
    CATALINA_HOME="/usr/share/TeamCity" \
    CATALINA_BASE="/usr/share/TeamCity" \
    CATALINA_OPTS="-server -XX:+UseParallelGC"

WORKDIR /usr/share/TeamCity

EXPOSE 8111

CMD ["./bin/catalina.sh", "run"]