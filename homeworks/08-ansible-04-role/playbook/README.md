# Описание playbook site.yml

## Основное

Playbook выполняет установку и первоначальную конфигурацию:
1. Clickhouse
2. Vector
3. Lighthouse

Установка выполняется на разные хосты, перечисленные в [prod.yml](inventory/prod.yml)

Требования к хостам: RPM-based Linux distribution

## Установка Vector (role vector-role)

в файле [roles\vector-role\defaults\main.yml](roles\vector-role\defaults\main.yml) задается:
1. версия (vector_version)

в файле [roles\vector-role\vars\main.yml](roles\vector-role\vars\main.yml) задается:

1. директория установки (vector_path)
2. директория хранения данных (vector_data_path)
3. конфигурационный файл (vector_config)

Описание tasks:
* Create directory - создание директории установки
* Get distr - скачивание дистрибутива
* Unarchive files - распаковка файлов
* Create a symlink - создание ссылки на директорию установки
* Create init file - создание init файла из [шаблона](templates/vector.service.j2)
* creating directory for vector data - создание директории для данных
* Creating config for Vector - создание config файла из [шаблона](templates/vector.toml.j2)
* Creating service for vector - разрешение и запуск сервиса vector

## Установка Lighthouse (role lighthouse-role)

в файле [\roles\lighthouse-role\vars\main.yml](roles\lighthouse-role\vars\main.yml) задается:

nginx:

1. Путь для файла репозитория.
2. Путь ко корневой директории.
3. Путь до конфига по умолчанию.

lighthouse:

1. Директорию для дистрибутива.
2. Путь для архива с дистрибутивом.
3. ссылка на дистрибутив.

Описание tasks:

lighthouse:
* Create directory lighthouse - создание директории
* Get lighthouse distrib - скачивание дистрибутива
* Unarchive lighthouse - распаковка файлов
* Apply nginx config - применение конфига и рестарт nginx

nginx:

* Add repo nginx - добавление репозитория
* Install nginx - установка
* Configuring service nginx - создание сервиса

## Для развертывания окружения использован [terraform](../terraform/)