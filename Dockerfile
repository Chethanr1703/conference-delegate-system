FROM maven:3.9.9-eclipse-temurin-17 AS build

WORKDIR /app
COPY . .
RUN mvn clean package


FROM tomcat:9-jdk17

COPY --from=build /app/target/conference-delegate-system.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]