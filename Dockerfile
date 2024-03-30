# syntax=docker/dockerfile:1
FROM amazoncorretto:17 AS build

WORKDIR /app

COPY pom.xml mvnw ./
COPY .mvn .mvn
COPY src ./src

RUN chmod +x ./mvnw
RUN ./mvnw clean package -DskipTests

FROM amazoncorretto:17

EXPOSE 8080

ARG JAR_FILE=/app/target/*.jar

COPY --from=build ${JAR_FILE} app.jar

ENTRYPOINT ["java","-jar","/app.jar"]