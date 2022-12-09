#!/bin/bash
clear
[[ ! -d /root/backupsql ]] && mkdir /root/backupsql
rm /root/backupsql/net.sql > /dev/null 2>&1
senha=$(grep -E "3" /var/www/html/conexao.php| cut -d"'" -f2)
mysqldump -u root -p$senha net > /root/backupsql/net.sql
bzip2 -f /root/backupsql/net.sql