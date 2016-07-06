# Devnet Workshop - Mantl: How to use it.

This workshop is designed for Cisco Live "Devnet Workshop - Mantl: How to use it" session. In this workshop you will learn how use Mantl to deploy your micro-services application and how to manage the application using Cisco's Mantl platform. In this workshop we expect the attendees have basic knowledge of containers, micro-services and REST APIs.  

## Application overview

In this workshop we will be using "MyHero App" application which is being developed with micro-services paradigm to demonstrate Mantl capabilities. MyHero App is very simple application which allow users to vote for their favorite super hero and gather the voting results. The application is built in a microservice style wrapping each service in a docker container that can be deployed and run in Mantl.  In its initial form the application has three services.

1. [myhero/data](https://github.com/hpreston/myhero_data) - This service stores all the data about candidates and votes cast.
2. [myhero/app](https://github.com/hpreston/myhero_app) - This service provides the basic logic layer for accessing and recording votes.
3. [myhero/web](https://github.com/hpreston/myhero_web) - This is the main user interface for casting votes.

![MyHero Demo Application](diagrams/myhero-demo-i1.png)


## Prerequisites

Following are the prerequisites for the attendees.

- Linux operating system based laptop (Cygwin may also work).
- GIT and CURL installed.
- Standard Web browser

## Application overview

![MyHero Demo Application](diagrams/myhero-demo-i1.png)

## UI walkthrough

Open a web browser and open "https://mantlsandbox.cisco.com" enter credentials as given.

What
Explanation about Mesos, Martahon, Consul and Traefik.

## Environment setup

Environment setup is the first step which will setup Mantl endpoints and credentials to sign in to the Mantl UI.

How:
Run "source myhero_setup" to enter and record the deployment name, address, application domain, username, and password for your Mantl instance as non-persistent Environment Variables. This means you will need to run this command everytime you open an new terminal session.

## Deploy my-hero-app on Mantl

How:
Run ./myhero-install.sh to deploy all three services (data, app, web) to your Mantl cluster.

After running the install it will take a 2-5 minutes for all three services to fully deploy and become "healthy". You can monitor this in the Marathon Web GUI.

## Access the my-hero-app

You should be able to reach the web interface for the application at http://DEPLOYMENTNAME-web.YOUR-DOMAIN where DEPLOYMENTNAME refers to the deployment name provided at setup and YOUR-DOMAIN refers to the wildcard domain configured for Traefik.

## UI walkthrough with my-hero-app

What:

Explanation on



## Use of REST API

Run "source myhero-cmd.sh" to setup the

### List Applications

Run "myhero_list_apps" to list the application you just deployed.


### Get Application details

Run "myhero_get_app"

### Scale UP the application

myhero_scale_up_web

### Scale down the application

myhero_scale_down_web

## Destroy Application

In this steps we will destroy the application along with all micro-services from the Mantl cluster.

How:

Run ./myhero-uninstall.sh to remove all three services from Marathon.

Note:

You can verify the current state using REST API or using the Mantl UI.





## Remove my-hero-app from Mantl
