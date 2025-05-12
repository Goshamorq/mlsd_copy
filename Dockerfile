# Базовый образ Python 3.10
FROM python:3.10-slim

# Рабочая директория внутри контейнера
WORKDIR /app

# Установка Poetry (менеджер зависимостей)
RUN pip install poetry

# Копируем ТОЛЬКО файлы зависимостей из корня проекта
COPY pyproject.toml poetry.lock ./

# Устанавливаем зависимости в системный Python
# --no-root = не устанавливаем текущий проект как пакет
RUN poetry config virtualenvs.create false && \
    poetry install --no-root --no-interaction --no-ansi

# Копируем ВЕСЬ проект (включая app_src)
COPY . .

# Переходим в директорию с исходным кодом
WORKDIR /app/app_src

# Объявляем порт для Streamlit (информационно)
EXPOSE 8501