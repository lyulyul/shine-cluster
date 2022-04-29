#!/bin/zsh

echo '#!/bin/zsh' > user-script.sh
echo "" >> user-script.sh

while IFS=: read -r username _ uid _ gecos _; do
	if ((uid>=5000 && uid<10000)); then
		echo "addgroup --gid $uid $username"
		echo "adduser --gecos \"$gecos\" --disabled-login --uid $uid --gid $uid $username"
		echo "ln -s /home/shared/$username /home/$username/shared"

		echo "mkdir -p /home/$username/.ssh"
		# One user may have multiple keys. Here we only get his last key for simplicity.
		authorized_keys=$(sudo tac /home/$username/.ssh/authorized_keys |egrep -m 1 .)
		echo 'echo "'"$authorized_keys"'"'" > /home/$username/.ssh/authorized_keys"
		echo "chmod 700 /home/$username/.ssh"
		echo "chmod 600 /home/$username/.ssh/authorized_keys"
		echo "chown -R $username:$username /home/$username/.ssh"		
	fi
done < /etc/passwd >> user-script.sh

