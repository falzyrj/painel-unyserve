#!/bin/bash
clear
link1=http://update.unyserve.com.br/verpw4g
link2=http://update.unyserve.com.br/verweb
[[ -e /home/verpw4g ]] && rm /home/verpw4g
wget -P /home $link1 > /dev/null 2>&1
[[ -f "/home/verpw4g" ]] && {
vrs1=$(sed -n '1 p' /etc/kernel/recweb/verpw4g| sed -e 's/[^0-9]//ig')
vrs2=$(sed -n '1 p' /home/verpw4g | sed -e 's/[^0-9]//ig')
[[ "$vrs1" != "$vrs2" ]] && mv /home/verpw4g /etc/kernel/recweb/attpw4g
}
[[ -e /home/verweb ]] && rm /home/verweb
wget -P /home $link2 > /dev/null 2>&1
[[ -f "/home/verweb" ]] && {
vrs3=$(sed -n '1 p' /etc/kernel/recweb/verweb| sed -e 's/[^0-9]//ig')
vrs4=$(sed -n '1 p' /home/verweb | sed -e 's/[^0-9]//ig')
[[ "$vrs3" != "$vrs4" ]] && mv /home/verweb /etc/kernel/recweb/attweb
}