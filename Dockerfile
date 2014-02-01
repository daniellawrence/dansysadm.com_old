FROM ubuntu:12.04
MAINTAINER Danny Lawrence <dannyla@linux.com>

# Add nginx packages

RUN apt-get install python-software-properties -y
RUN add-apt-repository -y ppa:nginx/stable 
RUN echo "deb http://au.archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update  -qq
RUN apt-get install supervisor python-pip python -y
RUN apt-get install nginx  -y

ADD requirements.txt /tmp/
RUN pip install -r /tmp/requirements.txt

ADD . /tmp/build
RUN cd /tmp/build && python /tmp/build/generate_website.py
RUN cp -rp /tmp/build/web/* /usr/share/nginx/html/
ADD ./supervisor-nginx.conf /etc/supervisor/conf.d/nginx.conf

EXPOSE 80

CMD /usr/bin/supervisord -n
