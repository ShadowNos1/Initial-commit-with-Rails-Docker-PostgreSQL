# Rails API для управления пациентами

Проект реализует backend-приложение на **Ruby on Rails** с Docker и PostgreSQL для управления пациентами и врачами. Поддерживает расчёт BMR и BMI, фильтрацию и пагинацию.

## Функционал
- CRUD для пациентов и врачей
- Привязка пациентов к нескольким врачам
- Получение списка пациентов с фильтрацией по имени, полу и возрасту
- Расчёт BMR (формулы Миффлина–Сан Жеора и Харриса–Бенедикта)
- Хранение истории расчётов BMR
- Расчёт BMI через внешний API
- Контейнеризация через Docker Compose

## Технологии
- Ruby 3.2.x, Rails 7.1
- PostgreSQL
- Docker, Docker Compose
- Faraday (HTTP-клиент для BMI API)
- Kaminari (пагинация)

## Установка и запуск

1. Склонировать репозиторий:
```bash
git clone https://github.com/ShadowNos1/Initial-commit-with-Rails-Docker-PostgreSQL.git
cd Initial-commit-with-Rails-Docker-PostgreSQL
