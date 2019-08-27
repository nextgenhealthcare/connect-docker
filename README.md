<a name="top"></a>
# Table of Contents
* [Supported tags and respective Dockerfile links](#supported-tags)
* [Quick Reference](#quick-reference)
* [What is NextGen Connect (formerly Mirth Connect)](#what-is-connect)
* [How to use this image](#how-to-use)
 * [Start a Connect instance](#start-connect)
 * [Using `docker stack deploy` or `docker-compose`](#using-docker-compose)
 * [Environment Variables](#environment-variables)
   * [Common mirth.properties options](#common-mirth-properties-options)
   * [Other mirth.properties options](#other-mirth-properties-options)
 * [Using Docker Secrets](#using-docker-secrets)
 * [Using Volumes](#using-volumes)
   * [The appdata folder](#the-appdata-folder)
   * [Custom extensions](#custom-extensions)
* [Examples](#examples)
* [License](#license)

<a name="supported-tags"></a>
# Supported tags and respective Dockerfile links [↑](#top)

##### Oracle OpenJDK 11 (Debian)
* [3.8, 3.8.0, latest](https://github.com/nextgenhealthcare/connect-docker/blob/master/Dockerfile)

##### Oracle OpenJDK 11 with full JDK
* [3.8-jdk, 3.8.0-jdk, latest-jdk](https://github.com/nextgenhealthcare/connect-docker/blob/master/Dockerfile-jdk)

##### Zulu OpenJDK 11 (Alpine Linux)
* [3.8-zulu-alpine, 3.8.0-zulu-alpine, latest-zulu-alpine](https://github.com/nextgenhealthcare/connect-docker/blob/master/Dockerfile-zulu-alpine)

##### Zulu OpenJDK 11 with full JDK
* [3.8-zulu-alpine-jdk, 3.8.0-zulu-alpine-jdk, latest-zulu-alpine-jdk](https://github.com/nextgenhealthcare/connect-docker/blob/master/Dockerfile-zulu-alpine-jdk)

##### AdoptOpenJDK 11 with OpenJ9 (Alpine Linux)
* [3.8-adoptopenjdk-openj9-alpine, 3.8.0-adoptopenjdk-openj9-alpine, latest-adoptopenjdk-openj9-alpine](https://github.com/nextgenhealthcare/connect-docker/blob/master/Dockerfile-adoptopenjdk-openj9-alpine)

##### AdoptOpenJDK 11 with OpenJ9 and full JDK
* [3.8-adoptopenjdk-openj9-alpine-jdk, 3.8.0-adoptopenjdk-openj9-alpine-jdk, latest-adoptopenjdk-openj9-alpine-jdk](https://github.com/nextgenhealthcare/connect-docker/blob/master/Dockerfile-adoptopenjdk-openj9-alpine-jdk)

<a name="quick-reference"></a>
# Quick reference [↑](#top)

#### Where to get help:
* [Connect Forum](https://www.mirthcorp.com/community/forums)
* [Slack Channel](https://mirthconnect.slack.com/)
* [Slack Registration](https://mirthconnect.herokuapp.com)

#### Where to file issues:
* https://github.com/nextgenhealthcare/connect-docker/issues

<a name="what-is-connect"></a>
# What is NextGen Connect (formerly Mirth Connect) [↑](#top)
An open-source message integration engine focused on healthcare. For more information please visit our [GitHub page](https://github.com/nextgenhealthcare/connect).

|   |   |
| ------------ | ------------ |
| ![](https://secure.gravatar.com/avatar/0ef900dca6d985a37122ff8db0a06cc2.jpg?s=160) | ![](https://github.com/nextgenhealthcare/connect/raw/development/server/public_html/images/mirthconnectlogowide.png) |

<a name="how-to-use"></a>
# How to use this image [↑](#top)
<a name="start-connect"></a>
## Start a Connect instance [↑](#top)
Quickly start Connect using embedded Derby database and all configuration defaults. At a minimum you will likely want to use the `-p` option to expose the 8443 port so that you can login with the Administrator GUI or CLI:

```bash
docker run -p 8443:8443 nextgenhealthcare/connect
```

You can also use the `--name` option to give your container a unique name, and the `-d` option to detach the container and run it in the background:

```bash
docker run --name myconnect -d -p 8443:8443 nextgenhealthcare/connect
```

To run a specific version of Connect, specify a tag at the end:

```bash
docker run --name myconnect -d -p 8443:8443 nextgenhealthcare/connect:3.8
```

Look at the [Environment Variables](#environment-variables) section for more available configuration options.

<a name="using-docker-compose"></a>
## Using [`docker stack deploy`](https://docs.docker.com/engine/reference/commandline/stack_deploy/) or [`docker-compose`](https://github.com/docker/compose) [↑](#top)

With `docker stack` or `docker-compose` you can easily setup and launch multiple related containers. For example you might want to launch both Connect *and* a PostgreSQL database to run alongside it.

```bash
docker-compose -f stack.yml up
```

Here's an example `stack.yml` file you can use:
```yaml
version: "3.1"
services:
  mc:
    image: nextgenhealthcare/connect
    environment:
      - DATABASE=postgres
      - DATABASE_URL=jdbc:postgresql://db:5432/mirthdb
      - DATABASE_MAX_CONNECTIONS=20
      - DATABASE_USERNAME=mirthdb
      - DATABASE_PASSWORD=mirthdb
      - KEYSTORE_STOREPASS=docker_storepass
      - KEYSTORE_KEYPASS=docker_keypass
      - VMOPTIONS=-Xmx512m
    ports:
      - 8080:8080/tcp
      - 8443:8443/tcp
    depends_on:
      - db
  db:
    image: postgres
    environment:
      - POSTGRES_USER=mirthdb
      - POSTGRES_PASSWORD=mirthdb
      - POSTGRES_DB=mirthdb
    expose:
      - 5432
```
[![Try in PWD](https://raw.githubusercontent.com/play-with-docker/stacks/master/assets/images/button.png)](http://play-with-docker.com/?stack=https://raw.githubusercontent.com/nextgenhealthcare/connect-docker/master/examples/play-with-docker-example.yml)

There are other example stack files in the [examples directory](https://github.com/nextgenhealthcare/connect-docker/tree/master/examples)!

<a name="environment-variables"></a>
## Environment Variables [↑](#top)
You can use environment variables to configure the [mirth.properties](https://github.com/nextgenhealthcare/connect/blob/development/server/conf/mirth.properties) file or to add custom JVM options. More information on the available mirth.properties options can be found in the [Connect User Guide](https://www.nextgen.com/-/media/Files/nextgen-connect/nextgen-connect-38-user-guide.pdf).

To set environment variables, use the `-e` option for each variable on the command line:

```bash
docker run -e DATABASE='derby' -p 8443:8443 nextgenhealthcare/connect
```

You can also use a separate file containing all of your environment variables using the `--env-file` option:

###### myenvfile.txt
```
DATABASE=postgres
DATABASE_URL=jdbc:postgresql://serverip:5432/mirthdb
DATABASE_USERNAME=postgres
DATABASE_PASSWORD=postgres
KEYSTORE_STOREPASS=changeme
KEYSTORE_KEYPASS=changeme
VMOPTIONS=-Xmx512m
```

```bash
docker run --env-file=myenvfile.txt -p 8443:8443 nextgenhealthcare/connect
```

<a name="common-mirth-properties-options"></a>
### Common mirth.properties options [↑](#top)

#### `DATABASE`

The database type to use for the NextGen Connect Integration Engine backend database. Options:
* derby
* mysql
* postgres
* oracle
* sqlserver

#### `DATABASE_URL`

The JDBC URL to use when connecting to the database. For example:
* `jdbc:postgresql://serverip:5432/mirthdb`

#### `DATABASE_USERNAME`

The username to use when connecting to the database. If you don't want to use an environment variable to store sensitive information like this, look at the [Using Docker Secrets](#using-docker-secrets) section below.

#### `DATABASE_PASSWORD`

The password to use when connecting to the database. If you don't want to use an environment variable to store sensitive information like this, look at the [Using Docker Secrets](#using-docker-secrets) section below.

#### `DATABASE_MAX_CONNECTIONS`

The maximum number of connections to use for the internal messaging engine connection pool.

#### `KEYSTORE_STOREPASS`

The password for the keystore file itself. If you don't want to use an environment variable to store sensitive information like this, look at the [Using Docker Secrets](#using-docker-secrets) section below.

#### `KEYSTORE_KEYPASS`

The password for the keys within the keystore, including the server certificate and the secret encryption key. If you don't want to use an environment variable to store sensitive information like this, look at the [Using Docker Secrets](#using-docker-secrets) section below.

#### `SESSION_STORE`

If set to true, the web server sessions are stored in the database. This can be useful in situations where you have multiple Connect servers (connecting to the same database) clustered behind a load balancer.

#### `VMOPTIONS`

A comma-separated list of JVM command-line options to place in the `.vmoptions` file. For example to set the max heap size:
* -Xmx512m

#### `DELAY`

This tells the entrypoint script to wait for a certain amount of time (in seconds). The entrypoint script will automatically use a command-line SQL client to check connectivity and wait until the database is up before starting Connect, but only when using PostgreSQL or MySQL. If you are using Oracle or SQL Server and the database is being started up at the same time as Connect, you may want to use this option to tell Connect to wait a bit to allow the database time to startup.

<a name="other-mirth-properties-options"></a>
### Other mirth.properties options [↑](#top)

Other options in the mirth.properties file can also be changed. Any environment variable starting with the `_MP_` prefix will set the corresponding value in mirth.properties. Replace `.` with a single underscore `_` and `-` with two underscores `__`.

Examples:

* Set the server TLS protocols to only allow TLSv1.2 and 1.3:
 * `_MP_HTTPS_SERVER_PROTOCOLS='TLSv1.3,TLSv1.2'`
* Set the max connections for the read-only database connection pool:
 * `_MP_DATABASE__READONLY_MAX__CONNECTIONS='20'`

<a name="using-docker-secrets"></a>
## Using Docker Secrets [↑](#top)

For sensitive information such as the database/keystore credentials, instead of supplying them as environment variables you can use a [Docker Secret](https://docs.docker.com/engine/swarm/secrets/). There are two secret names this image supports:

##### mirth_properties
If present, any properties in this secret will be merged into the mirth.properties file.
##### mcserver_vmoptions
If present, any JVM options in this secret will be appended onto the mcserver.vmoptions file.

Secrets are supported with [Docker Swarm](https://docs.docker.com/engine/swarm/secrets/), but you can also use them with [`docker-compose`](#using-docker-compose).

For example let's say you wanted to set `keystore.storepass` and `keystore.keypass` in a secure way. You could create a new file, **secret.properties**:
```
keystore.storepass=changeme
keystore.keypass=changeme
```
Then in your YAML docker-compose stack file:
```yaml
version: '3.1'
services:
  mc:
    image: nextgenhealthcare/connect
    environment:
      - VMOPTIONS=-Xmx512m
    secrets:
      - mirth_properties
    ports:
      - 8080:8080/tcp
      - 8443:8443/tcp
secrets:
  mirth_properties:
    file: /local/path/to/secret.properties
```
The **secrets** section at the bottom specifies the local file location for each secret.  Change `/local/path/to/secret.properties` to the correct local path and filename.

Inside the configuration for the Connect container there is also a **secrets** section that lists the secrets you want to include for that container.

<a name="using-volumes"></a>
## Using Volumes [↑](#top)

<a name="the-appdata-folder"></a>
#### The appdata folder [↑](#top)
The application data directory (appdata) stores configuration files and temporary data created by Connect after starting up. This usually includes the keystore file and the `server.id` file that stores your server ID. If you are launching Connect as part of a stack/swarm, it's possible the container filesystem is already being preserved. But if not, you may want to consider mounting a **volume** to preserve the appdata folder.

```bash
docker run -v /local/path/to/appdata:/opt/connect/appdata -p 8443:8443 nextgenhealthcare/connect
```
The `-v` option makes a local directory from your filesystem available to the Docker container. Create a folder on your local filesystem, then change the `/local/path/to/appdata` part in the example above to the correct local path.

You can also configure volumes as part of your docker-compose YAML stack file:
```yaml
version: '3.1'
services:
  mc:
    image: nextgenhealthcare/connect
    volumes:
      - ~/Documents/appdata:/opt/connect/appdata
```

<a name="custom-extensions"></a>
#### Custom extensions [↑](#top)
The entrypoint script will automatically look for any ZIP files in the `/opt/connect/custom-extensions` folder and unzip them into the extensions folder before Connect starts up. So to launch Connect with any custom extensions, do this:

```bash
docker run -v /local/path/to/custom-extensions:/opt/connect/custom-extensions -p 8443:8443 nextgenhealthcare/connect
```
Create a folder on your local filesystem containing the ZIP files for your custom extensions. Then change the `/local/path/to/custom-extensions` part in the example above to the correct local path.

As with the appdata example, you can also configure this volume as part of your docker-compose YAML file.

<a name="examples"></a>
# Examples [↑](#top)

TODO

<a name="license"></a>
# License [↑](#top)
The Dockerfiles, entrypoint script, and any other files used to build these Docker images are Copyright © NextGen Healthcare and licensed under the [Mozilla Public License 2.0](https://www.mozilla.org/en-US/MPL/2.0/).

NextGen Connect is released under the [Mozilla Public License 1.1](https://www.mozilla.org/en-US/MPL/1.1/). You can find a copy of the license in [server/docs/LICENSE.txt](https://github.com/nextgenhealthcare/connect/blob/development/server/docs/LICENSE.txt). All licensing information regarding third-party libraries is located in the [server/docs/thirdparty](https://github.com/nextgenhealthcare/connect/tree/development/server/docs/thirdparty) folder.