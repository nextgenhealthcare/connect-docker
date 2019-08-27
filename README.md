# Supported tags and respective Dockerfile links

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

# Quick reference

#### Where to get help:
* [Connect Forum](https://www.mirthcorp.com/community/forums)
* [Slack Channel](https://mirthconnect.slack.com/)
* [Slack Registration](https://mirthconnect.herokuapp.com)

#### Where to file issues:
* https://github.com/nextgenhealthcare/connect-docker/issues

# What is NextGen Connect (formerly Mirth Connect)
An open-source message integration engine focused on healthcare. For more information please visit our [GitHub page](https://github.com/nextgenhealthcare/connect).
![](https://secure.gravatar.com/avatar/0ef900dca6d985a37122ff8db0a06cc2.jpg?s=160) ![](https://github.com/nextgenhealthcare/connect/raw/development/server/public_html/images/mirthconnectlogowide.png)

# How to use this image
## Start a Connect instance
Quickly start Connect using embedded Derby database and all default configurations 

`$docker run --name myconnectinstance -d connect:latest`

... where ...

## Custom Configuration
### using *Environment Variables*

### using *docker-compose*

### using secret

## Environment Variables 

# License
The Dockerfiles, entrypoint script, and any other files used to build these Docker images are Copyright © NextGen Healthcare and licensed under the [Mozilla Public License 2.0](https://www.mozilla.org/en-US/MPL/2.0/).

NextGen Connect is released under the [Mozilla Public License 1.1](https://www.mozilla.org/en-US/MPL/1.1/). You can find a copy of the license in [server/docs/LICENSE.txt](https://github.com/nextgenhealthcare/connect/blob/development/server/docs/LICENSE.txt). All licensing information regarding third-party libraries is located in the [server/docs/thirdparty](https://github.com/nextgenhealthcare/connect/tree/development/server/docs/thirdparty) folder.