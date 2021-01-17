** Goal **

The objective of the project is to dockerize mediawiki application from scratch and deploy the mediawiki container in Kubernetes using Helm charts.
Currently this project is working using Docker containers. Creation of helm charts is still in progress.



** Environment details **

Operation System: Windows 10 (Docker Desktop 3.0.4)
Docker version: 20.10.2
Kubernetes version: v1.19.3



** Folder Structure **

**custom-mediawiki** - Helm Charts for Mediawiki web service (http & php)
**custom-mysql** - Helm charts for mediawiki-db (mysql image used from dockerhub official repository)

The application is split into two assuming that it should be kept as a microservice rather than baked inside a single container image. 



**Dockerfile** - To dockerize the mediawiki application

**httpd.conf** - custom configuration file for httpd, To be passed during docker build.

**run.sh** - Kickstarts httpd and php-fpm when container starts.

**Custom** - Mediawiki-Docker.pdf - Steps to Run the application as a Docker container.


**** Issues Currently with Helm Deployment ****

1) The PHP-fpm service in Custom-mediawiki is not getting started when the image is deployed on Kubernetes using helm.


**** Items pending ****

1) Addition of PVC to MYSQL Helm charts

