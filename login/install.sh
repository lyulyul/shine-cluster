#!/usr/bin/zsh




function needCopy()
{
	foldersToCopy=(etc/systemd)
	file=$1
	for folder in $foldersToCopy
	do
		#echo "file=$file, folder=$folder"
		if [[ $file = ${folder}* ]]; then
			return 0
		fi
	done
	return 1
}

untrackedFiles=$(git status -uall --short --porcelain | awk '$1==''"??"'' {print $2}')


for file in **/*(.)
do
	if [[ $0 = *$file ]]; then
		echo "skip install file"
		continue
	fi

	if (( ${untrackedFiles[(Ie)$file]} )); then
		echo "skip untracked file: $file"
		continue
	fi

	if needCopy $file ; then
		# echo "copy $file"
		cp $PWD/$file /$file
	else
		# echo "link $file"
		ln -s $PWD/$file /$file
	fi
done

if [[ -f /usr/libexec/checkConnections ]]; then
	if grep -E '^session\s+required\s+pam_exec.so\s+stdout\s+/usr/libexec/checkConnections\s+10' /etc/pam.d/sshd > /dev/null; then
		echo 'not install checkConnections again.'
	else
		echo 'session required pam_exec.so stdout /usr/libexec/checkConnections 10' >> /etc/pam.d/sshd
	fi
else
	echo '/usr/libexec/checkConnections not found' >&2
fi
