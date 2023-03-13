#!/bin/bash

VERSION="6.19.0"
POOL="xmr-us-east1.nanopool.org:14444"

if [ `id -u` -ne 0 ]
	then echo Please run this script as root
	exit
fi

source .env

mkdir -p /opt
wget https://github.com/xmrig/xmrig/releases/download/v$VERSION/xmrig-$VERSION-linux-x64.tar.gz -O /tmp/xmrig-$VERSION-linux-x64.tar.gz
tar -xf /tmp/xmrig-$VERSION-linux-x64.tar.gz -C /opt

sed -i "s/donate.v2.xmrig.com:3333/$POOL/" /opt/xmrig-$VERSION/config.json
sed -i "s/YOUR_WALLET_ADDRESS/$WALLET/" /opt/xmrig-$VERSION/config.json
sed -i "s/\"coin\": null/\"coin\": \"monero\"/" /opt/xmrig-$VERSION/config.json
sed -i "s/\"syslog\": false/\"syslog\": true/" /opt/xmrig-$VERSION/config.json
sed -i "s/\"log-file\": null/\"log-file\": \"\/opt\/xmrig-$VERSION\/xmrig.log\"/" /opt/xmrig-$VERSION/config.json
echo -e "[Unit]\nDescription=XMRig miner service\nAfter=network.target\n\n[Service]\nExecStart=/opt/xmrig-$VERSION/xmrig --config /opt/xmrig-$VERSION/config.json\nType=simple\n\n[Install]\nWantedBy=multi-user.target\n" > /etc/systemd/system/xmrig.service
systemctl daemon-reload
systemctl enable --now xmrig
