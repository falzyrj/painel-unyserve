#!/bin/bash
[[ $(awk -F" " '{print $2}' /usr/lib/internet4g) == "@nandoslayer" ]] && {
### CORES DA BARRA
msg() {
BRAN='\033[1;37m' && VERMELHO='\e[31m' && VERDE='\e[32m' && AMARELO='\e[33m'
AZUL='\e[34m' && MAGENTA='\e[35m' && MAG='\033[1;36m' && NEGRITO='\e[1m' && SEMCOR='\e[0m'
case $1 in
-ne) cor="${VERMELHO}${NEGRITO}" && echo -ne "${cor}${2}${SEMCOR}" ;;
-ama) cor="${AMARELO}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}" ;;
-verm) cor="${AMARELO}${NEGRITO}[!] ${VERMELHO}" && echo -e "${cor}${2}${SEMCOR}" ;;
-azu) cor="${MAG}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}" ;;
-verd) cor="${VERDE}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}" ;;
-bra) cor="${VERMELHO}" && echo -ne "${cor}${2}${SEMCOR}" ;;
-nazu) cor="${COLOR[6]}${NEGRITO}" && echo -ne "${cor}${2}${SEMCOR}" ;;
-gri) cor="\e[5m\033[1;100m" && echo -ne "${cor}${2}${SEMCOR}" ;;
"-bar2" | "-bar") cor="${VERMELHO}————————————————————————————————————————————————————" && echo -e "${SEMCOR}${cor}${SEMCOR}" ;;
esac
}
fun_bar () {
comando[0]="$1"
comando[1]="$2"
(
[[ -e $HOME/fim ]] && rm $HOME/fim
${comando[0]} -y > /dev/null 2>&1
${comando[1]} -y > /dev/null 2>&1
touch $HOME/fim
) > /dev/null 2>&1 &
tput civis
echo -ne "\033[1;33m["
while true; do
for((i=0; i<18; i++)); do
echo -ne "\033[1;31m#"
sleep 0.1s
done
[[ -e $HOME/fim ]] && rm $HOME/fim && break
echo -e "\033[1;33m]"
sleep 2s
tput cuu1
tput dl1
echo -ne "\033[1;33m["
done
echo -e "\033[1;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
tput cnorm
}
fun_prog ()
{
comando[0]="$1"
${comando[0]}  > /dev/null 2>&1 &
tput civis
echo -ne "\033[1;32m.\033[1;33m.\033[1;31m. \033[1;32m"
while [ -d /proc/$! ]
do
for i in / - \\ \|
do
sleep .1
echo -ne "\e[1D$i"
done
done
tput cnorm
echo -e "\e[1DOK"
}
print_center() {
if [[ -z $2 ]]; then
text="$1"
else
col="$1"
text="$2"
fi
while read line; do
unset space
x=$(((54 - ${#line}) / 2))
for ((i = 0; i < $x; i++)); do
space+=' '
done
space+="$line"
if [[ -z $2 ]]; then
msg -azu "$space"
else
msg "$col" "$space"
fi
done <<<$(echo -e "$text")
}
time_reboot() {
echo ""
print_center -ama "REINICIANDO EM "
echo ""
REBOOT_TIMEOUT="$1"
while [ $REBOOT_TIMEOUT -gt 0 ]; do
print_center -ne "-$REBOOT_TIMEOUT-\r"
sleep 2
: $((REBOOT_TIMEOUT--))
done
reboot
}
if [[ "$(grep -c "Ubuntu" /etc/issue.net)" = "1" ]]; then
system=$(cut -d' ' -f1 /etc/issue.net)
system+=$(echo ' ')
system+=$(cut -d' ' -f2 /etc/issue.net |awk -F "." '{print $1}')
elif [[ "$(grep -c "Debian" /etc/issue.net)" = "1" ]]; then
system=$(cut -d' ' -f1 /etc/issue.net)
system+=$(echo ' ')
system+=$(cut -d' ' -f3 /etc/issue.net)
else
system=$(cut -d' ' -f1 /etc/issue.net)
fi
_ons=$(ps -x | grep sshd | grep -v root | grep priv | wc -l)
_ram=$(printf ' %-9s' "$(free -h | grep -i mem | awk {'print $2'})")
_usor=$(printf '%-8s' "$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')")
_usop=$(printf '%-5s' "$(top -bn1 | awk '/Cpu/ { cpu = "" 100 - $8 "%" }; END { print cpu }')")
_core=$(printf '%-5s' "$(grep -c cpu[0-9] /proc/stat)")
_system=$(printf '%-14s' "$system")
_hora=$(printf '%(%H:%M:%S)T')
autm=$(grep "pw4g;" /etc/profile > /dev/null && echo -e "\033[1;32m ON ◉" || echo -e "\033[1;31mOFF ○")
botp=$(ps x | grep "bot_painel"|grep -v grep > /dev/null && echo -e "\033[1;32m ON ◉" || echo -e "\033[1;31mOFF ○")
firew=$(ps x | grep "firewalld"|grep -v grep > /dev/null && echo -e "\033[1;32m ON ◉" || echo -e "\033[1;31mOFF ○")
fun_update () {
apt-get update -y > /dev/null 2>&1
}
fun_upgrade () {
apt-get upgrade -y > /dev/null 2>&1
}
fun_atpw4g () {
link1=bitbucket.org/nandoslayer/4g/downloads/verifatt.sh
link2=bitbucket.org/nandoslayer/4g/downloads/verpw4g
link3=bitbucket.org/nandoslayer/4g/downloads/pw4g
[[ ! -d /etc/kernel/recweb ]] && mkdir /etc/kernel/recweb
cd /etc/kernel/recweb || exit
rm *.sh verpw4g > /dev/null 2>&1
wget $link1 > /dev/null 2>&1
wget $link2 > /dev/null 2>&1
chmod 777 *.sh > /dev/null 2>&1
cd /bin || exit
rm pw4g > /dev/null 2>&1
wget $link3 > /dev/null 2>&1
chmod 777 pw4g > /dev/null 2>&1
cd || exit
cat /dev/null > ~/.bash_history && history -c
}
autoexec () {
if grep "pw4g;" /etc/profile > /dev/null; then
echo ""
echo -e "\033[1;32mDESATIVANDO AUTO EXECUÇÃO DO PW4G\033[0m"
offautpw4g () {
sed -i '/pw4g;/d' /etc/profile
}
echo ""
fun_bar 'offautpw4g'
echo ""
echo -e "\033[1;31mAUTO EXECUÇÃO DESATIVADO!\033[0m"
sleep 2.5s
pw4g
else
echo ""
echo -e "\033[1;32mATIVANDO AUTO EXECUÇÃO DO PW4G\033[0m"
autpw4g () {
grep -v "^pw4g;" /etc/profile > /tmp/tmpass && mv /tmp/tmpass /etc/profile
echo "pw4g;" >> /etc/profile
}
echo ""
fun_bar 'autpw4g'
echo ""
echo -e "\033[1;32mAUTO EXECUÇÃO ATIVADO!\033[0m"
sleep 2.5s
pw4g
fi
}
velocity () {
aguarde () {
comando[0]="$1"
comando[1]="$2"
(
[[ -e $HOME/fim ]] && rm $HOME/fim
[[ ! -d $HOME/speed ]] && rm -rf $HOME/speed
${comando[0]} > /dev/null 2>&1
${comando[1]} > /dev/null 2>&1
touch $HOME/fim
) > /dev/null 2>&1 &
tput civis
echo -ne "\033[1;33mAGUARDE \033[1;37m- \033[1;33m["
while true; do
for((i=0; i<18; i++)); do
echo -ne "\033[1;31m#"
sleep 0.1s
done
[[ -e $HOME/fim ]] && rm $HOME/fim && break
echo -e "\033[1;33m]"
sleep 2s
tput cuu1
tput dl1
echo -ne "\033[1;33mAGUARDE \033[1;37m- \033[1;33m["
done
echo -e "\033[1;33m]\033[1;37m -\033[1;32m OK !\033[1;37m "
tput cnorm
}
fun_tst () {
link1=bitbucket.org/nandoslayer/4g/downloads/speedtest-cli
if [ -e "/usr/bin/testevelocidade" ]; then
testevelocidade --share > speed
else
wget $link1 -O testevelocidade
chmod +x testevelocidade
mv testevelocidade /usr/bin/testevelocidade
testevelocidade --share > speed
fi
}
echo ""
echo -e "\033[1;37m◆═════════════════════════════════════════════════════════════◆\033[0m"
echo -e " \E[44;1;37m              🚀 TESTE DE VELOCIDADE DA VPS 🚀               \E[0m"
echo -e "\033[1;37m◆═════════════════════════════════════════════════════════════◆\033[0m"
echo ""
aguarde 'fun_tst'
echo ""
png=$(cat speed | sed -n '5 p' |awk -F : {'print $NF'})
down=$(cat speed | sed -n '7 p' |awk -F :  {'print $NF'})
upl=$(cat speed | sed -n '9 p' |awk -F :  {'print $NF'})
host=$(cat speed | sed -n '2 p' |awk -F :  {'print $NF'})
echo -e "\033[1;37m═══════════════════════════════════════════════════════════════\033[0m"
echo -e "\033[1;32mHOST SERVER:\033[1;37m$host"
echo ""
echo -e "\033[1;32mPING (LATÊNCIA):\033[1;37m$png"
echo ""
echo -e "\033[1;32mDOWNLOAD:\033[1;37m$down"
echo ""
echo -e "\033[1;32mUPLOAD:\033[1;37m$upl"
echo ""
echo -e "\033[1;37m═══════════════════════════════════════════════════════════════\033[0m"
rm -rf $HOME/speed
}
painel_att () {
clear
link1=bitbucket.org/nandoslayer/4g/downloads/verweb
cd /etc/kernel/recweb || exit
rm verweb > /dev/null 2>&1
wget $link1 > /dev/null 2>&1
cd || exit
echo ""
echo -e "           \033[1;33m● \033[1;32mATUALIZANDO LINUX, PODE DEMORAR \033[1;33m●\033[0m"
fun_update () {
apt-get update -y > /dev/null 2>&1
apt-get install figlet -y > /dev/null 2>&1
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
chmod +x /usr/local/bin/composer
}
##################################
fun_bar 'fun_update'
echo ""
clear
linkzip=bitbucket.org/nandoslayer/4g/downloads/internet.zip
IP=$(wget -qO- ipv4.icanhazip.com)
echo "America/Sao_Paulo" > /etc/timezone
ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime > /dev/null 2>&1
dpkg-reconfigure --frontend noninteractive tzdata > /dev/null 2>&1
clear
echo ""
echo -e "\E[44;1;37m    ATUALIZANDO O PAINEL     \E[0m"
echo ""
echo -e "INTERNET-SSH" | figlet
echo -e "                              \033[1;31mBy @nandoslayer\033[1;36m"
echo ""
clear
senha=$(grep -E "3" /var/www/html/conexao.php| cut -d"'" -f2)
echo ""
echo -e "           \033[1;33m● \033[1;32mFINALIZANDO A ATUALIZAÇÃO, PODE DEMORAR \033[1;33m● \033[1;33mAGUARDE...\033[0m"
cd /var/www/html || exit
find /var/www/html/ -iname "*.php" -type f -exec rm -rfv {} \; > /dev/null 2>&1
find /var/www/html/ -iname "*.html" -type f -exec rm -rfv {} \; > /dev/null 2>&1
find /var/www/html/ -iname "*.html" -type f -exec rm -rfv {} \; > /dev/null 2>&1
find /var/www/html/ -iname "*.svg" -type f -exec rm -rfv {} \; > /dev/null 2>&1
find /var/www/html/ -iname "*.jpg" -type f -exec rm -rfv {} \; > /dev/null 2>&1
find /var/www/html/ -iname "*.png" -type f -exec rm -rfv {} \; > /dev/null 2>&1
find /var/www/html/ -iname "*.png" -type f -exec rm -rfv {} \; > /dev/null 2>&1
find /var/www/html/ -iname "*.lock" -type f -exec rm -rfv {} \; > /dev/null 2>&1
wget $linkzip > /dev/null 2>&1
sleep 2
unzip -o internet.zip > /dev/null 2>&1
rm -rf internet.zip index.html bdpainel.sql > /dev/null 2>&1
(echo yes; echo yes; echo yes; echo yes) | composer install > /dev/null 2>&1
(echo yes; echo yes; echo yes; echo yes) | composer require phpseclib/phpseclib:~2.0 > /dev/null 2>&1
ln -s /usr/share/phpmyadmin/ /var/www/html > /dev/null 2>&1
chmod 777 -R /var/www/html > /dev/null 2>&1
sleep 2
if [[ -e "/var/www/html/conexao.php" ]]; then
sed -i "s;suasenha;$senha;g" /var/www/html/conexao.php > /dev/null 2>&1
fi
##################################
clear
crontab -l > cronset > /dev/null 2>&1
echo "
@reboot /etc/autostart
* * * * * /etc/autostart
2 */3 * * * cd /var/www/html/cronphp/ && bash cron.autobackup.sh && cd /root" > cronset
crontab cronset && rm cronset > /dev/null 2>&1
##################################
clear
cd || exit
echo ""
echo -e "\E[44;1;32m    PAINELWEB ATUALIZADO COM SUCESSO     \E[0m"
echo ""
echo -e "INTERNET-SSH" | figlet
echo ""
echo -e "\033[1;36m PAINEL WEB DIGITE ESSE IP NO NAVEGADOR:\033[1;37m http://$IP/\033[0m"
echo ""
echo -e "\033[1;33m MAIS INFORMAÇÕES \033[1;31m(\033[1;36mTELEGRAM\033[1;31m): \033[1;37m@nandoslayer\033[0m"
echo ""
echo -ne "\n\033[1;31mENTER \033[1;33mpara retornar ao \033[1;32mPW4G! \033[0m"; read
cat /dev/null > ~/.bash_history && history -c
service cron restart > /dev/null 2>&1
systemctl restart apache2 > /dev/null 2>&1
clear
pw4g
exit;
}
painel_rest () {
clear
mkdir /root/restaurar > /dev/null 2>&1
clear
echo ""
echo -e "\033[1;33mRESTAURAR BANCO DE DADOS DO PAINELWEB INTERNET-SSH!\033[0m"
echo ""
echo -e "\n\033[1;33mÉ NECESSÁRIO O PAINEL INSTALADO E O\nARQUIVO (\033[1;32mnet.sql.bz2 ou net.sql\033[1;33m) NA PASTA (root/restaurar)!\033[0m\n"
echo ""
echo -ne "\033[1;32mDE UM ENTER PRA CONTINUAR...\033[0m"; read -r
bzip2 /root/restaurar/net.sql > /dev/null 2>&1
[[ ! -e /var/www/html/conexao.php ]] && {
echo -e "\n\033[1;31mO PAINEL NÃO ESTÁ INSTALADO!\033[0m"
echo ""
sleep 3
echo -e "\033[1;31mRETORNANDO...\033[0m"
sleep 3
cat /dev/null > ~/.bash_history && history -c
clear
pw4g
exit;
}
[[ ! -e /root/restaurar/net.sql.bz2 ]] && {
echo -e "\n\033[1;31mARQUIVO (\033[1;32mnet.sql.bz2 ou net.sql\033[1;31m) NÃO ENCONTRADO!\033[0m"
echo ""
sleep 3
echo -e "\033[1;31mRETORNANDO...\033[0m"
sleep 3
cat /dev/null > ~/.bash_history && history -c
clear
pw4g
exit;
}
passdb=$(grep -E "3" /var/www/html/conexao.php| cut -d"'" -f2)
[[ $(mysql -h localhost -u root -p$passdb -e "show databases" | grep -wc net) == '0' ]] && {
echo -e "\n\033[1;31mSEU PAINELWEB NÃO É COMPATÍVEL!\033[0m"
echo ""
sleep 3
echo -e "\033[1;31mRETORNANDO...\033[0m"
sleep 3
cat /dev/null > ~/.bash_history && history -c
clear
pw4g
exit;
}
bunzip2 /root/restaurar/net.sql.bz2
mysql -h localhost -u root -p$passdb -e "drop database net"
mysql -h localhost -u root -p$passdb -e 'CREATE DATABASE net'
mysql -h localhost -u root -p$passdb --default_character_set utf8 net < /root/restaurar/net.sql
echo ""
echo -e "\n\033[1;32mDADOS RESTAURADO COM SUCESSO!\033[0m"
echo ""
sleep 3
echo -e "\033[1;31mRETORNANDO...\033[0m"
rm -rf /root/restaurar > /dev/null 2>&1
sleep 3
cat /dev/null > ~/.bash_history && history -c
clear
pw4g
exit;
}
#BOT TELEGRAM
bot_telegram () {
clear
fun_att_api () {
echo ""
echo -e "\033[1;31mAGUARDE \033[1;32m.\033[1;33m.\033[1;31m. \033[1;33m"
sleep 3
clear
link1=bitbucket.org/nandoslayer/4g/downloads/apibot
link2=bitbucket.org/nandoslayer/4g/downloads/bot
screen -r -S "bot_painel" -X quit > /dev/null 2>&1
screen -wipe 1>/dev/null 2>/dev/null
sleep 2
wget -qO- $link1 -O /etc/kernel/recweb/apibot > /dev/null 2>&1
wget -qO- $link2 -O /etc/kernel/recweb/bot > /dev/null 2>&1
chmod 777 -R /etc/kernel/recweb > /dev/null 2>&1
cd $HOME || exit
echo ""
echo -e "\033[1;36mBOT ATUALIZADO COM SUCESSO!\033[1;37m"
sleep 3
bot_telegram
exit;
}
fun_botOnOff() {
[[ $(ps x | grep "bot_painel" | grep -v grep | wc -l) = '0' ]] && {
clear
echo ""
echo -e "\E[44;1;37m              ATIVAÇÃO DO BOT PW4G                 \E[0m\n"
echo -e "                \033[1;33m[\033[1;31m!\033[1;33m] \033[1;31mATENÇÃO \033[1;33m[\033[1;31m!\033[1;33m]\033[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[1;32m"
echo -e "\n\033[1;32m1° \033[1;37m- \033[1;33mPELO SEU TELEGRAM ACESSE OS SEGUINTES BOT\033[1;37m:\033[0m"
echo -e "\n\033[1;32m2° \033[1;37m- \033[1;33mBOT \033[1;37m@BotFather \033[1;33mCRIE O SEU BOT \033[1;31mOPÇÃO: \033[1;37m/newbot\033[0m"
echo -e "\n\033[1;32m3° \033[1;37m- \033[1;33mBOT \033[1;37m@userinfobot \033[1;33mE PEGUE SEU ID \033[1;31mOPÇÃO: \033[1;37m/id\033[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[1;32m"
echo ""
echo -ne "\n\033[1;32mINFORME SEU TOKEN:\033[1;37m: "; read tokenbot
[[ -z $tokenbot ]] && {
echo -e "\n\033[1;31mINFORME SEU TOKEN!"
sleep 2
cat /dev/null > ~/.bash_history && history -c
bot_telegram
exit;
}
echo -ne "\n\033[1;32mINFORME SEU ID:\033[1;37m: "; read iduser
[[ -z $iduser ]] && {
echo -e "\n\033[1;31mINFORME SEU ID!"
sleep 2
cat /dev/null > ~/.bash_history && history -c
bot_telegram
exit;
}
clear
echo -e "\033[1;32mATIVANDO BOT PW4G \033[0m\n"
fun_bot1() {
link1=bitbucket.org/nandoslayer/4g/downloads/apibot
link2=bitbucket.org/nandoslayer/4g/downloads/bot
[[ ! -e "/etc/kernel/recweb/bot" ]] && {
wget -qO- $link1 -O /etc/kernel/recweb/apibot > /dev/null 2>&1
wget -qO- $link2 -O /etc/kernel/recweb/bot > /dev/null 2>&1
chmod 777 -R /etc/kernel/recweb > /dev/null 2>&1
}
cd /etc/kernel/recweb
screen -dmS bot_painel ./bot $tokenbot $iduser >/dev/null 2>&1
[[ $(grep -wc "bot_painel" /etc/autostart) = '0' ]] && {
echo -e "ps x | grep 'bot_painel' | grep -v 'grep' || cd /etc/kernel/recweb && screen -dmS bot_painel ./bot $tokenbot $iduser && cd $HOME" >>/etc/autostart
} || {
sed -i '/bot_painel/d' /etc/autostart
echo -e "ps x | grep 'bot_painel' | grep -v 'grep' || cd /etc/kernel/recweb && screen -dmS bot_painel ./bot $tokenbot $iduser && cd $HOME" >>/etc/autostart
}
cd $HOME || exit
sleep 3
}
fun_bar 'fun_bot1'
[[ $(ps x | grep "bot_painel" | grep -v grep | wc -l) != '0' ]] && echo -e "\n\033[1;32m BOT PW4G ATIVADO!\033[0m" || echo -e "\n\033[1;31m ERRO! CONFIRA SUAS INFORMAÇÕES\033[0m"
sleep 2
cat /dev/null > ~/.bash_history && history -c
bot_telegram
exit;
} || {
clear
echo -e "\033[1;32mDESATIVANDO BOT PW4G... \033[0m\n"
fun_bot2() {
screen -r -S "bot_painel" -X quit
screen -wipe 1>/dev/null 2>/dev/null
[[ $(grep -wc "bot_painel" /etc/autostart) != '0' ]] && {
sed -i '/bot_painel/d' /etc/autostart
}
sleep 2
}
fun_bar 'fun_bot2'
echo -e "\n\033[1;32m \033[1;31mBOT PW4G DESATIVADO! \033[0m"
sleep 2
cat /dev/null > ~/.bash_history && history -c
bot_telegram
exit;
}
}
stsbot=$(ps x | grep "bot_painel"|grep -v grep > /dev/null && echo -e "\033[1;32m ON ◉" || echo -e "\033[1;31mOFF ○")
echo ""
echo -e "\E[44;1;37m            GERENCIAR BOT PW4G               \E[0m\n"
echo -e "             \033[1;33m[\033[1;31m!\033[1;33m] \033[1;31mATENÇÃO \033[1;33m[\033[1;31m!\033[1;33m]\033[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[1;32m"
echo -e "\033[1;31m[\033[1;36m01\033[1;31m] \033[1;37m• \033[1;33mGERENCIAR BOTPW4G $stsbot\033[0m"
echo -e "\033[1;31m[\033[1;36m02\033[1;31m] \033[1;37m• \033[1;33mATUALIZAR BOT\033[0m"
echo -e "\033[1;31m[\033[1;36m00\033[1;31m] \033[1;37m• \033[1;33mVOLTAR\033[0m"
echo -e "\033[1;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
echo -ne "\033[1;36mSELECIONE UMA OPÇÃO: \033[1;37m"; read -r x
case "$x" in
1|01)
fun_botOnOff
exit;
;;
2|02)
fun_att_api
exit;
;;
0|00)
echo -e "\033[1;31mRetornando...\033[0m"
pw4g
exit;
;;
*)
echo -e "\n\033[1;31mOpção inválida !\033[0m"
sleep 2
bot_telegram
esac
}
#SENHA ROOT
senha_root () {
clear
echo ""
echo -e "\E[44;1;65m    ALTERANDO SENHA ROOT     \E[0m"
echo ""
read -p "DIGITE UMA NOVA SENHA ROOT: " pwdroot
echo "root:$pwdroot" | chpasswd
echo -e "\033[1;33m • \033[1;32mSENHA ROOT ALTERADA COM SUCESSO\033[1;33m • \033[0m"
sleep 3s
clear
echo -e "\033[1;33m • \033[1;32mSISTEMA REINICIANDO\033[1;33m • \033[0m"
echo ""
sleep 4s
shutdown -r now > /dev/null
}
##PAINEL REMOVE
remove_painel () {
clear
echo -e "\033[1;32m SEMPRE CONFIRME COM \033[1;37mY"
echo -e "\033[1;32m PROSSIGA COM \033[1;37mENTER"
sleep 7
service apache2 stop
apt-get purge mysql-server mysql-client mysql-common mysql-server-core-* mysql-client-core-*
rm -rf /etc/mysql /var/lib/mysql
rm -rf /var/www/html
apt-get autoremove
apt-get autoclean
sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf
service apache2 restart > /dev/null 2>&1
service apache2 stop
[[ ! -d /var/www ]] && mkdir /var/www
[[ ! -d /var/www/html ]] && mkdir /var/www/html
echo -e "\033[1;36mPAINEL REMOVIDO COM ÊXITO \033[1;32m[!OK]"
pw4g
}
oracl() {
clear
echo ""
msg -bar
msg -azu "		FIREWALL ORACLE/AWS/AZR"
msg -ama " ESSA OPÇÃO SERVE PARA VPS ORACLE/AWS/AZR E TAMBÉM"
msg -ama " PARA VPS QUE PRECISE ABRIR PORTAS NO FIREWALL!"
msg -bar
echo ""
if ps x | grep -w firewalld | grep -v grep 1>/dev/null 2>/dev/null; then
echo -e "\033[1;33mPORTAS ABERTAS\033[1;37m: \033[1;32m$(firewall-cmd --list-ports)"
else
echo -e "\033[1;31mFIREWALL DESATIVADO"
fi
echo ""
echo -e "\033[1;31m[\033[1;36m01\033[1;31m] \033[1;37m• \033[1;33mABRIR PORTA TCP \033[1;32m>\033[1;33m>\033[1;31m>\033[0m \033[0m"
echo -e "\033[1;31m[\033[1;36m02\033[1;31m] \033[1;37m• \033[1;33mFECHAR PORTA TCP \033[1;32m>\033[1;33m>\033[1;31m>\033[0m \033[0m"
echo -e "\033[1;31m[\033[1;36m03\033[1;31m] \033[1;37m• \033[1;33mABRIR PORTA UDP \033[1;32m>\033[1;33m>\033[1;31m>\033[0m \033[0m"
echo -e "\033[1;31m[\033[1;36m04\033[1;31m] \033[1;37m• \033[1;33mFECHAR PORTA UDP \033[1;32m>\033[1;33m>\033[1;31m>\033[0m \033[0m"
echo -e "\033[1;31m[\033[1;36m05\033[1;31m] \033[1;37m• \033[1;33mDESATIVAR FIREWALL \033[1;32m>\033[1;33m>\033[1;31m>\033[0m \033[0m"
echo -e "\033[1;31m[\033[1;36m00\033[1;31m] \033[1;37m• \033[1;33mVOLTAR \033[1;32m<\033[1;33m<\033[1;31m<\033[0m \033[0m"
echo ""
echo -ne "\033[1;36mSELECIONE UMA OPÇÃO: \033[1;37m"; read -r x
case "$x" in
1 | 01)
verif_portas_tcp
exit;
;;
2 | 02)
oracltcpfechar
exit;
;;
3 | 03)
verif_portas_udp
exit;
;;
4 | 04)
oracludpfechar
exit;
;;
5 | 05)
systemctl stop firewalld > /dev/null 2>&1
systemctl disable firewalld > /dev/null 2>&1
apt remove  firewalld -y > /dev/null 2>&1
apt purge firewalld -y > /dev/null 2>&1
apt-get autoremove -y > /dev/null 2>&1
apt-get autoclean -y > /dev/null 2>&1
rm -rf /etc/firewalld > /dev/null 2>&1
echo -e "\n\033[1;31mDESINSTALADO COM SUCESSO!\033[0m"
sleep 3
oracl
exit;
;;
0 | 00)
echo -e "\033[1;31mRetornando...\033[0m"
pw4g
exit;
;;
*)
echo -e "\n\033[1;31mOpção inválida!\033[0m"
sleep 2
oracl
esac
}
verif_portas_tcp() {
echo ""
echo -ne "\033[1;34mQUAL PORTA TCP DESEJA ABRIR \033[1;33m?\033[1;37m "
read pt
if (firewall-cmd --zone=public --query-port=$pt/tcp) 1>/dev/null 2>/dev/null; then
echo -e "\n\033[1;31mPorta \033[1;33m$pt \033[1;31mjá esta aberta!\033[0m"
sleep 3
oracl
else
oracltcp
fi
}
verif_portas_udp() {
echo ""
echo -ne "\033[1;34mQUAL PORTA UDP DESEJA ABRIR \033[1;33m?\033[1;37m "
read pt
if (firewall-cmd --zone=public --query-port=$pt/udp) 1>/dev/null 2>/dev/null; then
echo -e "\n\033[1;31mPorta \033[1;33m$pt \033[1;31mjá esta aberta!\033[0m"
sleep 3
oracl
else
oracludp
fi
}
oracltcpfechar() {
if ps x | grep -w firewalld | grep -v grep 1>/dev/null 2>/dev/null; then
echo ""
echo -ne "\033[1;34mQUAL PORTA TCP DESEJA FECHAR \033[1;33m?\033[1;37m "
read pt
echo ""
firewall-cmd --zone=public --permanent --remove-port=$pt/tcp > /dev/null 2>&1
echo -e "\n\033[1;32mPorta $pt fechada com sucesso!"
sleep 2
firewall-cmd --reload > /dev/null 2>&1
oracl
else
apt update -y > /dev/null 2>&1
apt install firewalld -y > /dev/null 2>&1
systemctl enable firewalld > /dev/null 2>&1
systemctl start firewalld > /dev/null 2>&1
firewall-cmd --zone=public --permanent --add-port=22/tcp > /dev/null 2>&1
echo ""
echo -ne "\033[1;34mQUAL PORTA DESEJA FECHAR \033[1;33m?\033[1;37m "
read pt
echo ""
firewall-cmd --zone=public --permanent --remove-port=$pt/tcp > /dev/null 2>&1
echo -e "\n\033[1;32mPorta $pt fechada com sucesso!"
sleep 2
firewall-cmd --reload > /dev/null 2>&1
oracl
fi
}
oracludpfechar() {
if ps x | grep -w firewalld | grep -v grep 1>/dev/null 2>/dev/null; then
echo ""
echo -ne "\033[1;34mQUAL PORTA UDP DESEJA FECHAR \033[1;33m?\033[1;37m "
read pt
echo ""
firewall-cmd --zone=public --permanent --remove-port=$pt/udp > /dev/null 2>&1
echo -e "\n\033[1;32mPorta $pt fechada com sucesso!"
sleep 2
firewall-cmd --reload > /dev/null 2>&1
oracl
else
apt update -y > /dev/null 2>&1
apt install firewalld -y > /dev/null 2>&1
systemctl enable firewalld > /dev/null 2>&1
systemctl start firewalld > /dev/null 2>&1
firewall-cmd --zone=public --permanent --add-port=22/tcp > /dev/null 2>&1
echo ""
echo -ne "\033[1;34mQUAL PORTA DESEJA FECHAR \033[1;33m?\033[1;37m "
read pt
echo ""
firewall-cmd --zone=public --permanent --remove-port=$pt/udp > /dev/null 2>&1
echo -e "\n\033[1;32mPorta $pt fechada com sucesso!"
sleep 2
firewall-cmd --reload > /dev/null 2>&1
oracl
fi
}
oracltcp() {
if ps x | grep -w firewalld | grep -v grep 1>/dev/null 2>/dev/null; then
firewall-cmd --zone=public --permanent --add-port=$pt/tcp > /dev/null 2>&1
echo -e "\n\033[1;32mPorta $pt aberta com sucesso!"
sleep 3
firewall-cmd --reload > /dev/null 2>&1
oracl
else
apt update -y > /dev/null 2>&1
apt install firewalld -y > /dev/null 2>&1
systemctl enable firewalld > /dev/null 2>&1
systemctl start firewalld > /dev/null 2>&1
firewall-cmd --zone=public --permanent --add-port=22/tcp > /dev/null 2>&1
firewall-cmd --zone=public --permanent --add-port=$pt/tcp > /dev/null 2>&1
echo -e "\n\033[1;32mPorta $pt aberta com sucesso!"
sleep 3
firewall-cmd --reload > /dev/null 2>&1
oracl
fi
}
oracludp() {
if ps x | grep -w firewalld | grep -v grep 1>/dev/null 2>/dev/null; then
firewall-cmd --zone=public --permanent --add-port=$pt/udp > /dev/null 2>&1
echo -e "\n\033[1;32mPorta $pt aberta com sucesso!"
sleep 3
firewall-cmd --reload > /dev/null 2>&1
oracl
else
apt update -y > /dev/null 2>&1
apt install firewalld -y > /dev/null 2>&1
systemctl enable firewalld > /dev/null 2>&1
systemctl start firewalld > /dev/null 2>&1
firewall-cmd --zone=public --permanent --add-port=22/tcp > /dev/null 2>&1
firewall-cmd --zone=public --permanent --add-port=$pt/udp > /dev/null 2>&1
echo -e "\n\033[1;32mPorta $pt aberta com sucesso!"
sleep 3
firewall-cmd --reload > /dev/null 2>&1
oracl
fi
}
att_pw4g () {
clear
echo ""
echo -e "\E[41;1;37m         BAIXANDO ULTIMA VERSÃO        \E[0m"
echo -e " "
echo -ne "\033[1;33m[\033[1;31m ! \033[1;33m] \033[1;31mATUALIZANDO"; fun_prog 'fun_atpw4g'
echo -e " "
echo -e " "
echo -ne "\033[1;33m[\033[1;31m ! \033[1;33m] \033[1;31mCONCLUINDO"; fun_prog 'sleep 3'
sleep 2
clear
echo ""
echo -e "        \033[1;33m • \033[1;32mATUALIZAÇÃO CONCLUÍDA COM SUCESSO\033[1;33m • \033[0m"
echo ""
echo -e "\033[1;31m \033[1;33mCOMANDO PRINCIPAL: \033[1;32mpw4g\033[0m"
echo -e "\033[1;33m MAIS INFORMAÇÕES \033[1;31m(\033[1;36mTELEGRAM\033[1;31m): \033[1;37m@nandoslayer\033[0m"
echo ""
echo -ne "\n\033[1;31mENTER \033[1;33mPARA RETORNAR AO \033[1;32mPW4G! \033[0m"; read
pw4g
exit;
}
while true $x != "ok"
do
#
if [ -e "/etc/kernel/recweb/verifatt.sh" ]; then
cd /etc/kernel/recweb || exit
./verifatt.sh
cd  || exit;
else
echo -e "\E[41;1;37m         VOCÊ NÃO TEM PERMISSÃO        \E[0m"
sleep 4
clear
exit 0
fi
if [ -e "/etc/kernel/recweb/verpw4g" ]; then
verp=$(cat /etc/kernel/recweb/verpw4g)
else
echo -e "\E[41;1;37m         VOCÊ NÃO TEM PERMISSÃO        \E[0m"
sleep 4
clear
exit 0
fi
if [ -e "/etc/kernel/recweb/verweb" ]; then
verw=$(cat /etc/kernel/recweb/verweb)
else
echo -e "\E[41;1;37m         VOCÊ NÃO TEM PERMISSÃO        \E[0m"
sleep 4
clear
exit 0
fi
if [ -e "/etc/kernel/recweb/attpw4g" ]; then
verap=$(cat /etc/kernel/recweb/attpw4g)
else
echo -e $verp >/etc/kernel/recweb/attpw4g
verap=$(cat /etc/kernel/recweb/attpw4g)
fi
if [ -e "/etc/kernel/recweb/attweb" ]; then
veraw=$(cat /etc/kernel/recweb/attweb)
else
echo -e $verw >/etc/kernel/recweb/attweb
veraw=$(cat /etc/kernel/recweb/attweb)
fi
echo "America/Sao_Paulo" > /etc/timezone &>/dev/null
ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime &>/dev/null
dpkg-reconfigure --frontend noninteractive tzdata &>/dev/null
clear
echo -e "\033[1;37m┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓\033[0m"
echo -e "\033[1;37m┃                       \033[38;5;118mPAINEL \033[38;5;190mINTERNET\033[38;5;197m-\033[38;5;164mSS\033[38;5;203mH\033[38;5;197m\033[1;37m                    ┃\E[0m"
echo -e "\033[1;1;37m┃   \033[1;33m[\033[1;31m!\033[1;33m]       \033[1;31mINSTALADA \033[1;32mVERSÃO: $verp \033[1;31mDO PW4G              \033[1;33m[\033[1;31m!\033[1;33m]\033[0m   \033[1;1;37m┃"
[[ "$verp" = "$verap" ]]  && {
sleep 0.2
} || {
echo -e "\033[1;1;37m┃   \033[5;33m[\033[1;31m!\033[1;33m]     \033[1;31mATUALIZAÇÃO \033[1;32mVERSÃO: $verap \033[1;31mPARA O PW4G          \033[1;33m[\033[1;31m!\033[1;33m]\033[0m   \033[1;1;37m┃"
}
echo -e "\033[1;1;37m┃   \033[1;33m[\033[1;31m!\033[1;33m]       \033[1;31mINSTALADA \033[1;32mVERSÃO: $verw \033[1;31mDO PAINELWEB         \033[1;33m[\033[1;31m!\033[1;33m]\033[0m   \033[1;1;37m┃"
[[ "$verw" = "$veraw" ]]  && {
sleep 0.2
} || {
echo -e "\033[1;1;37m┃   \033[5;33m[\033[1;31m!\033[1;33m]     \033[1;31mATUALIZAÇÃO \033[1;32mVERSÃO: $veraw \033[1;31mPARA O PAINELWEB     \033[1;33m[\033[1;31m!\033[1;33m]\033[0m   \033[1;1;37m┃"
}
echo -e "\033[1;37m┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫\033[0m"
echo -e "\033[1;37m┃\033[38;5;82mSISTEMA              \033[1;37m| \033[38;5;82mMEMÓRIA RAM          \033[1;37m| \033[38;5;82mPROCESSADOR     \033[1;37m┃"
echo -e "┃\033[38;5;196mOS: \033[1;37m$_system   | \033[38;5;196mTOTAL:\033[1;37m$_ram     | \033[38;5;196mNUCLEO: \033[1;37m$_core\033[0m   \033[1;37m┃"
echo -e "┃\033[38;5;196mHORÁRIO: \033[1;37m$_hora    | \033[38;5;196mEM USO: \033[1;37m$_usor     | \033[38;5;196mEM USO: \033[1;37m$_usop\033[0m   \033[1;37m┃"
echo -e "┃\033[38;5;150mFIREWALL: $firew      \033[1;37m| \033[38;5;150mBOT PW4G: $botp      \033[1;37m| \033[38;5;150mAUTO EXE: $autm\033[0m \033[1;37m┃"
echo -e "\033[1;37m┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫\033[0m"
echo -e "┃\033[1;31m[\033[1;36m01\033[1;31m] \033[1;37m• \033[1;33mATUALIZAR PAINELWEB INTERNET-SSH \033[1;32m>\033[1;33m>\033[1;31m>\033[0m \033[0m                  \033[1;37m┃"
echo -e "┃\033[1;31m[\033[1;36m02\033[1;31m] \033[1;37m• \033[1;33mRESTAURAR BANCO DE DADOS \033[1;32m>\033[1;33m>\033[1;31m>\033[0m \033[0m                          \033[1;37m┃"
echo -e "┃\033[1;31m[\033[1;36m03\033[1;31m] \033[1;37m• \033[1;33mFIREWALL ORACLE/AWS/AZR \033[1;32m>\033[1;33m>\033[1;31m>\033[0m \033[0m                           \033[1;37m┃"
echo -e "┃\033[1;31m[\033[1;36m04\033[1;31m] \033[1;37m• \033[1;33mBAIXAR ÚLTIMA VERSÃO DO PW4G \033[1;32m>\033[1;33m>\033[1;31m>\033[0m                       \033[1;37m┃"
echo -e "┃\033[1;31m[\033[1;36m05\033[1;31m] \033[1;37m• \033[1;33mALTERAR A SENHA ROOT \033[1;32m>\033[1;33m>\033[1;31m>\033[0m \033[0m                              \033[1;37m┃"
echo -e "┃\033[1;31m[\033[1;36m06\033[1;31m] \033[1;37m• \033[1;33mGERENCIAR BOT PW4G \033[1;32m>\033[1;33m>\033[1;31m>\033[0m \033[0m                                \033[1;37m┃"
echo -e "┃\033[1;31m[\033[1;36m07\033[1;31m] \033[1;37m• \033[1;33mSPEED TEST \033[1;32m>\033[1;33m>\033[1;31m>\033[0m \033[0m                                        \033[1;37m┃"
echo -e "┃\033[1;31m[\033[1;36m08\033[1;31m] \033[1;37m• \033[1;33mAUTO EXECUÇÃO DO PW4G \033[1;32m>\033[1;33m>\033[1;31m>\033[0m \033[0m                             \033[1;37m┃"
echo -e "┃\033[1;31m[\033[1;36m09\033[1;31m] \033[1;37m• \033[1;33mREINICIAR VPS \033[1;32m>\033[1;33m>\033[1;31m>\033[0m \033[0m                                     \033[1;37m┃"
echo -e "┃\033[1;31m[\033[1;36m00\033[1;31m] \033[1;37m• \033[1;33mSAIR \033[1;32m<\033[1;33m<\033[1;31m<\033[0m \033[0m                                              \033[1;37m┃"
echo -e "\033[1;37m┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛\033[0m"
echo -ne "\033[1;37m┗━┫\033[1;32mO QUE DESEJA FAZER \033[1;31m? "; read -r x
case "$x" in
1 | 01)
painel_att
exit;
;;
2 | 02)
painel_rest
exit;
;;
3 | 03)
oracl
exit;
;;
4 | 04)
att_pw4g
exit;
;;
5 | 05)
senha_root
exit;
;;
6 | 06)
bot_telegram
exit;
;;
7 | 07)
clear
velocity
echo ""
echo -ne "\n\033[1;31mENTER \033[1;33mpara retornar ao \033[1;32mPW4G! \033[0m"; read
pw4g
exit;
;;
8 | 08)
autoexec
exit;
;;
9 | 09)
echo ""
echo -ne "\033[1;36mDESEJA REALMENTE REINICIAR [S/N]: \033[1;37m"; read x
[[ $x = @(n|N) ]] && pw4g
time_reboot "10"
exit;
;;
0 | 00)
echo -e "\033[1;31mSaindo...\033[0m"
sleep 2
clear
exit;
;;
*)
echo -e "\n\033[1;31mOpção inválida !\033[0m"
sleep 2
esac
done
} || echo -e "\E[41;1;37m         VOCÊ NÃO TEM PERMISSÃO        \E[0m" && sleep 4 && clear && exit 0