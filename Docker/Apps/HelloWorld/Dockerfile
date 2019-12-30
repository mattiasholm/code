FROM ubuntu:18.04

RUN apt-get update
RUN apt-get upgrade -y

RUN mkdir -p /myapp
WORKDIR /myapp
COPY . .

RUN apt-get install -y python3

CMD python3 main.py
