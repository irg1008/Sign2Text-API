# Server for delivery of onnx model to frontend

Made with fastapi as an alternative to a jsvascript-made backend using onnx.js
This is because onnx.js is not as reliable as using python based libraries.
The client will send a video and the server will process it and send the target back.

---

## Run the backend server

> For development

`uvicorn main:app --reload --port 8000` or `python dev.py`

> For production

`uvicorn main:app --port 8000` or `python run.py`

## Tools used for testing

[Insomnia](https://insomnia.rest/download)

## Run locally on docker

1. Build the image with `docker build -t sign2text:latest .`

2. Run it with `docker run -p 8000:8000 sign2text:latest`

3. Open the browser and go to `http://localhost:8000`

## Where is it hosted?

This FastAPI container is hosted on Azure and is available at the following link: <https://api.sign2text.com/docs>
