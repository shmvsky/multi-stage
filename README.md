# Docker. Multi-stage build example

Этот репозиторий служит примером многоэтапной сборки в Docker

## Этап сборки

``` Dockerfile
FROM openjdk:17-alpine as build

WORKDIR /app

COPY . .

RUN ./gradlew clean bootJar --no-daemon
```
Здесь мы копируем проект в контейнер и оформляем сборочку с помощью gradle wrapper

## Этап запуска приложения

``` Dockerfile
FROM openjdk:17-alpine

WORKDIR /app

COPY --from=build /app/build/libs/multi-build-0.0.1-SNAPSHOT.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]
```
Копируем архив с предыдущего этапа и запускаем его

## Как запустить

Создаем контейнер базы данных
``` bash 
docker run --name db -e POSTGRES_DB=db postgres
```

Создаем сеть, через которую бд и приложение будут общаться
``` bash 
docker network create app-db
```

Коннектим бд к сети
``` bash
docker network connect app-db db
```

Собираем изображение
``` bash 
docker build -t app:1.0 .
```

Запускаем
``` bash 
docker run --name app -p 8080:8080 --network app-db app:1.0
```
