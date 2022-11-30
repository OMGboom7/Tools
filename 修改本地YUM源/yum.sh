#! /bin/bash

# 挂载目录
local_dir=/mnt
# iso文件目录
iso_dir=/opt/centos-7-x86_64-DVD-1611.iso

mount $iso_dir $local_dir
# 备份并修改本地yum源
cp -rf /etc/yum.repos.d  /etc/yum.repos.d.bak
rm -rf /etc/yum.repos.d/*

cd /etc/yum.repos.d/
>Media.repo
echo '[iso]'                            >> Media.repo
echo 'name=Media'                       >> Media.repo
echo 'baseurl=file:///media/centos/'    >> Media.repo
echo 'gpgcheck=0'                       >> Media.repo
echo 'enabled=1'                        >> Media.repo

# 清除yum缓存
yum clean all
# 缓存本地yum源
yum makecache
# 测试yum本地源
yum list