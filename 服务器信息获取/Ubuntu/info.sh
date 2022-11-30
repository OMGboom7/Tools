#! /bin/bash

echo -e "**************************************\033[41;30m系统信息\033[0m***************************************"
linux_edition=$(lsb_release -a|grep Description)
echo "系统版本:$linux_edition"

linux_bit=$(uname -a)
if (($linux_bit == 'x86_64')); then
  system_bit=64
else
  system_bit=32
fi
echo "系统位数:$system_bit"

cpu_num=$(cat /proc/cpuinfo | grep 'processor' | sort | uniq | wc -l)
echo "物理cpu个数:$cpu_num"

memory_total=$(free -h | grep 'Mem' | awk '{print $2}')
memory_free=$(free -m | grep 'Mem' | awk '{print $4}')
echo "总内存:${memory_total}"
echo "空闲内存:${memory_free}M"

mysql_disk_size=$(df -ah /home | grep 'home' | awk '{print $4}')
echo "/home空闲磁盘大小:$mysql_disk_size"

process=$(ps aux | wc -l)
echo "运行进程数:$process"

ip=$(/sbin/ifconfig -a | grep inet | grep -v 127.0.0.1 | grep -v inet6 | awk '{print $2}' | tr -d "addr:")
echo "服务器IP:$ip"

base_path=$(df -a | grep -v '/dev/mapper/centos-root' | grep -v 'tmpfs' | grep -v 'devtmpfs' | awk '{$1="";$2="";$3="";print $0}' | sort -rn | head -n 1 | awk '{print $3}')
base_path_size=$(df -ah ${base_path} | head -n 2 | tail -n 1 | awk '{print $4}')
echo "最大空闲磁盘:$base_path  空闲大小:$base_path_size"
