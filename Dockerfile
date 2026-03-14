FROM python:3.11-slim

WORKDIR /app

RUN apt-get update && apt-get install --no-install-recommends -y \
    dnsutils \
    libpq-dev \
    python3-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

RUN python -m pip install --no-cache-dir pip==22.0.4

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
