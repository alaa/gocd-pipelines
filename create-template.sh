#!/bin/bash

GOCD_HOST="gocd-server.prod01.internal.advancedtelematic.com:8153"

TEMPLATE_FILE=$1
REQ=$(envsubst < $TEMPLATE_FILE)

curl "http://$GOCD_HOST/go/api/admin/templates" \
      -H 'Accept: application/vnd.go.cd.v3+json' \
      -H 'Content-Type: application/json' \
      -X POST \
      -d"$REQ"
