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

## Run locally on docker

1. Build the image with `docker build -t sign2text .`
2. Run it with `docker run -p 8000:8000 sign2text`
3. Open the browser and go to `http://localhost:8000`

## Upload the container to azure

1. Log in: `docker login sign2textapi.azurecr.io` Ver claves en Sign2TextAPI > Azure Container Registry > Claves de Acceso
2. Add the label to the registry: `docker tag sign2text:latest sign2textapi.azurecr.io/latest`
3. Push the image to the registry: `docker push sign2textapi.azurecr.io/latest`

### We can now pull the image if needed with

`docker pull sign2textapi.azurecr.io/sign2text`

## Upload the container to AWS

1. Instalamos el CLI de AWS: `pip install awscli`
2. Configuramos el CLI: `aws configure`
3. Nos logueamos en el ECR (elastic container registry): `aws ecr get-login --region eu-west-3`
4. Ejecutamos login con Docker según la salida del comando anterior: `docker login -u AWS -p <PASSWORD> https://<ACCOUNT_ID>.dkr.ecr.<REGION>.amazonaws.com`
5. Creamos un repositorio: `aws ecr create-repository --repository-name sign2text`
6. Añadimos la etiquta al repositorio: `docker tag sign2text:latest <ACCOUNT_ID>.dkr.ecr.<REGION>.amazonaws.com/sign2text`
7. Verificamos que el tag existe: `docker images`
8. Hacemos push de la imagen al registro: `docker push <ACCOUNT_ID>.dkr.ecr.<REGION>.amazonaws.com/sign2text`
9. (Opcional) Si queremos eliminar la imagen del registro: `aws ecr batch-delete-image --repository-name sign2text --image-ids imageTag=latest`
10. (Opcional) Si queremos eliminar el repositorio: `aws ecr delete-repository --repository-name sign2text`

## Upload to AWS using EC2

1. Create a EC2 service in the platform.
2. Connect to it with ssh using the pair keys given with: `ssh -i "credentials.pem" ec2-user@<INSTANCE>.<REGION>.compute.amazonaws.com`
3. When connected, tun the following commands:
   1. Update the pacackage list: `sudo yum update -y`
   2. Install docker: `amazon-linux-extras install docker`
   3. Start the docker with `sudo service docker start`
   4. Add the ec2-user to the docker group so you can execute Docker #commands without using sudo. `sudo usermod -a -G docker ec2-user`
4. Reinicaimos la instancia de EC2 desde la plataforma y nos conectamos de nuevo.
5. Al igual que en el punto anterior, subimos la imagen al ECR (Elastic Container Registry) (tag + push)
6. Una vez tenemos el registro y el EC2, nos conectamos a este último de nuevo para ejecutar la imagen.
7. Una vez conectados iniciamos aws: `aws configure`
8. Inicia el daemon de docker (ver 3.3) y añade tus credenciales (Punto anterior 3 y 4).
9. Copia la URI de la imagen de docker subida al ECR y ejecuta en la instancia: `docker pull <URI>`
10. Una vez hehco esto, ejecutamos el docker como lo haríamos de forma local: `docker run -dp 80:8000 <NAME_OF_IMAGE>`
    1. Podemos ver las imagenes con `docker images`
    2. Importante usar `80:8000` para mapear los puertos de la instancia a los puertos de la imagen.
    3. Comprobar que la imagen está corriendo con `docker ps`
11. Añadimos regla de entrada para aceptar tráfico.
    1. En l ainstancia > Seguridad > Grupos de Seguridad > Editar reglas de entrada
    2. Agregamos una regla con tipo "Todo el tráfico" y 0.0.0.0/0
    3. La aplicación ya es accesible públicamente.

## Añadir un dominio personalizado a nuestra aplicación

### Create an app for the image and assign custom domain

## Where is it hosted?

This FastAPI image is hosted on AWS and is available at the following link: <https://api.sign2text.com/docs>

## Tools used for testing

[Insomnia](https://insomnia.rest/download)

## Bibliografía

[Tutorial de subir FastAPi a AWS](https://levelup.gitconnected.com/deploy-a-dockerized-fastapi-application-to-aws-cc757830ba1b)
