#!/bin/sh -ue
mac=${1:-""}
api_key=${2:-${MACADDRESS_API_KEY:-""}}

if [ "${api_key}" == "" ]; then
  if [ -r ${MACADDRESS_API_KEY_FILE:-"/nofile"} ]; then
    api_key=$(cat ${MACADDRESS_API_KEY_FILE})
  else
    echo "macaddres.io api key not found. please define it via MACADDRESS_API_KEY env variable or pass it as a second argument"
    exit 1
  fi
fi

if [ "${mac}" == "" ]; then
  echo "Usage: $0 [mac address] [api key]"
  exit 2
fi

if ! echo "${mac}" | grep -iE '^([0-9A-F]{2}[:-]){5}([0-9A-F]{2})$' >/dev/null; then
  echo "${mac} does not looks like a mac address"
  exit 3
fi

cat <<EOT >/tmp/headers
X-Authentication-Token: ${api_key}
EOT
curl -s -H@/tmp/headers "https://api.macaddress.io/v1?output=json&search=${mac}"|jq -r .vendorDetails.companyName
