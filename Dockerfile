# we are extending everything from tomcat:8.0 image ...
FROM tomcat:8.0
MAINTAINER Anil Pemmaraju
# COPY path-to-your-application-war path-to-webapps-in-docker-tomcat
COPY target/petclinic.war /usr/local/tomcat/webapps/
