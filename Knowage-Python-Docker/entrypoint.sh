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
	
	if [ -z "$HMAC_KEY" ]
	then
		echo "The HMAC_KEY environment variable is needed"
		exit -1
	fi
	
	#create hmackey file
	echo -n "${HMAC_KEY}" > /app/hmackey
	
	# Install required libraries
	pip install -r requirements.txt
	
	# Create the placeholder to prevent multiple initializations
	touch "$CONTAINER_INITIALIZED_PLACEHOLDER"
fi

exec "$@"

