# Devnet Workshop 2030 - Mantl: How to use it.

Welcome to Cisco Live! US 2016. 
This is the guide for session DevNET-2030: "Devnet Workshop - Mantl: How to use it". 

In this workshop you will learn how to deploy  micro-services applications and manage them on Cisco's Mantl platform. In this workshop we expect attendees have basic knowledge of containers, microservices architecture and REST APIs. This README is divided in following three sections.

1. Application Overview - This section talks about the "My Hero" application, architecture and micro-services used to compose the application.
2. Application Deployment - This section starts with Mantl UI walkthrough and covers application deployment on Mantl cluster.
3. Application Management - This section covers how to manage application life cycle using Mantl UI and REST APIs.


# 1 Application Overview

In this workshop we will be using "MyHero App" a simple web app, broken into a small number of 'microservices-like' components; to demonstrate Mantl capabilities. The MyHero App allows users to vote for their favorite super hero and gather the voting results. 
The application is pre-built in a microservice style and each service is packaged in a docker container; ready for deployment on Mantl.  

In its most basic form, the application has three services.

1. [myhero/data](https://github.com/hpreston/myhero_data) - This service stores all the data about candidates and votes cast.
2. [myhero/app](https://github.com/hpreston/myhero_app) - This service provides the basic logic layer for accessing and recording votes.
3. [myhero/web](https://github.com/hpreston/myhero_web) - This is the main user interface for casting votes.

![MyHero Demo Application](diagrams/myhero-demo-i1.png)


# 2 Application Deployment

## 2.1 Prerequisites

In this Workshop, we're using a tool called postman to talk to the MANTL API's.
Just like your web browser making a HTTP request for a website (GET, POST, etc); Postman provides a graphical tool to submit requests against HTTP endpoints (such as API's, that don't return a graphical interface such as a website).

We're using postman because it's cross platform, so bring your laptop of choice and download the following!

### If youre a google chrome user...
- Google Chrome web browser.
- Google Chrome Postman extension. (Installation instructions: https://www.getpostman.com/docs/introduction)

### If you're not...
- There is a standalone version of postman available for mac https://www.getpostman.com/

## 2.2 Mantl UI walkthrough

You should already have access to the Mantl UI, displaying different tiles for Mantl components such as Mesos, Martahon, Consul and Traefik which are the core open source technologies used by Mantl. You can click on these  tiles one by one to explore these technologies, also notice the healchecks for each component built into Mantl and surfaced via the UI.

## 2.3 Application deployment on Mantl

### 2.3.1 Import Mantl Postman collection on Chrome Postman application.

#### How:

Download following two files locally.

1. Environment File: https://raw.githubusercontent.com/CiscoCloud/clus-my-hero-app/master/CLUS_MANTL.postman_environment.json
2. Mantl Collections File: https://raw.githubusercontent.com/CiscoCloud/clus-my-hero-app/master/clus-my-hero-app.postman_collection.json

Open Postman application and import Environment and Collection files.

### 2.3.2 Update Environment variables

Each of you will be deploying onto the same cluster, plus, you may want to use the postman scripts against a different mantl cluster in future. So we have split out some of the changing information into variables which you can set for the workshop.

Things like ```DEPLOYMENTNAME``` for example, because we dont want all of you trying to create an app with the same name!

#### How:

Open Environment management tab from the postman UI and click on "CLUS_MANTL" Environment. Update modify the following environment variables as needed (Please consult Cisco engineers).

- MANTL_CONTROL: Mantl control API endpoint (cumulus.clus2016.mantl.io).
- MANTL_USER: Username to authenticate ("admin")
- MANTL_PASSWORD: Password to authenticate ("Helloclus2016")
- DEPLOYMENTNAME: Use your first ane lastname (e.g. nospaces).
- MANTLDOMAIN: DNS name to access the deployed application ("dev.clus2016.mantl.io")

### 2.3.3 Deploy my-hero-app on Mantl

#### How:

On the Postman application go to ```clus-my-hero-app > 1-myhero-install``` folder and run (Send button) ```1-install_myhero_data```, ```2-install_myhero_app``` and ```3-install_myhero_web``` in order. Each request to the API will deploy one of the application components.

### 2.3.4 Access the my-hero-app

You should be able to reach the web interface for the application at http://```DEPLOYMENTNAME```-web.dev.clus2016.mantl.io where DEPLOYMENTNAME refers to the deployment name provided at setup.

# 3 Application Management

## 3.1 Mantl UI walkthrough with my-hero-app

Open the Mantl UI again; On this page you will see different tiles for Mesos, Martahon, Consul and Traefik which are the core open source technologies used by Mantl.

1. Click on the Mesos tile and look at the tasks, you will find tasks related to the application name you have give while setting up the environment.

2. Click on Marathon tile to open Marathon UI, here you can investigate individual services from the MyHero application. Click on the "Configuration" tab to explore about the service configuration. You can scale up/down the service from this tab as well.

####Note:
Please ask help from the Cisco DevNET engineers if needed.    


## 3.2 Using Mantl REST API

Mantl provide REST APIs to access its individual components (Mesos, Marathon etc...). Infact, we've already used them once to deploy the application! 

Now we're going to use postman to get and change information about our deployment via the API.

### 3.2.1 List Applications

Run/Send Button "1-list_apps" to list the services you have just deployed. This will return response in JSON format.

### 3.2.2 Get Application details

Run/Send Button "2-get_myhero_web" command to get the details about your "myhero_web" service. Look at the response there is only one instance ( "instances": 1) of the service is running.

### 3.2.3 Scale UP application

Currently there is only one instance ```"instances": 1``` of the service is running for our application".
This is great, but we scaling up the application will load balance more copies to help us handle more load. It also provides fault tolerence for our app should an instance die.

To scale up this service open ```5-sacle_up_myhero_web``` REST request and open the "Body" tab from Postman request tab. Change the instances to 3 ```{"instances":3}``` and run/Send Button the request. This will spin up 2 more instances of the "myhero_web" service.

You can check the number of instances in Marathon (UI) or by running the API App details request in 3.2.2 above!

### 3.2.4 Scale down application

To scale down the service open ```6-sacle_down_myhero_web``` postman request and change the instance to 1 ```{"instances":1}``` and run/Send Button the request. This will bring down service "myhero_web" back to one. In this situation, the extra two containers are killed and the load balancer points all new requests to the single remaining instance.

## 3.3 Destroy MyHero Application

We bareley got to know them... In this steps we will destroy the application.

####How:

Run/Send Button requests ```1-uninstall_myhero_web```, ```2-uninstall_myhero_data``` and  ```3-uninstall_myhero_app``` from Postman folder ```3-myhero-uninstall``` to remove all three services from Marathon.

####Note:

You can verify the current state of services using 1-get_myhero_data, 2-get_myhero_app and 3-get_myhero_web REST requests or using the Mantl UI.
