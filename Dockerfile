FROM ubuntu:12.04
MAINTAINER Danny Lawrence <dannyla@linux.com>

# Add nginx packages
RUN echo "deb http://ppa.launchpad.net/nginx/stable/ubuntu precise main" > /etc/apt/sources.list.d/nginx-stable-precise.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C300EE8C

RUN echo "deb http://au.archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update  -qq
RUN apt-get install nginx supervisor -y
ADD ./web /usr/share/nginx/html
ADD ./supervisor-nginx.conf /etc/supervisor/conf.d/nginx.conf

ENTRYPOINT ['/usr/bin/supervisord', '-n']