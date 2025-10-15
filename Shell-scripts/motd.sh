#!/bin/bash
#Murali Thangavel

White="\033[01;32m"
Blue="\033[01;35m"
Green="\033[02;36m"
Normal="\033[0m";

# Displaying colorful info: hostname, OS, kernel and username.
echo -e "$Blue"
echo -e "Hostname: $White$(hostname)$Blue."
swname=$(route |grep default|awk '{print $2}'|awk '{print substr($1,1,6)}')
  case "$swname" in
                austdc) echo -e "\033[01;35mSever located in \033[01;32mAustin Data center.$Blue" ;;
                scladc) echo -e "\033[01;35mSever located in \033[01;32mSanta Clara Data center.$Blue" ;;
                amil2d|defrou) echo -e "\033[01;35mSever located in \033[01;32mIsrael Data center.$Blue" ;;
                austra) echo -e "\033[01;35mSever located in \033[01;32mDMZ Austin Data center.$Blue" ;;
                sclab2) echo -e "\033[01;35mSever located in \033[01;32mDMZ Santa Clara Data center.$Blue" ;;
                iblrdc) echo -e "\033[01;35mSever located in \033[01;32m India Bangalore Data center.$Blue" ;;
                global) echo -e "\033[01;35mSever located in \033[01;32mAmsterdam Data center.$Blue" ;;
                xian00) echo -e "\033[01;35mSever located in \033[01;32mChina region.$Blue" ;;
                hsintc) echo -e "\033[01;35mSever located in \033[01;32mTaiwan region.$Blue" ;;
                *)echo -e "$red Unknown Datacenter !! $normal"  ;;
 esac
echo -e "OS: $White$(cat /etc/redhat-release)$Blue."
echo -e "Kernel version: $White$(uname -r)$Blue."
if [[ ! -f /etc/appname.txt ]];then
       echo "Role is not defined,please create /etc/appname.txt file."
else
echo -e "Role: $White$(cat /etc/appname.txt)$Blue."
fi

if [[ "root" == `whoami` ]] ; then
echo -e "$Blue"
echo -e "You're currently logged in as: $White$(whoami)$Blue."
echo -e "System Model: $White$(dmidecode -s system-product-name|grep -v "#")$Blue."
# Swap Usage Information
SwapFreeB=`cat /proc/meminfo | grep SwapFree | awk {'print $2'}`
SwapTotalB=`cat /proc/meminfo | grep SwapTotal | awk {'print $2'}`
SwapUsedB=`expr $SwapTotalB - $SwapFreeB`
SwapFree=`printf "%0.2f\n" $(bc -q <<< scale=2\;$SwapFreeB/1024/1024)`
SwapUsed=`printf "%0.2f\n" $(bc -q <<< scale=2\;$SwapUsedB/1024/1024)`
SwapTotal=`printf "%0.2f\n" $(bc -q <<< scale=2\;$SwapTotalB/1024/1024)`
# Memory usage Information
MemFreeB=`cat /proc/meminfo | grep MemFree | awk {'print $2'}`
MemTotalB=`cat /proc/meminfo | grep MemTotal | awk {'print $2'}`
MemUsedB=`expr $MemTotalB - $MemFreeB`
MemFree=`printf "%0.2f\n" $(bc -q <<< scale=2\;$MemFreeB/1024/1024)`
MemUsed=`printf "%0.2f\n" $(bc -q <<< scale=2\;$MemUsedB/1024/1024)`
MemTotal=`printf "%0.2f\n" $(bc -q <<< scale=2\;$MemTotalB/1024/1024)`

#Uptime
uptime=`cat /proc/uptime | cut -f1 -d.`
upDays=$((uptime/60/60/24))
upHours=$((uptime/60/60%24))
upMins=$((uptime/60%60))
upSecs=$((uptime%60))

if [ $upDays -gt 299 ]; then
        echo -e "\033[31mSystem Uptime: $upDays days $upHours hours $upMins minutes $upSecs seconds\t \e[5m<--- I'm tired$Normal"
else
        echo -e "\033[01;35mSystem Uptime:\e[33m $upDays days $upHours hours $upMins minutes $upSecs seconds"
fi

echo -e "\033[01;35mCPU Util =\e[33m `LANG=en_GB.UTF-8 mpstat 1 1 | awk '$2 ~ /CPU/ { for(i=1;i<=NF;i++) { if ($i ~ /%idle/) field=i } } $2 ~ /all/ { print 100 - $field "%"}' | tail -1`
\033[01;35mCPU Load =\e[33m `uptime | grep -ohe '[s:][: ].*' | awk '{ print "1m: "$2 " 5m: "$3 " 15m: " $4}'` "
echo -e "\033[01;35mSwap : \e[94mFree= ${SwapFree}GB, Used= ${SwapUsed}GB, Total= ${SwapTotal}GB"
echo -e "\033[01;35mMemory : \e[36mFree= ${MemFree}GB, Used= ${MemUsed}GB, Total= ${MemTotal}GB"
echo -e "\033[01;35mProcesses = \e[37m`ps -Afl | wc -l` running processes of `ulimit -u` maximum processes"
fi

echo -e "\033[31m";
echo -e "\tThis is a private system operated for Applied Materials only."
echo -e "Authorization from MIS management is required to use this system."
echo -e "Unauthorized use is prohibited and may result in prosecution."
echo -e $Normal

