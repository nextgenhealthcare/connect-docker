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

TODO

<a name="environment-variables"></a>
## Environment Variables [↑](#top)
You can use environment variables to configure the [mirth.properties](https://github.com/nextgenhealthcare/connect/blob/development/server/conf/mirth.properties) file or to add custom JVM options. More information on the available mirth.properties options can be found in the [Connect User Guide](https://www.nextgen.com/-/media/Files/nextgen-connect/nextgen-connect-38-user-guide.pdf).

TODO

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

<a name="other-mirth-properties-options"></a>
### Other mirth.properties options [↑](#top)

TODO

<a name="using-docker-secrets"></a>
## Using Docker Secrets [↑](#top)

TODO

<a name="using-volumes"></a>
## Using Volumes [↑](#top)

TODO

<a name="examples"></a>
# Examples [↑](#top)

TODO

<a name="license"></a>
# License [↑](#top)
The Dockerfiles, entrypoint script, and any other files used to build these Docker images are Copyright © NextGen Healthcare and licensed under the [Mozilla Public License 2.0](https://www.mozilla.org/en-US/MPL/2.0/).

NextGen Connect is released under the [Mozilla Public License 1.1](https://www.mozilla.org/en-US/MPL/1.1/). You can find a copy of the license in [server/docs/LICENSE.txt](https://github.com/nextgenhealthcare/connect/blob/development/server/docs/LICENSE.txt). All licensing information regarding third-party libraries is located in the [server/docs/thirdparty](https://github.com/nextgenhealthcare/connect/tree/development/server/docs/thirdparty) folder.