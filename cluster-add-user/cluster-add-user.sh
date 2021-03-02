#!/bin/bash -e

username=$1
sudo adduser --conf adduser.conf --disabled-password $username

# create shared folder
sudo mkdir -p /home/shared/$username
sudo chown $username:$username /home/shared/$username
sudo ln -s /home/shared/$username /home/$username/shared

uid=$(id -u $username)
gid=$(id -g $username)

gecos=$(getent passwd $username | cut -d ':' -f 5)

cat <<HERE > ~/shared/remote-add-user
#!/bin/bash -e
sudo addgroup --gid $gid $username
# It's not documented clearly, but --gid requires the existence of GID.
sudo adduser --gecos "$gecos" --disabled-login --uid $uid --gid $gid $username
sudo usermod -aG aptuser $username

sudo ln -s /home/shared/$username /home/$username/shared
HERE

chmod +x ~/shared/remote-add-user

if ! ssh eureka ~/shared/remote-add-user; then
	echo "Failed to execute remote command,"
	echo "Please run ~/shared/remote-add-user on eureka"
fi

read -p "In the next screen, you will paste public key. Press enter to continue."
sudo mkdir -p /home/$username/.ssh
sudoedit /home/$username/.ssh/authorized_keys
sudo chmod 700 /home/$username/.ssh
sudo chmod 600 /home/$username/.ssh/authorized_keys
sudo chown -R $username:$username /home/$username/.ssh
