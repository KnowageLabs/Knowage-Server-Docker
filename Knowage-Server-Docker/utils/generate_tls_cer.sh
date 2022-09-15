#!/bin/sh

openssl req \
	-new \
	-newkey rsa:4096 \
	-x509 \
	-sha256 \
	-days 364635 \
	-nodes \
	-out    certificate.crt \
	-keyout key.key \
	-subj "/C=IT/ST=Piemonte/L=Torino/O=Engineering Ingegneria Informatica S.p.a/OU=KNOWAGE Labs/CN=*"

chmod 400 key.key

