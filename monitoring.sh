#!/bin/bash

architecture=$(uname -a)
cpu=$(grep "physical id" /proc/cpuinfo | sort | uniq | wc -l)
vcpu=$(grep "^processor" /proc/cpuinfo | wc -l)

ram_used=$(free --mega -t | awk -vORS=' ' '{print $3}' | awk '{print $2""}')
ram_total=$(free --mega -t | awk -vORS=' ' '{print $2}' | awk '{print $2"MB"}')
ram_percent=$(free -t | awk 'NR == 2 {$4=$3/$2*100; printf("%.1f%%"), $4}')

disk_usage=$(df -m --output=used --total | awk 'END {print $1}')
disk_total=$(df -h --output=size --total | awk 'END {print $1}')
disk_percent=$(df --total | grep 'total' | rev | cut -d ' ' -f 2 | rev)

cpu_load=$(top -bn1 | grep '^%Cpu' | cut -c 9- | xargs | awk '{printf("%.1f%%"), $1 + $3}')

last_boot=$(who -b | awk '{print $(NF-1) " " $(NF-0)}')

lvmt=$(lsblk | grep "lvm" | wc -l)
lvm_use=$(if [ $lvmt -eq 0 ]; then echo no; else echo yes; fi)

con_tcp=$(netstat -a | grep 'ESTABLISHED' | wc -l)
user_log=$(who | wc -l)

ip=$(hostname -I)
mac=$(ip link show | awk '$1 == "link/ether" {print $2}')

sudo=$(journalctl _COMM=sudo | grep COMMAND | wc -l)

#mem_usage=$ram_used/$ram_total ($ram_percent)

wall "
#Architecture: $architecture
#CPU physical : $cpu
#vCPU : $vcpu
#Memory Usagee: $ram_used/$ram_total ($ram_percent)
#Disk Usage: $disk_usage/$disk_total ($disk_percent)
#CPU load: $cpu_load
#Last boot: $last_boot
#LVM use: $lvm_use
#Connections TCP : $con_tcp ESTABLISHED
#User log: $user_log
#Network: IP $ip ($mac)
#Sudo : $sudo cmd"
