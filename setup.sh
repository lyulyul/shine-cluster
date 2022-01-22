#! /bin/bash -e

sudo timedatectl set-timezone Asia/Macau
sudo systemctl isolate multi-user.target #立即运行multi-user.target，禁用其他target
sudo systemctl set-default multi-user.target #开机启动至multi-user.target

sudo update-grub
sudo apt update
sudo apt upgrade

sudo addgroup wheel
sudo chown :wheel /usr/bin/su
sudo chmod 4754 /usr/bin/su
sudo usermod -aG wheel $(whoami)


# 系统优化
sudo systemctl disable motd-news
sudo chmod -x /etc/update-motd.d/50-motd-news

# 禁止自动更新
sudo apt remove -y unattended-upgrades

# All nodes will use nfs for mounting.
sudo apt install -y nfs-common

