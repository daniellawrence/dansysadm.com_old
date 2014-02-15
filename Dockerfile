FROM ubuntu:12.04
MAINTAINER Danny Lawrence <dannyla@linux.com>

RUN echo "deb http://au.archive.ubuntu.com/ubuntu precise main universe multiverse" > /etc/apt/sources.list
RUN apt-get update  -qq
RUN apt-get install supervisor python-pip python nginx -y
RUN rm -rf /var/cache /tmp/*
RUN cat /dev/null > /var/log/*

ADD requirements.txt /tmp/
RUN pip install -r /tmp/requirements.txt

ADD . /tmp/build
RUN rm -rf /tmp/build/web
RUN cd /tmp/build && python /tmp/build/generate_website.py
RUN cp -rp /tmp/build/web/* /usr/share/nginx/www/
ADD ./supervisor-nginx.conf /etc/supervisor/conf.d/nginx.conf

EXPOSE 80

CMD /usr/bin/supervisord -n
