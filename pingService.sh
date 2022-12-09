#!/bin/bash

serverName="NAME"
server="x.x.x.x"
port=80
botToken=" ## TELEGRAM BOH TOKEN ##"
chatId="## TELEGRAM CHAT ID ##"
if ! nc -w 2 -z $server $port > /dev/null 2>&1
then
          curl \
          -X POST \
          -s \
          --data "chat_id=${chatId}" \
          --data "disable_web_page_preview=true" \
          --data "text=Server ${serverName} (${server}:${port}) down!%0A$(date +"%a, %d %B %Y, %H:%M:%S")" \
          --connect-timeout 30 \
          --max-time 45 \
          "https://api.telegram.org/bot${botToken}/sendMessage" \
          > /dev/null
fi 