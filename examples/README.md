# Examples
* [postgres-with-volume.yml](#postgres-with-volume.yml)
* [mysql-with-volume.yml](#mysql-with-volume.yml)
* [derby-with-volumes-and-secrets.yml](#derby-with-volumes-and-secrets.yml)
* [postgres-with-2-connect-servers-in-cluster.yml](#postgres-with-2-connect-servers-in-cluster.yml)
* [play-with-docker-example.yml](#play-with-docker-example.yml)

------------

<a name="postgres-with-volume.yml"></a>
### postgres-with-volume.yml
This stack launches Connect along with a PostgreSQL database. It also mounts a volume for the appdata folder so that the server ID / keystore file are preserved.

If you want you can edit the stack file and change the location of the appdata volume:
```yaml
    volumes:
      - ./data/volumes/appdata:/opt/connect/appdata
```

Then use [docker-compose](https://docs.docker.com/compose/) to launch:
```bash
docker-compose -f examples/postgres-with-volume.yml up
```

------------

<a name="mysql-with-volume.yml"></a>
### mysql-with-volume.yml
This stack launches Connect along with a MySQL database. It also mounts a volume for the appdata folder so that the server ID / keystore file are preserved.

If you want you can edit the stack file and change the location of the appdata volume:
```yaml
    volumes:
      - ./data/volumes/appdata:/opt/connect/appdata
```

Then use [docker-compose](https://docs.docker.com/compose/) to launch:
```bash
docker-compose -f examples/mysql-with-volume.yml up
```

------------

<a name="derby-with-volumes-and-secrets.yml"></a>
### derby-with-volumes-and-secrets.yml
This stack launches Connect using its embedded Apache Derby database. It mounts a volume for the appdata folder so that the Derby database, server ID, and keystore file are preserved. It also mounts another `custom-extensions` volume to allow additional extensions (such as our [FHIR Connector](https://www.mirthcorp.com/community/wiki/pages/viewpage.action?pageId=36504815)) to be automatically installed. This file also demonstrates how to use [Docker Secrets](https://docs.docker.com/engine/swarm/secrets/) with docker-compose.

If you want you can edit the stack file and change the volume/secret locations:
```yaml
    volumes:
      - ./data/volumes/appdata:/opt/connect/appdata
      - ./data/volumes/custom-extensions:/opt/connect/custom-extensions
```
```yaml
secrets:
  mirth_properties:
    file: ./data/secret.properties
  mcserver_vmoptions:
    file: ./data/secret.vmoptions
```
To test installing an extension, you can download the [FHIR Connector](https://www.mirthcorp.com/community/wiki/pages/viewpage.action?pageId=36504815) extension and place the ZIP file into the `examples/data/volumes/custom-extensions` folder.

Any properties you put in the `examples/data/secret.properties` file will be merged into mirth.properties. By default this file contains:
```
keystore.storepass = docker_storepass
keystore.keypass = docker_keypass
```
Any entries you put in the `examples/data/secret.vmoptions` file will be appended to the `mcserver.vmoptions` file inside the container. You can use this to set sensitive Java System properties like so:
```
-Dmy.secret.property=thepassword
```

Finally, use [docker-compose](https://docs.docker.com/compose/) to launch:
```bash
docker-compose -f examples/derby-with-volumes-and-secrets.yml up
```

------------

<a name="postgres-with-2-connect-servers-in-cluster.yml"></a>
### postgres-with-2-connect-servers-in-cluster.yml
This stack launches two clustered Connect servers along with a PostgreSQL database. It mounts volumes for the appdata folders for both servers, and also launches a load balancer ([HAProxy](https://hub.docker.com/_/haproxy)) to forward requests to both Connect servers.

If you want you can edit the stack file and change the volume locations:
```yaml
    volumes:
      - ./data/volumes/appdata1:/opt/connect/appdata
...
    volumes:
      - ./data/volumes/appdata2:/opt/connect/appdata
```

Then use [docker-compose](https://docs.docker.com/compose/) to launch:
```bash
docker-compose -f examples/postgres-with-2-connect-servers-in-cluster.yml up
```

Once both servers come online, you can login using the Administrator GUI to the load balanced 8443 port, or you can login specifically to the `mc1` node on the 8441 port, or the `mc2` node on the 8442 port.

The environment also load balances on port 9001, so you can test by creating an HTTP Listener channel on that port and deploying it on both servers. Then you can send requests to `http://localhost:9001` on your local workstation, and you should see that the requests get round-robin load balanced to both servers.

------------

<a name="play-with-docker-example.yml"></a>
### play-with-docker-example.yml
This example file can be used to launch a Connect instance and PostgreSQL database using the [Play With Docker](https://github.com/play-with-docker/play-with-docker) framework. Just click the button below to launch:

[![Try in PWD](https://raw.githubusercontent.com/play-with-docker/stacks/master/assets/images/button.png)](http://play-with-docker.com/?stack=https://raw.githubusercontent.com/nextgenhealthcare/connect-docker/master/examples/play-with-docker-example.yml)

Note that in order to access the 8080/8443 ports from your workstation, follow [their guide](https://github.com/play-with-docker/play-with-docker#how-can-i-connect-to-a-published-port-from-the-outside-world) to format the URL correctly. When you login via the Administrator GUI, use port 443 on the end instead of 8443.