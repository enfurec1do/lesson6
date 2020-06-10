
FROM ubuntu:18.04

RUN apt update && apt install -y \
    maven \
    git \
    default-jdk \
    wget

WORKDIR /usr/local/tomcat/

RUN wget http://mirror.linux-ia64.org/apache/tomcat/tomcat-8/v8.5.56/bin/apache-tomcat-8.5.56.tar.gz -O tomcat.tar.gz

RUN tar xvfz tomcat.tar.gz && mv apache-tomcat-8.5.56/* /usr/local/tomcat/

WORKDIR git

RUN git clone https://github.com/ewolff/user-registration-V2.git && cd user-registration-V2 && ./mvnw -pl user-registration-application -am insta$

RUN cp ./user-registration-V2/user-registration-application/target/user-registration-application-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]