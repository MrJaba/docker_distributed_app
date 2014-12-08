FROM ubuntu:14.04
MAINTAINER Tom Crinson "the.jaba@gmail.com"
ENV REFRESHED_AT 2014-12-08

RUN apt-get -qqy update
RUN apt-get -qqy install ruby-dev git libcurl4-openssl-dev curl build-essential python
RUN gem install --no-ri --no-rdoc uwsgi sinatra
RUN uwsgi --build-plugin https://github.com/unbit/uwsgi-consul

RUN mkdir -p /opt/distributed_app
WORKDIR /opt/distributed_app

ADD config/uwsgi-consul.ini /opt/distributed_app/
ADD app/config.ru /opt/distributed_app/

ENTRYPOINT [ "uwsgi", "--ini", "uwsgi-consul.ini", "--ini", "uwsgi-consul.ini:server1", "--ini", "uwsgi-consul.ini:server2" ]
CMD []