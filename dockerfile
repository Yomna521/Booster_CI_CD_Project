# pull the official base image
FROM python:3.8
MAINTAINER yomna abdulwahab yabdulwahab@example.com

# set work directory
WORKDIR /usr/src/app

# copy project
COPY . /usr/src/app

# install dependencies
RUN pip install --upgrade pip 
COPY ./requirements.txt /usr/src/app
RUN pip install -r requirements.txt

# Migration db
RUN python3.8 manage.py makemigrations
RUN python3.8 manage.py migrate

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

FROM jenkins/jenkins:lts
USER root
#install docker client
RUN apt-get update -qq
RUN apt-get install -qq apt-transport-https ca-certificates curl gnupg2 software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
RUN apt-get update -qq \
    && apt-get install docker-ce -y
RUN usermod -aG docker jenkins
