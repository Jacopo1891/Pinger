#!/bin/bash

serverName="NAME"
server="x.x.x.x"
port=80

botToken="## BOT TOKEN ##"
chatId="## CHAT ID ##"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
file="offline"
check="$SCRIPT_DIR/$file"

messageOnline="Server ${serverName} (${server}:${port}) now up!%0A$(date +"%a, %d %B %Y, %H:%M:%S")"
messageOffline="Server ${serverName} (${server}:${port}) down!%0A$(date +"%a, %d %B %Y, %H:%M:%S")"

function sendTelegramMessage() {
        echo $( curl --write-out %{http_code} --silent --output /dev/null -X POST -s --data "chat_id=${chatId}" --data "disable_web_page_preview=true"  --data "text=$1" --connect-timeout 30 --max-time 45  "https://api.telegram.org/bot${botToken}/sendMessage" )
    }
if ! nc -w 2 -z $server $port > /dev/null 2>&1
then
        if [[ ! -f "$check" ]];
                then
                        resp=$( sendTelegramMessage "$messageOffline" )
                        if [[ "$resp" == 200 ]];
                        then
                                touch $check
                        fi
        fi
else
        if [[ -f "$check" ]];
        then
                resp=$( sendTelegramMessage "$messageOnline" )
                if [[ "$resp" == 200 ]];
                then
                        rm -f $check
                fi
        fi
fi
