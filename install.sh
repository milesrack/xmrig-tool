#!/bin/bash

if [ `id -u` -ne 0 ]
	then echo Please run this script as root
	exit
fi

source xmrig.conf

mkdir -p /opt
wget $(curl -s https://api.github.com/repos/xmrig/xmrig/releases/latest | grep browser_download_url | grep -oE "https://github.com/.*linux-x64.tar.gz") -O /tmp/xmrig-linux-x64.tar.gz
tar -xf /tmp/xmrig-linux-x64.tar.gz -C /opt
INSTALL_PATH=$(ls -d /opt/xmrig-*/)
INSTALL_PATH=${INSTALL_PATH:0:-1}
CPU=$(seq -s ', ' 0 $(( `cat /proc/cpuinfo | grep processor | wc -l`-1 )))
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
""" > $INSTALL_PATH/config.json
echo -e "[Unit]\nDescription=XMRig miner service\nAfter=network.target\n\n[Service]\nExecStart=$INSTALL_PATH/xmrig --config $INSTALL_PATH/config.json\nType=simple\n\n[Install]\nWantedBy=multi-user.target\n" > /etc/systemd/system/xmrig.service
systemctl daemon-reload
systemctl enable --now xmrig
