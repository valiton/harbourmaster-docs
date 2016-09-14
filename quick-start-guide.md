# Quick Start Guide

The purpose of this quick start guide is to provide you with a fast and easy way of getting Harbourmaster set up and running on your local environment. 
For an advanced production setup, please refer to the more detailed documentation further below.

## What is in this Guide

This guide will help you set up a set of Docker containers which will run the following applications:

* [MongoDB](https://hub.docker.com/_/mongo/) \(used as main database\)
* [Redis](https://hub.docker.com/_/redis) \(used for caching\)
* [Ngnix](https://hub.docker.com/_/nginx/) \(used as reverse proxy\) 
* [Harbourmaster](https://hub.docker.com/r/valiton/harbourmaster/)  
* [Usermanager](https://hub.docker.com/r/valiton/usermanager/)
* [Control Center](https://hub.docker.com/r/valiton/controlcenter/)

## Create a docker runtime environment

This guide uses the software containerization platform [Docker](https://www.docker.com/) in order to make the installation process as easy as possible. The first step is to install a docker runtime environment on your system. We recommend using the lastest version of the native Docker client. If you're running an older version of your operating system which doesn't meet Docker's requirements, you can alternatively install [Docker Toolbox](https://www.docker.com/products/docker-toolbox).

For further instructions on how to get Docker or Docker Toolbox running on your system, please refer to the official starting guide: [Get Started with Docker](https://docs.docker.com/engine/getstarted/)

## Clone the harbourmaster-docs repo and switch to the quickstart folder

Get the lastest version of the Harbourmaster Quick Start Guide from our GitHub repository over at [https://github.com/valiton/harbourmaster-docs.git](https://github.com/valiton/harbourmaster-docs.git). This repository contains all the necessary files to get you set up and running. After you've downloaded  the files, switch to the quickstart directory to get started:

```bash
git clone https://github.com/valiton/harbourmaster-docs.git
cd harbourmaster-docs/quickstart/
```

## Accept Harbourmaster license

In order to run Harbourmaster, its [license](license.md) has to be accepted via configuration. This quick start guide uses the `shared_config.env`configuration file, which already contains the necessary line `LICENSE=accept`.

For more information on how to view and accept the license for your production setup, please refer to the chapter [Harbourmaster](/harbourmaster.md).

## Start containers with Docker Compose

Docker Compose is a tool which can automatically start up multiple Docker containers in a way which is defined in a `docker-compose.yml`file \(included in this quick start guide\). While inside the quickstart directory, simply run:

```bash
docker-compose up
```

The latest version of Harbourmaster will automatically be downloaded and started up using a pre-defined configuration.

If Docker Compose didn't come with your Docker installation, please refer to the official [Docker instructions](https://docs.docker.com/compose/install/) on how to install this tool.

## Seed Harbourmaster tenants

This guide comes with a shell script which seeds the database with a few test-users as well as the admin user. During its run, the [seed-harbourmaster.sh](quickstart/seed-harbourmaster.sh) script will prompt you to input an initial password for the admin user. In the quickstart directory, run:

```bash
./seed-harbourmaster.sh
```

## Add /etc/hosts entries

Create the following entry in your /etc/hosts file. If your Docker containers are running non-locally, replace the IP address in this entry accordingly.

All Harbourmaster applications are running on static TCP ports (Harbourmaster and Usermanager on port 80, Control Center on port 18040). As previously mentioned, the `docker-compose.yml` also starts up an Nginx container, which listens on port 80 and maps our subdomains (e.g. `usermanager.thunder` or `harbourmaster.thunder`) to the individual application containers.

```bash
127.0.0.1 usermanager.thunder.dev harbourmaster.thunder.dev controlcenter.thunder.dev
```

# Accessing the applications

To access the applications, simply point your web browser to the following URLs:

### Control Center

[http://controlcenter.thunder.dev](http://controlcenter.thunder.dev/)

\(username: "admin", password: &lt;YOUR\_INPUT\_DURING\_SEED&gt; \)

### User Manager

[http://usermanager.thunder.dev/demo](http://usermanager.thunder.dev/demo/)

As described in the [Usermanager](/Usermanager.md) chapter, you can configure an SMTP server to handle user registrations. It is, however, still possible to create users using the usermanager for testing purposes, even without any SMTP configurations.

[http://harbourmaster.thunder.dev](http://harbourmaster.thunder.dev/)

# Configuring the Drupal Module

For the installation and configuration of the Drupal Module, please refer to the chapter [Drupal Module](drupalmodule.md). Once installed, users will be able to register and log in using `<YOUR_DRUPAL_URL>/harbourmaster/login`.

# General outline for your production setup

In this Quick Start Guide, we have provided you with pre-configured docker-compose and \*.env files in order to provide you with a working setup easily and quickly.

When setting up Harbourmaster in a production environment, you should consider starting up each Harbourmaster application container \(Harbourmaster, Usermanager and Control Center\) individually and providing your own configurations. Please refer to the configuration section of each application to get an overview of how they can be customized and consider using your pre-configured local setup as a reference point.

When working with Docker, the Harbourmaster applications will accept configuration options passed to them in environment variables. Each chapter provides you with the relevant variables and gives you example Docker run commands. For more information on how to start up applications using Docker, you can refer to the official documentation at [https://docs.docker.com/engine/reference/run/](https://docs.docker.com/engine/reference/run/).

The Harbourmaster applications are all running on static ports which cannot be changed. You can, however, use Docker's EXPOSE feature \(see link above\) to determine which host port should be mapped to the application. As demonstrated in this Quick Start Guide, you can then set up a reverse proxy using applications such as Nginx or HAProxy. If you would like to set up an Nginx server similar to the one in this guide (and enable additional features such as SSL termination), you can check out our example [nginx.conf](quickstart/nginx.conf) file and refer to [the official documentation](http://nginx.org/en/docs/) \(specifically the [Beginner's Guide](http://nginx.org/en/docs/beginners_guide.html#conf_structure)\) for setup instructions.