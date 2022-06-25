FROM python:3.9.8-slim

ENV PYTHONUNBUFFERED 1 
EXPOSE 8000
WORKDIR /app

COPY ./requirements.txt .
COPY ./src ./src
COPY ./models ./models

RUN pip install -r requirements.txt

WORKDIR /app/src
CMD ["uvicorn", "main:app", "--port", "8000", "--host", "0.0.0.0"]