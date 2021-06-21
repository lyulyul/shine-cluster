#!/usr/bin/zsh -e

while true; do
	case $1 in
		--email)
			email=$2; shift 2;;
		--public-key)
			publicKey=$2; shift 2;;
		*)
			break;;
	esac
done

username=$argv[-1]
[[ -z $email ]] && echo '--email is not specified.' >&2 && exit 1
[[ -z $publicKey ]] && echo '--public-key is not specified.' >&2 && exit 1



if (( $argv[(Ie)--zsh] )); then
	s='--shell /usr/bin/zsh'
else
	s=''
fi

sudo adduser --conf adduser.conf --gecos ",,,,$email" --disabled-password $=s  $username

uid=$(id -u $username)
gid=$(id -g $username)

btrfs qgroup create 1/$uid /home

mv /home/$username /home/$username-tmp

btrfs subvolume create -i 1/$uid /home/$username
btrfs subvolume create -i 1/$uid /home/shared/$username
chown $username: /home/$username
chown $username: /home/shared/$username

# (D) sets the GLOB_DOTS option for the current pattern
mv /home/$username-tmp/*(D) /home/$username
rm -rf /home/$username-tmp

ln -s /home/shared/$username /home/$username/shared

sudo usermod -aG conda-cache $username

sudo -u $username cp -r ../slurm-examples /home/$username/shared/



gecos=$(getent passwd $username | cut -d ':' -f 5)

remoteFile=/home/$SUDO_USER/shared/remote-add-user
cat <<HERE > $remoteFile
#!/bin/bash -e
sudo addgroup --gid $gid $username
# It's not documented clearly, but --gid requires the existence of GID.
sudo adduser --gecos ",,,,$email" --disabled-login --uid $uid --gid $gid $username
sudo usermod -aG conda-cache $username

sudo ln -s /home/shared/$username /home/$username/shared
HERE

chmod +x $remoteFile

computeNodes=(
eureka
tatooine
)

for server in "$computeNodes[@]"
do
	echo $server
	if ! sudo -u $SUDO_USER ssh -o StrictHostKeyChecking=no $server $remoteFile; then
		echo "Failed to execute remote command, please run ~/shared/remote-add-user on $server."
	fi
done

sudo mkdir -p /home/$username/.ssh
echo $publicKey > /home/$username/.ssh/authorized_keys
sudo chmod 700 /home/$username/.ssh
sudo chmod 600 /home/$username/.ssh/authorized_keys
sudo chown -R $username:$username /home/$username/.ssh

emailBody="Account: $username
Public Key: $publicKey"
sendemail -f aha@ipm.edu.mo -t $email -s mail.ipm.edu.mo -u 'Shine Cluster Account Created' -m "$emailBody"
