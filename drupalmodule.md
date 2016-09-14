# Drupal8 / Thunder

## Install Harbourmaster SSO plugin

Github Link [https://github.com/valiton/harbourmaster-sso-drupal8-plugin](https://github.com/valiton/harbourmaster-sso-drupal8-plugin)

zip to install: [https://github.com/valiton/harbourmaster-sso-drupal8-plugin/archive/8.x-1.x.zip](https://github.com/valiton/harbourmaster-sso-drupal8-plugin/archive/8.x-1.x.zip)

The Module is also on Packagist [https://packagist.org/packages/valiton/harbourmaster](https://packagist.org/packages/valiton/harbourmaster)

Install the module
![Install Module](assets/drupal_install_1.png)

Successfully installed
![Install Module Success](assets/drupal_install_2.png)

Activate the module
![Activate Module](assets/drupal_install_3.png)

Successfully activated
![Active Module Success](assets/drupal_install_4.png)

## Configuration

* Configure the module
  ![](assets/drupal_install_5.png)

The Drupal Module needs to be configured to communicate to Harbourmaster the API and includes the widget js from the usermanager. Once the Drupal module has been correctly configured, users will be able to register and log in using `<YOUR_DRUPAL_URL>/harbourmaster/login`, e.g. `www.thunder.dev/harbourmaster/login`.

**HMS API CONFIGURATION**

* URL to Harbourmaster endpoint 
  _Includes protocol and domain \(optionally port and/or path prefix\). This Url is used for server to server communication, it is not used by the browser._
  e.g. "[http://harbourmaster.thunder.dev:8080"](http://harbourmaster.thunder.dev:8080)
  Required for the multi domain setup. Note if you user Docker Native for Mac use the IP address of your computer e.g. 192.x.x.x

* Harbourmaster tenant to use
  _May only contain a-z A-Z 0-9 ._
  e.g. "thunder"

* HMS lookup cache TTL
  _Duration during which the HMS session lookup is cached._
  e.g. "60"


**USERMANAGER CONFIGURATION**

* URL to usermanager
  _Includes protocol and domain \(optionally port and/or path prefix\). This Url will be used to load the Usermanger Widget, it is only used by the web browser, not for server to server communication._
  e.g. "[http://usermanager.thunder.dev"](http://usermanager.thunder.dev)

**HMS TOKEN CONFIGURATION**

* SSO cookie name
  _Name of the cookie that contains the HMS token \(usually "token"\). May only contain a-z A-Z 0-9 .-\_..SSO \_
  e.g. "token"
* Cookie domain

  _Name of the domain which the SSO cookie is set on._
   e.g. ".thunder.dev"


* SSO cookie lifetime
  _Duration in seconds in which the cookie stays valid. When set to 0, the cookie will expire after browser close._

  e.g. 2592000 \(30 days\)


**CROSS DOMAIN AUTHENTICATION CONFIGURATION**

* Cross domain login

  _Set this path to what the Usermanager uses to authenticate the user with this domain._
  e.g. /hms\_cross\_domain\_login

* Cross domain logout

  _Set this path to what the Usermanager uses to invalidate the user's session with this domain._
  e.g. /hms\_cross\_domain\_logout


