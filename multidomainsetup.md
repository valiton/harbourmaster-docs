#Multi domain setup

it is possible to allow users to login with the same username and password on multiple top level domains e.g. example.com and valiton.com. 
There are tow options avalivel a multi usermanager installation and a singel user manger installation.


##Multi Usermanager

Setup a usermanger Subdomain for each top levl domain.
This setup allaws for the most customisation of the usermanger for the individual domain, as described in the [Usermanager](Usermanager.md) documentation.

**Note**

not as of writing this documentation (August 2016) the automatical login in all SSO top level domains with one singel User login action, also knows as **cross domain login** is not avalibel in the Freemium Verion. 

### Setup

To setup a secound domain, first follow the steps in the [Quick Start Guide](quick-start-guide.md) 

Then you can setup a secound domain thunder.local by folling this steps 


```bash
cd harbourmaster-docs/quickstart/second-domain/

docker-compose up
```

**Add /etc/hosts entries**

Create the following entry in your/etc/hosts according to your docker machine ip address, in this example 192.168.99.100.

Get your docker mashine ip with ```docker-machine ip```

```bash
192.168.99.100 usermanager.thunder.local www.thunder.local
```

### Access the applications


#### User Manager



[http://usermanager.thunder.local:90/demo/](http://usermanager.thunder.local:90/demo/)



#### Configure Drupal Module



The installation and configuration is described in the chapter [Drupal Module](drupalmodule.md)


User for the **URL to usermanager**: http://usermanager.thunder.local:90



## Single Usermanger

due to the missing cross domain login feature in the Freemium Version is this freature not available.
