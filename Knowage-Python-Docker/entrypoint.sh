#!/bin/bash
set -e

# usage: file_env VAR [DEFAULT]
#    ie: file_env 'XYZ_DB_PASSWORD' 'example'
# (will allow for "$XYZ_DB_PASSWORD_FILE" to fill in the value of
#  "$XYZ_DB_PASSWORD" from a file, especially for Docker's secrets feature)
file_env() {
	local var="$1"
	local fileVar="${var}_FILE"
	local def="${2:-}"
	if [ "${!var:-}" ] && [ "${!fileVar:-}" ]; then
		echo >&2 "error: both $var and $fileVar are set (but are exclusive)"
		exit 1
	fi
	local val="$def"
	if [ "${!var:-}" ]; then
		val="${!var}"
	elif [ "${!fileVar:-}" ]; then
		val="$(< "${!fileVar}")"
	fi
	export "$var"="$val"
	unset "$fileVar"
}

# Placeholder created after the first boot of the container
CONTAINER_INITIALIZED_PLACEHOLDER=/app/CONTAINER_INITIALIZED

# Check if this is the first boot
if [ ! -f "$CONTAINER_INITIALIZED_PLACEHOLDER" ]
then
	file_env "HMAC_KEY"
	file_env "KNOWAGE_PUBLIC_ADDRESS"
	file_env "PUBLIC_ADDRESS"

	if [[ -z "$KNOWAGE_PUBLIC_ADDRESS" ]]
	then
		echo "The KNOWAGE_PUBLIC_ADDRESS environment variable is needed"
		exit -1
	fi

	if [[ -z "$PUBLIC_ADDRESS" ]]
	then
		echo "The PUBLIC_ADDRESS environment variable is needed"
		exit -1
	fi
	
	if [ -z "$HMAC_KEY" ]
	then
		echo "The HMAC_KEY environment variable is needed"
		exit -1
	fi
	
	# Set variable in config.xml
	xmlstarlet edit -L --update "//data/environment/hmackey"        --value "${HMAC_KEY}" \
	                   --update "//data/environment/knowageaddress" --value "${KNOWAGE_PUBLIC_ADDRESS}" \
			   --update "//data/environment/pythonaddress"  --value "${PUBLIC_ADDRESS}" \
			   app/config.xml
	
	# Create the placeholder to prevent multiple initializations
	touch "$CONTAINER_INITIALIZED_PLACEHOLDER"
fi

exec "$@"

