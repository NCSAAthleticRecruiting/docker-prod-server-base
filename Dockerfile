# Dockerfile for Apache web server.

# Select ubuntu as the base image
# # http://phusion.github.io/baseimage-docker/
# Extends smartive/varnish which enables varnish on top of phusion base. Also includes memcached.
FROM drupalateam/server-base:latest

#PHP Config
COPY config/php/php.ini /etc/php5/apache2/

#Install Varnish & memcached
#RUN apt-get update && apt-get upgrade -y
#RUN apt-get install -qy varnish memcached 

# Install Apache Solr
#RUN apt-get -y install openjdk-7-jdk
#RUN mkdir /usr/java
#RUN ln -s /usr/lib/jvm/java-7-openjdk-amd64 /usr/java/default
#RUN apt-get -y install solr-tomcat
# Solr configuration can be done by visiting: localhost:8080/solr

# Memcache Installation
#RUN apt-get install php-pear
#RUN yes | apt-get install php5-dev
#RUN yes | pecl install memcache

# Varnish configuration
#ADD config/varnish/default.vcl /etc/varnish/default.vcl
#ENV VARNISH_BACKEND_PORT 8088
#ENV VARNISH_BACKEND_IP 0.0.0.0
#ENV VARNISH_PORT 80

# Modify existing Apache2 configuration to give port 80 over to varnish
#RUN sed -i 's/Listen 80/Listen 8088/g' /etc/apache2/ports.conf
#RUN sed -i 's/VirtualHost \*:80/VirtualHost \*:8088/g' /etc/apache2/sites-available/www.conf
#RUN sed -i 's/VirtualHost \*:80/VirtualHost \*:8088/g' /etc/apache2/sites-available/000-default.conf

# RUN useradd -rm ruby_dev -u 1000 -g 50
# don't add source code, going to mount it
# ADD . /srv/www/siteroot
RUN mda=/srv/www/siteroot;
RUN if ! [ -L $mda ]; then ln -s /data /srv/www/siteroot; fi 

# Add configuration volumes for solr and varnish
#VOLUME ["/usr/share/solr"]
#VOLUME ["/var/lib/varnish"]
#VOLUME ["/etc/varnish"]

COPY prod-server-base-start.sh /root/prod-server-base-start.sh
COPY config/varnish/start.sh /root/varnish-start.sh
#RUN chmod 777 /root/prod-server-base-start.sh
#RUN chmod 777 /root/varnish-start.sh

# Define default command.
#CMD sh /root/server-base-start.sh && sh /root/prod-server-base-start.sh && sh /root/varnish-start.sh & /sbin/my_init

EXPOSE 80 8080 8088 3306 443 11211
