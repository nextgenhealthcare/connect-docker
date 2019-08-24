

docker run -p 8443:8443 -v ~/Downloads/test_appdata:/opt/connect/appdata -e VMOPTIONS=-Xmx512m,-Xmx768m nextgenconnect-public:3.8

options:

-v <path_to_local_appdata>:/opt/connect/appdata
-v <path_to_local_custom_extensions>:/opt/connect/custom-extensions
-e VMOPTIONS=<vmoption1>,<vmoption2>,etc
-e _MP_PROPERTY=property value

-e DATABASE=database type
-e DATABASE_USERNAME
-e DATABASE_PASSWORD
-e DATABASE_URL
-e DATABASE_MAX_CONNECTIONS
-e KEYSTORE_STOREPASS
-e KEYSTORE_KEYPASS
-e LICENSE_KEY
-e SESSION_STORE

-e DELAY=30 wait 30 seconds before trying to connect to db

--secret mirth.properties
--secret mcserver.vmoptions
