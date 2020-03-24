#!/bin/sh

IPAdress=""
PreIPAdress=""

function CatSsh() {
    text=cat /Users/noa/Project/Shell/token.ssh | grep '${1}:' | sed -e 's/${1}://'
    #cat /Users/noa/Project/Shell/token.ssh | grep 'UserId:' | sed -e 's/UserId://'
    echo $text
}
echo /Users/noa/Project/Shell/token.txt | grep 'UserId:' | sed -e 's/UserId://'
LINE_POST()

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

#LINEのBotに送信を行う
function LINE_POST() {
    curl -X POST \
    -H 'Content-Type: application/json' \
    -H 'Authorization: Bearer QLYdD/wvRmZ5pBB7MWlj6Bbn1E/ZhroYBcNE29011sNTTeoeo2tc5dXEB9ulEwtlxeHDFiQgWypn+JsVKKX2zCvHYzOhoFLJkCBmXIczo7ZCEoA6Hw4UEMq7JYYHxq8OZgBgeIQPTqIn7k8vodYRbgdB04t89/1O/w1cDnyilFU=' \
    -d '{
        "to": "U6939b709721083e0faf03ea050f60d8f",
        "messages":[
            {
            "type": "text",
            "text": "新大陸へようこそ"
        }
        ]
    }' https://api.line.me/v2/bot/message/push
}