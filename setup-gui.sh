#! /bin/bash
arr=(
breeze-icon-theme # for partitionmanager
gdebi-core  # for beyond compare
gedit
ttf-wqy-zenhei 
)
sudo apt install -y "${arr[@]}"
sudo touch /root/.Xauthority

# Installing GUI applications may activate the graphical target.
sudo systemctl isolate multi-user.target
sudo systemctl set-default multi-user.target
