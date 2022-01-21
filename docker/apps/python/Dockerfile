FROM ubuntu:20.04

RUN apt-get update
RUN apt-get upgrade -y

RUN mkdir -p /myapp
WORKDIR /myapp
COPY . .

RUN apt-get install -y python3

CMD python3 __main__.py
