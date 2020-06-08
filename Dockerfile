FROM ubuntu:16.04

RUN apt update && apt install -y \
    maven \
    git \
	default-jdk\
	tomcat8

WORKDIR git

RUN git clone https://github.com/ewolff/user-registration-V2.git && cd user-registration-V2 && ./mvnw -pl user-registration-application -am install

RUN cp ./user-registration-V2/user-registration-application/target/user-registration-application-0.0.1-SNAPSHOT.war /var/lib/tomcat8/webapps/ && service tomcat8 restart

EXPOSE 8080
