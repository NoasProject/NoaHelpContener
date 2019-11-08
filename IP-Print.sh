#!/bin/sh

IPAdress=""
PreIPAdress=""

while true; do 
    PreIPAdress=`/sbin/ifconfig en1 | grep 'inet ' | sed -e 's/^.*inet //' -e 's/ .*//'`
    
    # IPの変更が発生
    if [ "$IPAdress" != "$PreIPAdress" ]; then
        echo "IPアドレスが変更されました${IPAdress} --> ${PreIPAdress}"
        IPAdress=${PreIPAdress}
    #else
        #echo $IPAdress" --- "$PreIPAdress
    fi
    sleep 1s
done;

function GetIP() {}