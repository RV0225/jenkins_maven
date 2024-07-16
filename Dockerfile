# Use Maven image to build the application
FROM maven:3.8.4-openjdk-11 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package

# Use a lighter image to run the application
FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=build /app/target/my-app-1.0-SNAPSHOT.jar ./my-app.jar
ENTRYPOINT ["java", "-jar", "my-app.jar"]
