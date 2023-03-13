# XMRig Tool
A systemd service for the XMRig miner.

## Installation
```
git clone https://github.com/milesrack/xmrig-tool
cd xmrig-tool
sudo ./install.sh
```

After installation, verify that the service is running
```
systemctl status xmrig
```

## Configuration
Create a `.env` file to store your wallet address
```
# cat .env

WALLET="YOUR_WALLET_ADDRESS"
```

