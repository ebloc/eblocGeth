#!/bin/bash

# ensure running as root
if [ "$(id -u)" != "0" ]; then
  echo "sudo: Please run: sudo bash server.sh";
  exit
fi

sudo killall geth
DATADIR="/Users/alper/DENE/eblocGeth"
nohup geth --datadir $DATADIR/private --port 3000 --rpcaddr 127.0.0.1 --rpc --rpcport 8545 --rpccorsdomain="*" --networkid 23422 --rpcapi eth,net,web3,personal > gethServer.out &

echo "Please wait few seconds for geth-server to be activated."
sleep 6

echo "loadScript(\"$DATADIR"/pass.js"\")" | sudo geth --datadir "$DATADIR/private" attach ipc:$DATADIR/private/geth.ipc console
echo "net"                                | sudo geth --datadir "$DATADIR/private" attach ipc:$DATADIR/private/geth.ipc console
bash stats.sh 
