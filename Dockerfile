FROM centos:latest

RUN dnf module reset php -y
RUN dnf module enable php:7.4 -y && \
    dnf install wget httpd php php-mysqlnd php-gd php-xml mariadb-server mariadb php-mbstring php-json -y && \
    dnf install wget httpd php php-mysqlnd php-gd php-xml mariadb-server mariadb php-mbstring php-json -y 

RUN cd /var/www/html && wget https://releases.wikimedia.org/mediawiki/1.35/mediawiki-1.35.1.tar.gz && tar -zxf mediawiki-1.35.1.tar.gz && \
    mv /var/www/html/mediawiki-1.35.1/ /var/www/html/mediawiki && rm -rf /etc/httpd/conf/httpd.conf
COPY httpd.conf /etc/httpd/conf/httpd.conf
COPY run.sh /run.sh
RUN chown -R apache:apache /var/www/html/ && chown -R apache:apache /var/www/html/ && chown -R apache:apache /etc/httpd/conf/httpd.conf && \
    mkdir -p /run/php-fpm && mkdir -p /run/httpd
EXPOSE 80
CMD ["/run.sh"]
