#!/bin/bash -e

if [[ $EUID -eq 0 ]]; then
	echo "$0 is designed to run without prefixing sudo" >&2
	exit 1
fi

username=$1

if [[ "$username" == '-t' ]] || [[ "$username" == '--test' ]]; then
	localAptUserId=$(getent group aptuser | cut -d: -f3)
	remoteAptUserId=$(ssh eureka 'getent group aptuser' | cut -d: -f3)

	if [[ "$localAptUserId" != "$remoteAptUserId" ]]; then
		echo "Error: The id of group aptuser is $localAptUserId on local while $remoteAptUserId on remote."
	fi
	exit
fi


sudo adduser --conf adduser.conf --disabled-password $username

uid=$(id -u $username)
gid=$(id -g $username)

sudo btrfs qgroup create 1/$uid /home

sudo mv /home/$username /home/$username-tmp

sudo btrfs subvolume create -i 1/$uid /home/$username
sudo btrfs subvolume create -i 1/$uid /home/shared/$username
sudo chown $username: /home/$username
sudo chown $username: /home/shared/$username

# () opens a new bash
(shopt -s dotglob; sudo mv /home/$username-tmp/* /home/$username)
sudo rm -rf /home/$username-tmp

sudo ln -s /home/shared/$username /home/$username/shared

# When user runs `srun` on aha, the user's groups are captured
# on aha, then transfered to eureka. 
# Although we put the user to group aptuser, the sudoers file doesn't
# have corresponding rules so the user cannot run `sudo apt` on aha.
# Eureka has the corresponding sudoers rule.
sudo usermod -aG aptuser,conda-cache $username

sudo -u $username cp ../slurm-examples/* /home/$username/shared/



gecos=$(getent passwd $username | cut -d ':' -f 5)

cat <<HERE > ~/shared/remote-add-user
#!/bin/bash -e
sudo addgroup --gid $gid $username
# It's not documented clearly, but --gid requires the existence of GID.
sudo adduser --gecos "$gecos" --disabled-login --uid $uid --gid $gid $username
sudo usermod -aG conda-cache $username

sudo ln -s /home/shared/$username /home/$username/shared
HERE

chmod +x ~/shared/remote-add-user

if ! ssh eureka ~/shared/remote-add-user; then
	echo "Failed to execute remote command,"
	echo "Please run ~/shared/remote-add-user on eureka."
fi
if ! ssh tatooine ~/shared/remote-add-user; then
	echo "Failed to execute remote command,"
	echo "Please run ~/shared/remote-add-user on tatooine."
fi

read -p "In the next screen, you will paste public key. Press enter to continue."
sudo mkdir -p /home/$username/.ssh
sudoedit /home/$username/.ssh/authorized_keys
sudo chmod 700 /home/$username/.ssh
sudo chmod 600 /home/$username/.ssh/authorized_keys
sudo chown -R $username:$username /home/$username/.ssh
