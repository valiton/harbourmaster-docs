# Harbourmater

## About

The Harbourmaster application is the backbone of the Harbourmaster SSO. It provides the API which powers all other applications.
[https://hub.docker.com/r/valiton/harbourmaster/](https://hub.docker.com/r/valiton/harbourmaster/)

Its main API is the REST API, which contains a full documentation with Swagger: [http://YOUR\_HARBOURMASTER\_URL/docs](http://YOUR_HARBOURMASTER_URL/docs)

As well as the Rest API, it provides a change notification mechanism that allows notifications to be received for example, when a user changes their profile data \(not included in the Freemium version\).

The Harbourmaster stores data in a [MongoDB](https://www.mongodb.com/).

### Modular Architecture

The Harbourmaster comprises a core module and a couple of feature extending modules listed. Not all modules are include in the Freemium version.

| Module Name | Description | In Freemium |
| --- | --- | --- |
| harbourmaster | Core module with all API required for basic SSO | YES |
| hms-module-user-confirmable | Adds API for user registration confirmation | YES |
| hms-module-user-tokens | Adds API to assign tokens to users, used in combination with mobile SDK | YES |
| hms-module-anonymous-sessions | Adds API for handling anonymous sessions | YES |
| hms-module-oauth2 | Adds OAuth2 API | NO |
| hms-module-purchases | Adds API to assign purchases \(paid one time\) to users | NO |
| hms-module-entitlements | Adds API to assign entitlements \(paid subscription\) to users | NO |
| hms-module-entitlements-postentitlement-ciscom-crm | Adds API to check subscription status with a external ciscom CRM | NO |
| hms-module-notificator-kinesis | Adds change notifications using AWS Kinesis | NO |
| hms-module-notificator-sqs | Adds change notifications using AWS SQS | NO |
| hms-module-notificator-redis-sentinel | Adds change notifications using Redis, also Redis Sentinel compatible | NO |
| hms-module-managed-subscriptions | Adds API to manage newsletter subscription and advertisement permissions, one tenant can have one newsletter account | NO |
| hms-module-multiclient-subscriptions | Adds API to manage newsletter subscription and advertisement permissions, one tenant can have multiple newsletter accounts | NO |

## License

The Harbourmaster Freemium is licensed under the attached [LICENSE](license.md).

To start the Harbourmaster you need to accept the license by passing the LICENSE=accept, to display the license pass LICENSE=view

```bash
LICENSE=<accept|view>
```

Simple command to view just the license and dont run all the containers

```bash
docker run -e LICENSE=view valiton/harbourmaster

```

## Configuration

The necessary configuration of the Harbourmaster is defined with environment variables.

```bash
LICENSE=<accept|view>

REDIS_PORT_6379_TCP_ADDR=<ip of redis>  #compatible with docker link redis
REDIS_PORT_6379_TCP_PORT=<prot of redis> #compatible with docker link redis

MONGO_PORT_27017_TCP_ADDR=<ip of mongodb> #compatible with docker link mongo
MONGO_PORT_27017_TCP_PORT=<prot of mongodb> #compatible with docker link mongo 


# used for seed script run, shared values with usermanger 
HARBOURMASTER_TENANT=<teante name > e.g. thunder
USERMANAGER_HMS_USER_KEY=<usermanager key| 20 char hex format> e.g.  32be04fb9495229f3e4f
USERMANAGER_HMS_USER_SECRET_KEY=<usermanager secret key random string> e.g. 58c94af9f955eebebaf81195d57f774fe7a9d834efd519c8588d184914ff


```

## Docker run

Start a mongodb and redis as a container:

```bash
docker run -d --name=mongo mongo:3.2
docker run -d --name=redis redis
```

Start the Harbourmaster server:

```bash
docker run --name=thunder-harbourmaster -it -e LICENSE=accept --link mongo:mongo --link redis:redis valiton/harbourmaster
```

Seed the mongodb with an initial data set; this is necessary because all API endpoints need a logged in user. The seedscript creates the initial user.

```bash
docker exec -it thunder-harbourmaster bash -c "node /app/scripts/seed-create-thunder-tenant.js"
```

## Backup

The [Quick Start Guide](/quick-start-guide.md) repository contains a [backup script](https://github.com/valiton/harbourmaster-docs/blob/master/quickstart/mongodb_backup.sh) which can be used as a starting point to create an automated backup process for the MongoDB. It is recommended to use a [Cron job](http://www.unixgeeks.org/security/newbie/unix/cron-1.html) to automate and schedule the backup prodecure.

## API

The Harbourmaster provides a HTTP REST API. Its main API is the REST API, which is full documents with swagger. [http://YOUR\_HARBOURMASTER\_URL/docs](http://YOUR_HARBOURMASTER_URL/docs)

The basic API structure example:

```bash
<server> domain where the harbourmaster is deployed to.
<TENANT> placeholder for the tenant to be used.
<resource> placeholder for the resource to be used.
<nestedResource> placeholder for a nested resource.

http://<server>/v1/<TENANT>/<resource>
http://<server>/v1/<TENANT>/<resource>/<ID>
http://<server>/v1/<TENANT>/<resource>/<ID>/<nestedResource>
```

### API responses

#### Positive response

All positive responses have this general JSON structure:

```json
{
 "status": 1,
 "responseCode":  <HTTP_RESPONSE_CODE>,
 "data": { <DATA> }
}
```

#### Error response

All error responses have this general JSON structure:

```json
{
 "status": 0,
 "message": "<MESSAGE>",
 "responseCode": <HTTP_RESPONSE_CODE>
}
```

## Policies

Policies in the Harbourmaster are a very flexible way to grant access to resources in the Harbourmaster. The policy system is loosely inspired by the [Amazon AWS IAM policies](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/iam-policy-structure.html#policy-syntax).

All Harbourmaster API endpoints verify access based on the policy of the requesting user.

The API endpoint is represented as action and the resource, depending on the context of the created/updated/shown/deleted data.

The actions and resources involved in the Harbourmaster API are listed in the swagger documentation.

A Policy consists of one or many statements, which are structured as follows:

* **Effect**: can be Allow or Deny
* **Tenant**: the tenant where the policy should apply; gets converted in a regular expression
* **Action**: represents an API endpoint action; gets converted in a regular expression
* **Resource**: the resource which is affected by the action; get converted in a regular expression
  * Special Resource **\[currentUser\] **access is only granted to the resource owned by the accessing user


### Policy Example

**Full access** to all actions on all resource in all tenants:

```json
{"Statement":[
 {"Tenant":"*", "Effect":"Allow","Action":"*","Resource":"*"}
]}
```

**currentUser **User can read and edit his own data

```json
{ "Statement": [
 { "Tenant": "thunder", "Effect": "Allow", "Action": "hms:login", "Resource": "[currentUser]" },
 { "Tenant": "thunder", "Effect": "Allow", "Action": "hms:updateUserPassword", "Resource": "[currentUser]" },
 { "Tenant": "thunder", "Effect": "Allow", "Action": "hms:getUserServices", "Resource": "[currentUser]" },
 { "Tenant": "thunder", "Effect": "Allow", "Action": "hms:getUser", "Resource": "[currentUser]" },
 { "Tenant": "thunder", "Effect": "Allow", "Action": "hms:updateUser", "Resource": "[currentUser]" },
 { "Tenant": "thunder", "Effect": "Allow", "Action": "hms:listUserEntitlements", "Resource": "[currentUser]" },
 { "Tenant": "thunder", "Effect": "Allow", "Action": "hms:listAllowedTenants", "Resource": "[currentUser]" }
]}



```

