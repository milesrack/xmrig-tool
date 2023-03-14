# XMRig Tool
A systemd service for the XMRig miner.

## Installation
First, clone the git repository:
```
git clone https://github.com/milesrack/xmrig-tool
cd xmrig-tool
```

Create an `xmrig.conf` file with the following variables:
```
HTTP_ENABLED="true"
HTTP_BIND="0.0.0.0"
HTTP_PORT="7000"
HTTP_ACCESS_TOKEN=""
HTTP_RESTRICTED="false"
POOL="xmr-us-west1.nanopool.org:14433"
WALLET=""
```
- `HTTP_ENABLED`: Enable or disable the HTTP API.
- `HTTP_BIND`: IP to bind for the HTTP API.
- `HTTP_PORT`: Port to listen on for the HTTP API.
- `HTTP_ACCESS_TOKEN`: Access token for the HTTP API. This is required if you have `HTTP_RESTRICTED` set to `false`.
- `HTTP_RESTRICTED`: Enable or disable restrictions that allow the configuration to change via the HTTP API.
- `POOL`: XMR pool to mine on.
- `WALLET`: Your XMR wallet address.

Run the installation script:
```
sudo ./install.sh
```

Verify that the service is running:
```
systemctl status xmrig
```

You can use the [official XMRig API client](https://workers.xmrig.info/) to view statistics on your workers. Simple provide the API endpoint (`http://<IP>:<PORT>`) and the access token if applicable.
