
FROM ubuntu:18.04

# Tomcat Version
ENV TOMCAT_VERSION_MAJOR 8
ENV TOMCAT_VERSION_FULL  8.5.56

RUN apt update && apt install -y \
    maven \
    git \
    default-jdk \
    wget

WORKDIR /usr/local/tomcat/

RUN wget http://mirror.linux-ia64.org/apache/tomcat/tomcat-${TOMCAT_VERSION_MAJOR}/v${TOMCAT_VERSION_FULL}/bin/apache-tomcat-${TOMCAT_VERSION_FULL}.tar.gz -O tomcat.tar.gz

RUN tar xvfz tomcat.tar.gz && mv apache-tomcat-{TOMCAT_VERSION_FULL}/* /usr/local/tomcat/

WORKDIR git

RUN git clone https://github.com/ewolff/user-registration-V2.git && cd user-registration-V2 && ./mvnw -pl user-registration-application -am install

RUN cp ./user-registration-V2/user-registration-application/target/user-registration-application-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]