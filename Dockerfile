# Install FROM AMAZON LINUX 2
FROM adawar/amzlnx_ojdk7_tc7105_v1:latest

#Author of the Docker File
LABEL "Maintainer"="adawar"

# RUN COMMAND BASICALLY runs the command in the terminal and creates an image.


ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $PATH:$CATALINA_HOME/bin

#ADD JAVA_OPTS parameters from CM
#ENV JAVA_OPTS="-Xms1024m -Xmx1024m -Xss8192k -XX:PermSize=500m -XX:CMSInitiatingOccupancyFraction=50 -XX:+ExplicitGCInvokesConcurrent -XX:+CMSClassUnloadingEnabled -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:NewRatio=1 -XX:SurvivorRatio=1  -Dorg.apache.cxf.JDKBugHacks.imageIO=false"

EXPOSE 8080
#EXPOSE 8009

# Need a war file from the host to be mounted you can do so here. This instruction tells docker that content in those directories does not go in images and 
# can be accessed from other containers using the --volumes-from command line parameter. You have to run the container using -v 
#/path/on/host:/path/in/container to access directories from the host.
VOLUME "/usr/local/tomcat/webapps"
#VOLUME "/usr/local/tomcat/logs"

#The WORKDIR instruction sets the working directory for any RUN, CMD, ENTRYPOINT, COPY and ADD instructions that follow it in the Dockerfile.
WORKDIR /usr/local/tomcat

# Launch Tomcat
CMD /usr/local/tomcat/bin/catalina.sh run

#use this command
## docker run -itd -p 8080:8080 -v <path_of_bridge_war_on_machine>:/usr/local/tomcat/webapps -v <path_of_integration_war_on_machine>:/usr/local/tomcat/webapps --name=<container-name> <image-id>