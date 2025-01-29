# Этап сборки
FROM python:3.12-slim-bullseye AS builder

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3-dev \
    gcc \
    musl-dev && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip && \
    pip install poetry

COPY pyproject.toml poetry.lock* ./

RUN poetry config virtualenvs.create false && \
    poetry install --no-root --no-interaction --no-ansi --only main

# Этап выполнения
FROM python:3.12-slim-bullseye

WORKDIR /app

COPY --from=builder /usr/local/lib/python3.12/site-packages /usr/local/lib/python3.12/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin

COPY . .