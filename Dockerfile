FROM centos:latest

#Install Dependencies & Configure
RUN dnf module reset php -y
RUN dnf module enable php:7.4 -y && \
    dnf install epel-release wget httpd php php-mysqlnd php-gd php-xml mariadb-server mariadb -y && \
    dnf install supervisor php-mbstring php-json -y 
RUN cd /var/www/html && wget https://releases.wikimedia.org/mediawiki/1.35/mediawiki-1.35.1.tar.gz && tar -zxf mediawiki-1.35.1.tar.gz && \
    mv /var/www/html/mediawiki-1.35.1/ /var/www/html/mediawiki && rm -rf /etc/httpd/conf/httpd.conf

#Add custom files and permissions
COPY httpd.conf /etc/httpd/conf/httpd.conf
RUN chown -R apache:apache /var/www/html/ && chown -R apache:apache /var/www/html/ && chown -R apache:apache /etc/httpd/conf/httpd.conf && \
    mkdir -p /run/php-fpm && mkdir -p /run/httpd && mkdir -p /etc/supervisord.d/conf && mkdir -p /var/run/php

#ADD SupervisorD configurations for centos7    
RUN echo "files = /etc/supervisord.d/conf/*.conf" >> /etc/supervisord.conf
ADD supervisor.conf /etc/supervisord.d/conf/services.conf
EXPOSE 80

#Run Supervisord
ENTRYPOINT [ "/usr/bin/supervisord", "-n" ]
