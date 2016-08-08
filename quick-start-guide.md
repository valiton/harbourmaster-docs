# Quick Start Guide

Tested on OSX with Docker Toolbox installed. [https://www.docker.com/toolbox](https://www.docker.com/toolbox)

## Create a docker runtime environment

Install Toolbox and setup a local docker machine. Docker frequently releases new versions of docker toolbox, therefore this document can only reference the office documentation for creating a local docker environment; see [https://www.docker.com/toolbox ](https://www.docker.com/toolbox)and [https://docs.docker.com/engine/getstarted/](https://docs.docker.com/engine/getstarted/)

## Add /etc/hosts entries

Create the following entry in your/etc/hosts according to your docker machine ip address, in this example 192.168.99.100

```bash
192.168.99.100 usermanager.thunder.dev harbourmaster.thunder.dev controlcenter.thunder.dev
```

## Accept Harbourmaster license

How to accept the license: see chapter [Harbourmaster](/harbourmaster.md)

## Start containers with docker-compose

```bash
cd quickstart
docker-compose up
```

## Seed Harbourmaster tenants

You need to seed the database and provide an initial admin user password.

```bash
./seed-harbourmaster.sh
```

# Access the applications

Access the containers using the host names previously added to _/etc/hosts_

## Control Center

[http://controlcenter.thunder.dev:49040/](http://controlcenter.thunder.dev:49040/)

\(username: admin, password: &lt;YOUR\_INPUT\_DURING\_SEED&gt; \)

## User Manager

[http://usermanager.thunder.dev/demo/](http://usermanager.thunder.dev/demo/)

## Harbourmaster

[http://harbourmaster.thunder.dev:8080/](http://harbourmaster.thunder.dev:8080/)

# Configure Drupal Module

The installation and configuration is described in the chapter [Drupal Module](drupalmodule.md)

