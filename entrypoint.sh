#!/bin/sh
echo """\
{
    \"http\": {
        \"enabled\": $HTTP_ENABLED,
        \"host\": \"$HTTP_BIND\",
        \"port\": $HTTP_PORT,
        \"access-token\": \"$HTTP_ACCESS_TOKEN\",
        \"restricted\": $HTTP_RESTRICTED
    },
    \"autosave\": true,
    \"cpu\": {
        \"enabled\": true
    },
    \"opencl\": false,
    \"cuda\": false,
    \"pools\": [
        {
            \"coin\": \"monero\",
            \"url\": \"$POOL\",
            \"user\": \"$WALLET\",
            \"tls\": true
        }
    ]
}\
""" > $(ls /opt/xmrig-*/config.json)
$(ls /opt/xmrig-*/xmrig) --config $(ls /opt/xmrig-*/config.json)
