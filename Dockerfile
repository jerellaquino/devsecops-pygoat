FROM python:3.11.0b1-buster

WORKDIR /app

# dependencies for psycopg2
RUN apt-get update && apt-get install --no-install-recommends -y dnsutils libpq-dev python3-dev \

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

RUN python -m pip install --no-cache-dir pip==22.0.4

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . /app/

EXPOSE 8000

RUN python3 manage.py migrate

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "--workers", "6", "pygoat.wsgi"]
