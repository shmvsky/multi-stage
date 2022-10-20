FROM openjdk:17-alpine as build

WORKDIR /app

COPY . .

RUN ./gradlew clean bootJar --no-daemon

FROM openjdk:17-alpine

WORKDIR /app

COPY --from=build /app/build/libs/multi-build-0.0.1-SNAPSHOT.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]