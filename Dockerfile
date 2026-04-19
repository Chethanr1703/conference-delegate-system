FROM openjdk:17-jdk-slim

WORKDIR /app

COPY . .

RUN apt-get update && apt-get install -y maven

RUN mvn clean package

EXPOSE 8080

CMD ["java", "-cp", "target/conference-delegate-system.war", "com.xworkz.confManage.MainApp"]