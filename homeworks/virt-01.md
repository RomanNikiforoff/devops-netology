# Домашнее задание к занятию "1. Введение в виртуализацию. Типы и функции гипервизоров. Обзор рынка вендоров и областей применения."
---

## Задача 1

Опишите кратко, как вы поняли: в чем основное отличие полной (аппаратной) виртуализации, паравиртуализации и виртуализации на основе ОС.

Основные различия заключаются в:
* вариантах использования аппаратных ресурсов сервера;
* наличии хостовой ОС;
* "справедливым" распределением ресурсов;
* отказоустойчивостью;
* вариантами установки гостевых ОС

## Задача 2

Выберите один из вариантов использования организации физических серверов, в зависимости от условий использования.

Организация серверов:
- физические сервера,
- паравиртуализация,
- виртуализация уровня ОС.

Условия использования:
- Высоконагруженная база данных, чувствительная к отказу. - *кластер БД, физические сервера.*

- Различные web-приложения. -*паравиртуализация (зачастую приложения имеют микросервисную архитектуру, включающую в себя множество компонентов БД, кеш, фронт, вэбсокеты, сбор и обработка логов, мониторинг.) Если приложение совсем маленькое можно использовать виртуализацию уровня ОС*

- Windows системы для использования бухгалтерским отделом.  - *паравиртуализация.*

- Системы, выполняющие высокопроизводительные расчеты на GPU. - *физические сервера, иногда паравиртуализация (обычно показывает худшие результаты, чем физические серверы)*

Опишите, почему вы выбрали к каждому целевому использованию такую организацию.

## Задача 3

Выберите подходящую систему управления виртуализацией для предложенного сценария. Детально опишите ваш выбор.

Сценарии:

1. 100 виртуальных машин на базе Linux и Windows, общие задачи, нет особых требований. Преимущественно Windows based инфраструктура, требуется реализация программных балансировщиков нагрузки, репликации данных и автоматизированного механизма создания резервных копий.

   *Hyper-V или WM-Ware имеют хорошие встроенные инструменты бэкапа.*

3. Требуется наиболее производительное бесплатное open source решение для виртуализации небольшой (20-30 серверов) инфраструктуры на базе Linux и Windows виртуальных машин.

   *KVM наиболее универсален и подойдет для данного кейса.*

4. Необходимо бесплатное, максимально совместимое и производительное решение для виртуализации Windows инфраструктуры.

   *KVM или Xen бесплатно.*

5. Необходимо рабочее окружение для тестирования программного продукта на нескольких дистрибутивах Linux.

   *тут можно использовать продукты виртуализации уровня ОС (Virtual-box, etc)*

## Задача 4

Опишите возможные проблемы и недостатки гетерогенной среды виртуализации (использования нескольких систем управления виртуализацией одновременно) и что необходимо сделать для минимизации этих рисков и проблем. Если бы у вас был выбор, то создавали бы вы гетерогенную среду или нет? Мотивируйте ваш ответ примерами.

Гетерогенная среда:
* увеличивает накладные расходы на содержание инфраструктуры
* увеличивает требования к персоналу
* увеличения объема документации и инструкций
* плохо автоматизируется и стандартизируется
* предполагает дополнительную инфраструктуру взаимодействия разных моделей между собой (не обязательно).
* проблемы с масштабированием.
 
 Гетерогенная среда имеет место быть при полной независимости систем и невозможности использовать, что то универсальное.