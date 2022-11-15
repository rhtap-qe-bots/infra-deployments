#!/bin/bash

# ----------------------------------------------------------------
# OAuth2 Proxy Secrets
# ----------------------------------------------------------------

oauth2-secret-help() {
  echo "$0 oauth2-secret NAME CLIENT_ID CLIENT_SECRET COOKIE_SECRET"
}

oauth2-secret() {
  if [[ $# -ne 4 ]]; then
    oauth2-secret-help
    exit 1
  fi

  NAME=$1
  CLIENT_ID=$2
  CLIENT_SECRET=$3
  COOKIE_SECRET=$4

  oc create secret generic $NAME \
    -n appstudio-workload-monitoring  \
    --from-literal=client-id=$CLIENT_ID \
    --from-literal=client-secret=$CLIENT_SECRET \
    --from-literal=cookie-secret=$COOKIE_SECRET
}

# ----------------------------------------------------------------
# Grafana Datasource Secrets
# ----------------------------------------------------------------
grafana-datasource-secret-help() {
  echo "$0 grafana-datasource-secret NAME URL TOKEN"
}

grafana-datasource-secret() {

  if [[ $# -ne 3 ]]; then
    grafana-datasource-secret-help
    exit 1
  fi

  NAME=$1
  URL=$2
  TOKEN=$3

  DATA="apiVersion: 1
datasources: 
- name: $NAME
  type: prometheus
  access: proxy
  url: $URL
  basicAuth: false
  withCredentials: true
  isDefault: false
  jsonData:
    httpHeaderName1: 'Authorization'
    timeInterval: 5s
    tlsSkipVerify: true
  secureJsonData:
    httpHeaderValue1: 'Bearer $TOKEN'"
  
  oc create secret generic $NAME --from-literal=$NAME.yaml="$DATA"
}

# -----------------------------------------------------------------
if declare -f "$1" > /dev/null
then
    # call arguments verbatim
    "$@"
else
    # Show a helpful error
    echo "'$1' is not a valid command" >&2
    echo "available commands:"
    echo "namespace                   Create the 'appstudio-workload-monitoring' namespace"
    echo "oauth2-secret               Create the secret for Grafana's or Prometheus's OAuth2 proxy"
    echo "grafana-datasource-secret   Create the secret for a Grafana datasource"
    echo ""
    exit 1
fi