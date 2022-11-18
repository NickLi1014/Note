#!/bin/bash
RED='\033[0;31m'
NC='\033[0m' #No Color
Yellow='\033[33m'
echo "----------wellcome to VM.sh----------"

function lobby(){ #lobby functon
echo -e "${RED}choose your function ${NC}\n${Yellow}(1)network\n(2)sshd_hosts.deny\n(3)NTP\n(4)ssh_password ${NC}"
read -e  answer
case $answer in
    1)
echo -e "\033[33mYou choose network Y/N: \033[0m" && read -e  a

if [ "$a" == "Y" ]
then
network
else
lobby
fi
    ;;
    2)
echo "you select sshd_hosts.deny Y/N:"
    ;;
    3)
echo "you select NTP Y/N:"
    ;;
    4)
echo "you select ssh_passwrod Y/N:"
    ;;
esac
}

function check_ip (){
net_long=(`echo $ip | awk -F"." '{print NF}'`)
if [ $net_long -eq 4  ] ;then
count=(`echo $ip | awk -F. '{print $1,$2,$3,$4}'`)
net_v1=${count[0]}
net_v2=${count[1]}
net_v3=${count[2]}
net_v4=${count[3]}
else
echo -e "\033[33m IP $ip not available. \033[0m"
return 1
fi
for i in $net_v1 $net_v2 $net_v3 $net_v4 ;do
   if [[ $i =~ ^0[0-9]{1,2} ]];then
   echo -e "\033[33m IP $ip not available. \033[0m"
   exit 1
fi

   if [ $i -lt 255 -a $i -ge 0  ] ;then
   ipv4=true
else
   echo -e "\033[33m IP $IPADDR not available. \033[0m"
   exit 1
fi
done
while true;
do
if [ $? -eq 0 ];then
break
fi
done
}
#check_ip
#if [ $? -eq 0 ];then
#break
#fi


function network(){
echo -e "\033[33mHow many NIC? : \033[0m" && read -e NIC
if [ $NIC == 1 ] ;then
echo -e "\033[33minput your ip: \033[0m" && read -e ip
check_ip
echo -e "\033[33minput your mask ex(24) : \033[0m" && read -e mask
echo -e "\033[33minput your GW : \033[0m" && read -e gw
echo -e "\033[33minput your DNS : \033[0m" && read -e dns
nmcli con modify eth0 ipv4.addresses $ip/$mask ipv4.gateway $gw ipv4.dns $dns ipv4.method manual
nmcli con up eth0 >/dev/null

elif [ $NIC == 2 ] ;then
nmcli con show | grep eth0 >/dev/null && nmcli con show |grep eth1 >/dev/null
if [ $? == 0 ];then
#ch eth0
echo -e "\033[33minput your eth0 ip : \033[0m" && read -e ip
check_ip
echo -e "\033[33minput your mask ex(24) : \033[0m" && read -e mask
echo -e "\033[33minput your GW : \033[0m" && read -e gw
echo -e "\033[33minput your DNS : \033[0m" && read -e dns
echo -e "\033[35m------eth0------\nip  :$ip \nGW  :$gw\nDNS :$dns \033[0m"
nmcli con modify eth0 ipv4.addresses $ip/$mask ipv4.gateway $gw ipv4.dns $dns ipv4.method manual
nmcli con up eth0 >/dev/null
#ch eth1
echo -e "\033[33minput your eth1 ip : \033[0m" && read -e ip
check_ip
echo -e "\033[33minput your mask ex(24) : \033[0m" && read -e mask
echo -e "\033[33minput your GW : \033[0m" && read -e gw
echo -e "\033[33minput your DNS : \033[0m" && read -e dns
echo -e "\033[35m------eth1------\nip  :$ip \nGW  :$gw\nDNS :$dns \033[0m"
nmcli con modify eth1 ipv4.addresses $ip1/$mask ipv4.gateway $gw ipv4.dns $dns ipv4.method manual
nmcli con up eth1 >/dev/null
else
echo -e "\033[31mDont have eth0 or eth1 please check NIC \033[0m"
fi
else
network
fi
}

lobby

