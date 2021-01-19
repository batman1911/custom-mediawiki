# MediaWiki Microservice App deployment using Helm charts



The above project consist of Dockerfile and Helm charts to containerize the MediaWiki App and Deploy it on Kubernetes with a Mysql server using Helm Charts. To deploy the app as a microservice, The application is split into two services, One being the Mediawiki app that runs on Httpd and PHP and the other being the Mysql service.

However both these services can be deployed using the single Helm chart provided.

Following are the pre-requisites for running the app.

  - Latest version of Docker should be installed on your environment.
  - A Kubernetes cluster along with Helm3 is required.
  - Operating system can be Linux or Windows.
  
The above project is tested on Kubernetes version v1.19.3 that comes along with Docker Desktop - 3.0.4. (Docker Engine - 20.10.2 )

# How to Run the app

Clone the project in your local system & switch to the project folder using command line.

### 1.Create Docker Image using the following command
```sh
  docker build -t <your-docker-image-name-with-tag> .
``` 
Check if your docker image is created using the following command.
```sh
docker image <your-docker-image-name-with-tag>
``` 

### 2.Deploy the app using Helm Charts
Run the Helm Charts using the following command from the project root folder

Create a namespace in your Kubernetes cluster with the name "mediawiki" using kubectl.
```sh
> kubectl create ns mediawiki
``` 
In case you want to deploy this app to a different namespace, edit the two values.yaml files inside helm charts or include --set name_space=your-namespace in the following helm install command.

```sh
> cd custom-mediawiki

> helm install custom-mediawiki --set image_id="<your-docker-image-name-with-tag>" --set wiki_password="<the-password-you-like>" --set wikidb_root_password="<your-mysql-root-password>" .\custom-mediawiki\
``` 
The above Helm chart will create the required Kubernetes pods and services to run the MediaWiki App.
To test the application, try the url in your web-browser installed on your machine.

http://<IP of your local machine>:30404

Please note that for testing purpose, the Mediawiki app is allocated with a NodePort 30404 and Mysql with 30405. You can change these ports in the corresponding values.yaml files inside the helm charts.

Once the browser opens the MediaWiki installation page, Verify the Installation.PDF to proceed with the next set of steps. To know more on how the deployment automation works, please read the below topic about folder structures.


# Project Folder Structure

##### Dockerfile
To containerize the MediaWiki application with the dependencies such as PHP, Mysql etc. The Dockerfile is also installed with supervisord to kickstart the services.

##### supervisor.conf
Contains the configuration required for supervisor to start php-fpm & http during container start.

##### httpd.conf

Contains the configurations required to start Http along with custom settings.

##### custom-mediawiki folder
Helm charts that can deploy mysql pod along with the Mediawiki app. While running the Helm install command, following arguments are to be passed to the Helm charts.
1) wiki_password - mysql password for the db username wiki
2) wikidb_root_password - mysql root password for the mysql database
3) image_id - The image Id that you gave while creating the docker build.

The wiki_password is required during installation of the mediawiki app in web browser.

### Things to Note

* The above project is focused in a way to make the Mediawiki project as a basic Microservice environment. 
* Please check the Values.yaml files available in custom-mediawiki/values.yaml folder for mediawiki related parameters and custom-mediawiki/custom-mysql/values.yaml for verifying the mysql related parameters.

* The Mysql environment is backed up with a persistent volume, but is configured using a host_path for testing purpose. On a production environment, this will be configured on a highly available storage clusters.

* To exposes the services, since this cluster is hosted on local, NodePorts are being used.

*  The Mysql deployment uses Mysql:latest docker image which comes from the docker official repository. https://hub.docker.com/_/mysql
