FROM python:3.9.8-slim

ENV PYTHONUNBUFFERED 1 
EXPOSE 8000
WORKDIR /app

COPY ./requirements.txt .
COPY ./src ./src
COPY ./models ./models

RUN pip install -r requirements.txt

CMD ["python", "src/run.py"]