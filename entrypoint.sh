#!/bin/bash
set -e

custom_extension_count=`ls -1 /opt/connect/custom-extensions/*.zip 2>/dev/null | wc -l`
if [ $custom_extension_count != 0 ]; then
	echo "Found ${custom_extension_count} custom extensions."
	for extension in $(ls -1 /opt/connect/custom-extensions/*.zip); do
		unzip -o -q $extension -d /opt/connect/extensions
	done
fi

# set storepass and keypass to 'changeme' so they aren't overwritten later
KEYSTORE_PASS=changeme
sed -i "s/^keystore\.storepass\s*=\s*.*\$/keystore.storepass = ${KEYSTORE_PASS//\//\\/}/" /opt/connect/conf/mirth.properties
sed -i "s/^keystore\.keypass\s*=\s*.*\$/keystore.keypass = ${KEYSTORE_PASS//\//\\/}/" /opt/connect/conf/mirth.properties

# merge the environment variables into /opt/connect/conf/mirth.properties
# db type
if ! [ -z "${DATABASE+x}" ]; then
	sed -i "s/^database\s*=\s*.*\$/database = ${DATABASE//\//\\/}/" /opt/connect/conf/mirth.properties
fi

# db username
if ! [ -z "${DATABASE_USERNAME+x}" ]; then
	sed -i "s/^database\.username\s*=\s*.*\$/database.username = ${DATABASE_USERNAME//\//\\/}/" /opt/connect/conf/mirth.properties
fi

# db password
if ! [ -z "${DATABASE_PASSWORD+x}" ]; then
	sed -i "s/^database\.password\s*=\s*.*\$/database.password = ${DATABASE_PASSWORD//\//\\/}/" /opt/connect/conf/mirth.properties
fi

# db url
if ! [ -z "${DATABASE_URL+x}" ]; then
	sed -i "s/^database\.url\s*=\s*.*\$/database.url = ${DATABASE_URL//\//\\/}/" /opt/connect/conf/mirth.properties
fi

# database max connections
if ! [ -z "${DATABASE_MAX_CONNECTIONS+x}" ]; then
	sed -i "s/^database\.max-connections\s*=\s*.*\$/database.max-connections = ${DATABASE_MAX_CONNECTIONS//\//\\/}/" /opt/connect/conf/mirth.properties
fi

# keystore storepass
if ! [ -z "${KEYSTORE_STOREPASS+x}" ]; then
	sed -i "s/^keystore\.storepass\s*=\s*.*\$/keystore.storepass = ${KEYSTORE_STOREPASS//\//\\/}/" /opt/connect/conf/mirth.properties
fi

# keystore keypass
if ! [ -z "${KEYSTORE_KEYPASS+x}" ]; then
	sed -i "s/^keystore\.keypass\s*=\s*.*\$/keystore.keypass = ${KEYSTORE_KEYPASS//\//\\/}/" /opt/connect/conf/mirth.properties
fi

# license key
if ! [ -z "${LICENSE_KEY+x}" ]; then
	LINE_COUNT=`grep "license.key" /opt/connect/conf/mirth.properties | wc -l`
	if [ $LINE_COUNT -lt 1 ]; then
		echo -e "\nlicense.key = ${LICENSE_KEY//\//\\/}" >> /opt/connect/conf/mirth.properties
	else
		sed -i "s/^license\.key\s*=\s*.*\$/license.key = ${LICENSE_KEY//\//\\/}/" /opt/connect/conf/mirth.properties
	fi
fi

# session store
if ! [ -z "${SESSION_STORE+x}" ]; then
	LINE_COUNT=`grep "server.api.sessionstore" /opt/connect/conf/mirth.properties | wc -l`
	if [ $LINE_COUNT -lt 1 ]; then
		echo -e "\nserver.api.sessionstore = ${SESSION_STORE//\//\\/}" >> /opt/connect/conf/mirth.properties
	else
		sed -i "s/^server\.api\.sessionstore\s*=\s*.*\$/server.api.sessionstore = ${SESSION_STORE//\//\\/}/" /opt/connect/conf/mirth.properties
	fi
fi

# merge extra environment variables starting with _MP_ into mirth.properties
while read -r keyvalue; do
	KEY="${keyvalue%%=*}"
	VALUE="${keyvalue#*=}"
	VALUE=$(tr -dc '\40-\176' <<< "$VALUE")

	if ! [ -z "${KEY}" ] && ! [ -z "${VALUE}" ] && ! [[ ${VALUE} =~ ^\ +$ ]]; then

		# filter for variables starting with "_MP_"
		if [[ ${KEY} == _MP_* ]]; then

			# echo "found mirth property ${KEY}=${VALUE}"

			# example: _MP_DATABASE_MAX__CONNECTIONS -> database.max-connections

			# remove _MP_
			# example:  DATABASE_MAX__CONNECTIONS
			ACTUAL_KEY=${KEY:4}

			# switch '__' to '-'
			# example:  DATABASE_MAX-CONNECTIONS
			ACTUAL_KEY="${ACTUAL_KEY//__/-}"

			# switch '_' to '.'
			# example:  DATABASE.MAX-CONNECTIONS
			ACTUAL_KEY="${ACTUAL_KEY//_/.}"

			# lower case
			# example:  database.max-connections
			ACTUAL_KEY="${ACTUAL_KEY,,}"

			# if key does not exist in mirth.properties append it at bottom
			LINE_COUNT=`grep "^${ACTUAL_KEY}" /opt/connect/conf/mirth.properties | wc -l`
			if [ $LINE_COUNT -lt 1 ]; then
				# echo "key ${ACTUAL_KEY} not found in mirth.properties, appending. Value = ${VALUE}"
				echo -e "\n${ACTUAL_KEY} = ${VALUE//\//\\/}" >> /opt/connect/conf/mirth.properties
			else # otherwise key exists, overwrite it
				# echo "key ${ACTUAL_KEY} exists, overwriting. Value = ${VALUE}"
				ESCAPED_KEY="${ACTUAL_KEY//./\\.}"
				sed -i "s/^${ESCAPED_KEY}\s*=\s*.*\$/${ACTUAL_KEY} = ${VALUE//\//\\/}/" /opt/connect/conf/mirth.properties
			fi
		fi
	fi
done <<< "`printenv`"

cp mcserver_base.vmoptions mcserver.vmoptions

# Address reflective access by Jackson
echo "--add-opens=java.desktop/java.awt.color=ALL-UNNAMED" >> mcserver.vmoptions

# merge vmoptions into /opt/connect/mcserver.vmoptions
if ! [ -z "${VMOPTIONS+x}" ]; then
    PREV_IFS="$IFS"
	IFS=","
	read -ra vmoptions <<< "$VMOPTIONS"
	IFS="$PREV_IFS"

    for vmoption in "${vmoptions[@]}"
    do
        echo "${vmoption}" >> /opt/connect/mcserver.vmoptions
    done
fi

# merge the user's secret mirth.properties
# takes a whole mirth.properties file and merges line by line with /opt/connect/conf/mirth.properties
if [ -f /run/secrets/mirth_properties ]; then

    # add new line in case /opt/connect/conf/mirth.properties doens't end with one
    echo "" >> /opt/connect/conf/mirth.properties

    while read -r keyvalue; do
        KEY="${keyvalue%%=*}"
        VALUE="${keyvalue#*=}"

        # remove leading and trailing white space
        KEY="$(echo -e "${KEY}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
        VALUE="$(echo -e "${VALUE}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"

        if ! [ -z "${KEY}" ] && ! [ -z "${VALUE}" ] && ! [[ ${VALUE} =~ ^\ +$ ]]; then
            # if key does not exist in mirth.properties append it at bottom
            LINE_COUNT=`grep "^${KEY}" /opt/connect/conf/mirth.properties | wc -l`
            if [ $LINE_COUNT -lt 1 ]; then
                # echo "key ${KEY} not found in mirth.properties, appending. Value = ${VALUE}"
                echo -e "${KEY} = ${VALUE//\//\\/}" >> /opt/connect/conf/mirth.properties
            else # otherwise key exists, overwrite it
                # echo "key ${KEY} exists, overwriting. Value = ${VALUE}"
                ESCAPED_KEY="${KEY//./\\.}"
                sed -i "s/^${ESCAPED_KEY}\s*=\s*.*\$/${KEY} = ${VALUE//\//\\/}/" /opt/connect/conf/mirth.properties
            fi
        fi
    done <<< "`cat /run/secrets/mirth_properties`"
fi

# merge the user's secret vmoptions
# takes a whole mcserver.vmoptions file and merges line by line with /opt/connect/mcserver.vmoptions
if [ -f /run/secrets/mcserver_vmoptions ]; then
    (cat /run/secrets/mcserver_vmoptions ; echo "") >> /opt/connect/mcserver.vmoptions
fi

# if delay is set as an environment variable then wait that long in seconds
if ! [ -z "${DELAY+x}" ]; then
	sleep $DELAY
fi

# check if DB is up
# use the db type to attempt to connect to the db before starting connect to prevent connect from trying to start before the db is up
# get the database properties from mirth.properties
db=$(grep "^database\s*=" /opt/connect/conf/mirth.properties | sed -e 's/[^=]*=\s*\(.*\)/\1/')
dbusername=$(grep "^database.username" /opt/connect/conf/mirth.properties | sed -e 's/[^=]*=\s*\(.*\)/\1/')
dbpassword=$(grep "^database.password" /opt/connect/conf/mirth.properties | sed -e 's/[^=]*=\s*\(.*\)/\1/')
dburl=$(grep "^database.url" /opt/connect/conf/mirth.properties | sed -e 's/[^=]*=\s*\(.*\)/\1/')

if [ $db == "postgres" ] || [ $db == "mysql" ]; then
	# parse host, port, and name
	dbhost=$(echo $dburl | sed -e 's/.*\/\/\(.*\):.*/\1/')
	dbport=$(echo $dburl | sed -e "s/.*${dbhost}:\(.*\)\/.*/\1/")
	if [[ $dburl =~ "?" ]]; then
		dbname=$(echo "${dburl}" | sed -e "s/.*${dbport}\/\(.*\)?.*/\1/")
	else
		dbname=$(echo "${dburl}" | sed -e "s/.*${dbport}\///")
	fi
fi

count=0
case "$db" in
	"postgres" )
		until echo $dbpassword | psql -h "$dbhost" -p "$dbport" -U "$dbusername" -d "$dbname" -c '\l' >/dev/null 2>&1; do
			let count=count+1
			if [ $count -gt 30 ]; then
				echo "Postgres is unavailable. Aborting."
				exit 1
			fi
			sleep 1
		done
		;;
	"mysql" )
        echo "trying to connect to mysql"
		until mysql -h "$dbhost" "-p${dbpassword}" -P "$dbport" -u "$dbusername" -e 'SHOW DATABASES' >/dev/null 2>&1; do
			let count=count+1
			if [ $count -gt 50 ]; then
				# show the error
				mysql -h "$dbhost" "-p${dbpassword}" -P "$dbport" -u "$dbusername" -e 'SHOW DATABASES'
				echo "MySQL is unavailable. Aborting."
				exit 1
			fi
			sleep 1
		done
		;;
	*)
        sleep 1
		;;
esac

exec "$@"