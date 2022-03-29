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
    * [Additional extensions](#additional-extensions)
* [License](#license)

------------

<a name="supported-tags"></a>
# Supported tags and respective Dockerfile links [↑](#top)

##### Oracle OpenJDK 11 (Debian)

* [4.0, 4.0.0, latest](https://github.com/nextgenhealthcare/connect-docker/blob/master/Dockerfile)
* [3.12, 3.12.0](https://github.com/nextgenhealthcare/connect-docker/blob/3.12.0/Dockerfile)
* [3.11, 3.11.0](https://github.com/nextgenhealthcare/connect-docker/blob/3.11.0/Dockerfile)
* [3.10, 3.10.1](https://github.com/nextgenhealthcare/connect-docker/blob/3.10.1/Dockerfile)
* [3.10.0](https://github.com/nextgenhealthcare/connect-docker/blob/3.10.0/Dockerfile)
* [3.9, 3.9.1](https://github.com/nextgenhealthcare/connect-docker/blob/3.9.1/Dockerfile)
* [3.9.0](https://github.com/nextgenhealthcare/connect-docker/blob/3.9.0/Dockerfile)
* [3.8, 3.8.1](https://github.com/nextgenhealthcare/connect-docker/blob/3.8.1/Dockerfile)
* [3.8.0](https://github.com/nextgenhealthcare/connect-docker/blob/3.8.0/Dockerfile)

##### Oracle OpenJDK 11 with full JDK

* [4.0-jdk, 4.0.0-jdk, latest-jdk](https://github.com/nextgenhealthcare/connect-docker/blob/master/Dockerfile-jdk)
* [3.12-jdk, 3.12.0-jdk](https://github.com/nextgenhealthcare/connect-docker/blob/3.12.0/Dockerfile-jdk)
* [3.11-jdk, 3.11.0-jdk](https://github.com/nextgenhealthcare/connect-docker/blob/3.11.0/Dockerfile-jdk)
* [3.10-jdk, 3.10.1-jdk](https://github.com/nextgenhealthcare/connect-docker/blob/3.10.1/Dockerfile-jdk)
* [3.10.0-jdk](https://github.com/nextgenhealthcare/connect-docker/blob/3.10.0/Dockerfile-jdk)
* [3.9-jdk, 3.9.1-jdk](https://github.com/nextgenhealthcare/connect-docker/blob/3.9.1/Dockerfile-jdk)
* [3.9.0-jdk](https://github.com/nextgenhealthcare/connect-docker/blob/3.9.0/Dockerfile-jdk)
* [3.8-jdk, 3.8.1-jdk](https://github.com/nextgenhealthcare/connect-docker/blob/3.8.1/Dockerfile-jdk)
* [3.8.0-jdk](https://github.com/nextgenhealthcare/connect-docker/blob/3.8.0/Dockerfile-jdk)

##### Zulu OpenJDK 11 (Alpine Linux)

* [4.0-zulu-alpine, 4.0.0-zulu-alpine, latest-zulu-alpine](https://github.com/nextgenhealthcare/connect-docker/blob/master/Dockerfile-zulu-alpine)
* [3.12-zulu-alpine, 3.12.0-zulu-alpine](https://github.com/nextgenhealthcare/connect-docker/blob/3.12.0/Dockerfile-zulu-alpine)
* [3.11-zulu-alpine, 3.11.0-zulu-alpine](https://github.com/nextgenhealthcare/connect-docker/blob/3.11.0/Dockerfile-zulu-alpine)
* [3.10-zulu-alpine, 3.10.1-zulu-alpine](https://github.com/nextgenhealthcare/connect-docker/blob/3.10.1/Dockerfile-zulu-alpine)
* [3.10.0-zulu-alpine](https://github.com/nextgenhealthcare/connect-docker/blob/3.10.0/Dockerfile-zulu-alpine)
* [3.9-zulu-alpine, 3.9.1-zulu-alpine](https://github.com/nextgenhealthcare/connect-docker/blob/3.9.1/Dockerfile-zulu-alpine)
* [3.9.0-zulu-alpine](https://github.com/nextgenhealthcare/connect-docker/blob/3.9.0/Dockerfile-zulu-alpine)
* [3.8-zulu-alpine, 3.8.1-zulu-alpine](https://github.com/nextgenhealthcare/connect-docker/blob/3.8.1/Dockerfile-zulu-alpine)
* [3.8.0-zulu-alpine](https://github.com/nextgenhealthcare/connect-docker/blob/3.8.0/Dockerfile-zulu-alpine)

##### Zulu OpenJDK 11 with full JDK

* [4.0-zulu-alpine-jdk, 4.0.0-zulu-alpine-jdk, latest-zulu-alpine-jdk](https://github.com/nextgenhealthcare/connect-docker/blob/master/Dockerfile-zulu-alpine-jdk)
* [3.12-zulu-alpine-jdk, 3.12.0-zulu-alpine-jdk](https://github.com/nextgenhealthcare/connect-docker/blob/3.12.0/Dockerfile-zulu-alpine-jdk)
* [3.11-zulu-alpine-jdk, 3.11.0-zulu-alpine-jdk](https://github.com/nextgenhealthcare/connect-docker/blob/3.11.0/Dockerfile-zulu-alpine-jdk)
* [3.10-zulu-alpine-jdk, 3.10.1-zulu-alpine-jdk](https://github.com/nextgenhealthcare/connect-docker/blob/3.10.1/Dockerfile-zulu-alpine-jdk)
* [3.10.0-zulu-alpine-jdk](https://github.com/nextgenhealthcare/connect-docker/blob/3.10.0/Dockerfile-zulu-alpine-jdk)
* [3.9-zulu-alpine-jdk, 3.9.1-zulu-alpine-jdk](https://github.com/nextgenhealthcare/connect-docker/blob/3.9.1/Dockerfile-zulu-alpine-jdk)
* [3.9.0-zulu-alpine-jdk](https://github.com/nextgenhealthcare/connect-docker/blob/3.9.0/Dockerfile-zulu-alpine-jdk)
* [3.8-zulu-alpine-jdk, 3.8.1-zulu-alpine-jdk](https://github.com/nextgenhealthcare/connect-docker/blob/3.8.1/Dockerfile-zulu-alpine-jdk)
* [3.8.0-zulu-alpine-jdk](https://github.com/nextgenhealthcare/connect-docker/blob/3.8.0/Dockerfile-zulu-alpine-jdk)

##### AdoptOpenJDK 11 with OpenJ9 (Alpine Linux)

* [4.0-adoptopenjdk-openj9-alpine, 4.0.0-adoptopenjdk-openj9-alpine, latest-adoptopenjdk-openj9-alpine](https://github.com/nextgenhealthcare/connect-docker/blob/master/Dockerfile-adoptopenjdk-openj9-alpine)
* [3.12-adoptopenjdk-openj9-alpine, 3.12.0-adoptopenjdk-openj9-alpine](https://github.com/nextgenhealthcare/connect-docker/blob/3.12.0/Dockerfile-adoptopenjdk-openj9-alpine)
* [3.11-adoptopenjdk-openj9-alpine, 3.11.0-adoptopenjdk-openj9-alpine](https://github.com/nextgenhealthcare/connect-docker/blob/3.11.0/Dockerfile-adoptopenjdk-openj9-alpine)
* [3.10-adoptopenjdk-openj9-alpine, 3.10.1-adoptopenjdk-openj9-alpine](https://github.com/nextgenhealthcare/connect-docker/blob/3.10.1/Dockerfile-adoptopenjdk-openj9-alpine)
* [3.10.0-adoptopenjdk-openj9-alpine](https://github.com/nextgenhealthcare/connect-docker/blob/3.10.0/Dockerfile-adoptopenjdk-openj9-alpine)
* [3.9-adoptopenjdk-openj9-alpine, 3.9.1-adoptopenjdk-openj9-alpine](https://github.com/nextgenhealthcare/connect-docker/blob/3.9.1/Dockerfile-adoptopenjdk-openj9-alpine)
* [3.9.0-adoptopenjdk-openj9-alpine](https://github.com/nextgenhealthcare/connect-docker/blob/3.9.0/Dockerfile-adoptopenjdk-openj9-alpine)
* [3.8-adoptopenjdk-openj9-alpine, 3.8.1-adoptopenjdk-openj9-alpine](https://github.com/nextgenhealthcare/connect-docker/blob/3.8.1/Dockerfile-adoptopenjdk-openj9-alpine)
* [3.8.0-adoptopenjdk-openj9-alpine](https://github.com/nextgenhealthcare/connect-docker/blob/3.8.0/Dockerfile-adoptopenjdk-openj9-alpine)

##### AdoptOpenJDK 11 with OpenJ9 and full JDK

* [4.0-adoptopenjdk-openj9-alpine-jdk, 4.0.0-adoptopenjdk-openj9-alpine-jdk, latest-adoptopenjdk-openj9-alpine-jdk](https://github.com/nextgenhealthcare/connect-docker/blob/master/Dockerfile-adoptopenjdk-openj9-alpine-jdk)
* [3.12-adoptopenjdk-openj9-alpine-jdk, 3.12.0-adoptopenjdk-openj9-alpine-jdk](https://github.com/nextgenhealthcare/connect-docker/blob/3.12.0/Dockerfile-adoptopenjdk-openj9-alpine-jdk)
* [3.11-adoptopenjdk-openj9-alpine-jdk, 3.11.0-adoptopenjdk-openj9-alpine-jdk](https://github.com/nextgenhealthcare/connect-docker/blob/3.11.0/Dockerfile-adoptopenjdk-openj9-alpine-jdk)
* [3.10-adoptopenjdk-openj9-alpine-jdk, 3.10.1-adoptopenjdk-openj9-alpine-jdk](https://github.com/nextgenhealthcare/connect-docker/blob/3.10.1/Dockerfile-adoptopenjdk-openj9-alpine-jdk)
* [3.10.0-adoptopenjdk-openj9-alpine-jdk](https://github.com/nextgenhealthcare/connect-docker/blob/3.10.0/Dockerfile-adoptopenjdk-openj9-alpine-jdk)
* [3.9-adoptopenjdk-openj9-alpine-jdk, 3.9.1-adoptopenjdk-openj9-alpine-jdk](https://github.com/nextgenhealthcare/connect-docker/blob/3.9.1/Dockerfile-adoptopenjdk-openj9-alpine-jdk)
* [3.9.0-adoptopenjdk-openj9-alpine-jdk](https://github.com/nextgenhealthcare/connect-docker/blob/3.9.0/Dockerfile-adoptopenjdk-openj9-alpine-jdk)
* [3.8-adoptopenjdk-openj9-alpine-jdk, 3.8.1-adoptopenjdk-openj9-alpine-jdk](https://github.com/nextgenhealthcare/connect-docker/blob/3.8.1/Dockerfile-adoptopenjdk-openj9-alpine-jdk)
* [3.8.0-adoptopenjdk-openj9-alpine-jdk](https://github.com/nextgenhealthcare/connect-docker/blob/3.8.0/Dockerfile-adoptopenjdk-openj9-alpine-jdk)

------------

<a name="quick-reference"></a>
# Quick Reference [↑](#top)

#### Where to get help:

* [Connect User Guide](http://downloads.mirthcorp.com/connect-user-guide/latest/mirth-connect-user-guide.pdf)
* [Connect Forum](https://www.mirthcorp.com/community/forums)
* [Slack Channel](https://mirthconnect.slack.com/) (register [here](https://mirthconnect.herokuapp.com))
* [Connect GitHub](https://github.com/nextgenhealthcare/connect)
* [Connect Docker GitHub](https://github.com/nextgenhealthcare/connect-docker)

#### Where to file issues:

* For issues relating to these Docker images:
  * https://github.com/nextgenhealthcare/connect-docker/issues
* For issues relating to the Connect application itself:
  * http://www.mirthcorp.com/community/issues

------------

<a name="what-is-connect"></a>
# What is NextGen Connect (formerly Mirth Connect) [↑](#top)

An open-source message integration engine focused on healthcare. For more information please visit our [GitHub page](https://github.com/nextgenhealthcare/connect).

<table><tr><td><img src="https://secure.gravatar.com/avatar/0ef900dca6d985a37122ff8db0a06cc2.jpg?s=160"/></td><td><img src="https://github.com/nextgenhealthcare/connect/raw/development/server/public_html/images/mirthconnectlogowide.png"/></td></tr></table>

------------

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
docker run --name myconnect -d -p 8443:8443 nextgenhealthcare/connect:3.9
```

Look at the [Environment Variables](#environment-variables) section for more available configuration options.

------------

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
      - DATABASE_MAX_RETRY=2
      - DATABASE_RETRY_WAIT=10000
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

Try it out with Play With Docker! Note that in order to access the 8080/8443 ports from your workstation, follow [their guide](https://github.com/play-with-docker/play-with-docker#how-can-i-connect-to-a-published-port-from-the-outside-world) to format the URL correctly. When you login via the Administrator GUI, use port 443 on the end instead of 8443.

There are other example stack files in the [examples directory](https://github.com/nextgenhealthcare/connect-docker/tree/master/examples)!

------------

<a name="environment-variables"></a>
## Environment Variables [↑](#top)

You can use environment variables to configure the [mirth.properties](https://github.com/nextgenhealthcare/connect/blob/development/server/conf/mirth.properties) file or to add custom JVM options. More information on the available mirth.properties options can be found in the [Connect User Guide](http://downloads.mirthcorp.com/connect-user-guide/latest/mirth-connect-user-guide.pdf).

To set environment variables, use the `-e` option for each variable on the command line:

```bash
docker run -e DATABASE='derby' -p 8443:8443 nextgenhealthcare/connect
```

You can also use a separate file containing all of your environment variables using the `--env-file` option. For example let's say you create a file **myenvfile.txt**:

```bash
DATABASE=postgres
DATABASE_URL=jdbc:postgresql://serverip:5432/mirthdb
DATABASE_USERNAME=postgres
DATABASE_PASSWORD=postgres
DATABASE_MAX_RETRY=2
DATABASE_RETRY_WAIT=10000
KEYSTORE_STOREPASS=changeme
KEYSTORE_KEYPASS=changeme
VMOPTIONS=-Xmx512m
```

```bash
docker run --env-file=myenvfile.txt -p 8443:8443 nextgenhealthcare/connect
```

------------

<a name="common-mirth-properties-options"></a>
### Common mirth.properties options [↑](#top)

<a name="env-database"></a>
#### `DATABASE`

The database type to use for the NextGen Connect Integration Engine backend database. Options:

* derby
* mysql
* postgres
* oracle
* sqlserver

<a name="env-database-url"></a>
#### `DATABASE_URL`

The JDBC URL to use when connecting to the database. For example:
* `jdbc:postgresql://serverip:5432/mirthdb`

<a name="env-database-username"></a>
#### `DATABASE_USERNAME`

The username to use when connecting to the database. If you don't want to use an environment variable to store sensitive information like this, look at the [Using Docker Secrets](#using-docker-secrets) section below.

<a name="env-database-password"></a>
#### `DATABASE_PASSWORD`

The password to use when connecting to the database. If you don't want to use an environment variable to store sensitive information like this, look at the [Using Docker Secrets](#using-docker-secrets) section below.

<a name="env-database-max-connections"></a>
#### `DATABASE_MAX_CONNECTIONS`

The maximum number of connections to use for the internal messaging engine connection pool.

<a name="env-database-max-retry"></a>
#### `DATABASE_MAX_RETRY`

On startup, if a database connection cannot be made for any reason, Connect will wait and attempt again this number of times. By default, will retry 2 times (so 3 total attempts).

<a name="env-database-retry-wait"></a>
#### `DATABASE_RETRY_WAIT`

The amount of time (in milliseconds) to wait between database connection attempts. By default, will wait 10 seconds between attempts.

<a name="env-keystore-storepass"></a>
#### `KEYSTORE_STOREPASS`

The password for the keystore file itself. If you don't want to use an environment variable to store sensitive information like this, look at the [Using Docker Secrets](#using-docker-secrets) section below.

<a name="env-keystore-keypass"></a>
#### `KEYSTORE_KEYPASS`

The password for the keys within the keystore, including the server certificate and the secret encryption key. If you don't want to use an environment variable to store sensitive information like this, look at the [Using Docker Secrets](#using-docker-secrets) section below.

<a name="env-keystore-type"></a>
#### `KEYSTORE_TYPE`

The type of keystore.

<a name="env-session-store"></a>
#### `SESSION_STORE`

If set to true, the web server sessions are stored in the database. This can be useful in situations where you have multiple Connect servers (connecting to the same database) clustered behind a load balancer.

<a name="env-vmoptions"></a>
#### `VMOPTIONS`

A comma-separated list of JVM command-line options to place in the `.vmoptions` file. For example to set the max heap size:

* -Xmx512m

<a name="env-delay"></a>
#### `DELAY`

This tells the entrypoint script to wait for a certain amount of time (in seconds). The entrypoint script will automatically use a command-line SQL client to check connectivity and wait until the database is up before starting Connect, but only when using PostgreSQL or MySQL. If you are using Oracle or SQL Server and the database is being started up at the same time as Connect, you may want to use this option to tell Connect to wait a bit to allow the database time to startup.

<a name="env-keystore-download"></a>
#### `KEYSTORE_DOWNLOAD`

A URL location of a Connect keystore file. This file will be downloaded into the container and Connect will use it as its keystore.

<a name ="env-extensions-download"></a>
#### `EXTENSIONS_DOWNLOAD`

A URL location of a zip file containing Connect extension zip files. The extensions will be installed on the Connect server.

<a name ="env-custom-jars-download"></a>
#### `CUSTOM_JARS_DOWNLOAD`

A URL location of a zip file containing JAR files. The JAR files will be installed into the `server-launcher-lib` folder on the Connect server, so they will be added to the server's classpath.

<a name="env-allow-insecure"></a>
#### `ALLOW_INSECURE`

Allow insecure SSL connections when downloading files during startup. This applies to keystore downloads, plugin downloads, and server library downloads. By default, insecure connections are disabled but you can enable this option by setting `ALLOW_INSECURE=true`.

------------

<a name="other-mirth-properties-options"></a>
### Other mirth.properties options [↑](#top)

Other options in the mirth.properties file can also be changed. Any environment variable starting with the `_MP_` prefix will set the corresponding value in mirth.properties. Replace `.` with a single underscore `_` and `-` with two underscores `__`.

Examples:

* Set the server TLS protocols to only allow TLSv1.2 and 1.3:
  * In the mirth.properties file:
    * `https.server.protocols = TLSv1.3,TLSv1.2`
  * As a Docker environment variable:
    * `_MP_HTTPS_SERVER_PROTOCOLS='TLSv1.3,TLSv1.2'`

* Set the max connections for the read-only database connection pool:
  * In the mirth.properties file:
    * `database-readonly.max-connections = 20`
  * As a Docker environment variable:
    * `_MP_DATABASE__READONLY_MAX__CONNECTIONS='20'`

------------

<a name="using-docker-secrets"></a>
## Using Docker Secrets [↑](#top)

For sensitive information such as the database/keystore credentials, instead of supplying them as environment variables you can use a [Docker Secret](https://docs.docker.com/engine/swarm/secrets/). There are two secret names this image supports:

##### mirth_properties

If present, any properties in this secret will be merged into the mirth.properties file.

##### mcserver_vmoptions

If present, any JVM options in this secret will be appended onto the mcserver.vmoptions file.

------------

Secrets are supported with [Docker Swarm](https://docs.docker.com/engine/swarm/secrets/), but you can also use them with [`docker-compose`](#using-docker-compose).

For example let's say you wanted to set `keystore.storepass` and `keystore.keypass` in a secure way. You could create a new file, **secret.properties**:

```bash
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

------------

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

------------

<a name="additional-extensions"></a>
#### Additional extensions [↑](#top)

The entrypoint script will automatically look for any ZIP files in the `/opt/connect/custom-extensions` folder and unzip them into the extensions folder before Connect starts up. So to launch Connect with any additional extensions not included in the base application, do this:

```bash
docker run -v /local/path/to/custom-extensions:/opt/connect/custom-extensions -p 8443:8443 nextgenhealthcare/connect
```

Create a folder on your local filesystem containing the ZIP files for your additional extensions. Then change the `/local/path/to/custom-extensions` part in the example above to the correct local path.

As with the appdata example, you can also configure this volume as part of your docker-compose YAML file.

------------

## Known Limitations

Currently, only the Debian flavored images support the newest authentication scheme in MySQL 8. All others (the Alpine based images) will need the following to force the MySQL database container to start using the old authentication scheme:

```yaml
command: --default-authentication-plugin=mysql_native_password
```

Example:

```yaml
  db:
    image: mysql
    command: --default-authentication-plugin=mysql_native_password
    environment:
      ...
```

------------

<a name="license"></a>
# License [↑](#top)

The Dockerfiles, entrypoint script, and any other files used to build these Docker images are Copyright © NextGen Healthcare and licensed under the [Mozilla Public License 2.0](https://www.mozilla.org/en-US/MPL/2.0/).

You can find a copy of the NextGen Connect license in [server/docs/LICENSE.txt](https://github.com/nextgenhealthcare/connect/blob/development/server/docs/LICENSE.txt). All licensing information regarding third-party libraries is located in the [server/docs/thirdparty](https://github.com/nextgenhealthcare/connect/tree/development/server/docs/thirdparty) folder.
