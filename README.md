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
docker run --name mb-database -e POSTGRES_DB=db postgres
```

Создаем сеть, через которую бд и приложение будут общаться
``` bash 
docker network create mb-network
```

Коннектим бд к сети
``` bash
docker network connect mb-network mb-database
```

Собираем изображение приложения
``` bash 
docker build -t mb-app:1.0 .
```

Запускаем приложение
``` bash 
docker run --name bm-app -p 8080:8080 --network mb-network mb-app:1.0
```
