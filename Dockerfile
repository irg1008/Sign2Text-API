FROM tiangolo/uvicorn-gunicorn-fastapi:python3.9
WORKDIR /src
COPY . /src
RUN pip install -r requirements.txt
RUN pip install torch==1.10.2+cu113 torchvision==0.11.3+cu113 torchaudio===0.10.2+cu113 -f https://download.pytorch.org/whl/cu113/torch_stable.html
EXPOSE 8000
CMD ["python", "src/run.py"]