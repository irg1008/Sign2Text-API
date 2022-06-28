FROM python:3.9.8-slim

ENV PYTHONUNBUFFERED 1 
EXPOSE 8000
WORKDIR /app

COPY ./requirements.txt .
COPY ./src ./src

RUN pip install -r requirements.txt

# Get model from Google Drive. Chaneg this in the future for better caching and deploy times.
RUN gdown --folder "1vFjybFCG3-OAX0vZkhU7Ob7im0zkA0Tf" -O ./models 

WORKDIR /app/src
CMD ["uvicorn", "main:app", "--port", "8000", "--host", "0.0.0.0"]