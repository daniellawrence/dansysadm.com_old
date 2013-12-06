FROM ubuntu:12.04
MAINTAINER Danny Lawrence <dannyla@linux.com>

RUN echo "deb http://ppa.launchpad.net/nginx/stable/ubuntu precise main" > /etc/apt/sources.list.d/nginx-stable-precise.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C300EE8C
RUN apt-get update  -qq
RUN apt-get install nginx -y
ADD ./web /usr/share/nginx/html
RUN echo "service nginx start" > /.bashrc