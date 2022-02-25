#!/usr/bin/zsh

if [[ -z $1 ]] || [[ ! -d $1 ]]; then
	echo "Usage:\n$0 folder" >&2
	echo "\nIf the current machine is a compute node, run '$0 compute'." >&2
	echo "If the current machine is a login node, run '$0 login'." >&2
	exit 1
fi


function loginInstall
{
	# checkConnections is guaranteed to exist because it's from this repo.
	if grep -E '^session\s+required\s+pam_exec.so\s+stdout\s+/usr/libexec/checkConnections\s+10' /etc/pam.d/sshd > /dev/null; then
		echo 'not install checkConnections again.'
	else
		echo 'session required pam_exec.so stdout /usr/libexec/checkConnections 10' >> /etc/pam.d/sshd
	fi

	mkdir /etc/daily-tips
}

function computeInstall
{
read -d '' -r "zshAlias?" <<'HEREDOC'

function srun {
	read -k 1 -r  "REPLY?You are on a compute node. You should run $0 on a login node. Still anyway? "
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		command srun "$@"
	fi
}

function sbatch {
	read -k 1 -r  "REPLY?You are on a compute node. You should run $0 on a login node. Still anyway? "
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		command sbatch "$@"
	fi
}
HEREDOC

read -d '' -r "bashAlias?" <<'HEREDOC'

function srun {
	read -p "You are on a compute node. You should run srun on a login node. Still anyway? " -n 1 -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		command srun "$@"
	fi
}

function sbatch {
	read -p "You are on a compute node. You should run sbatch on a login node. Still anyway? " -n 1 -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		command sbatch "$@"
	fi
}
HEREDOC


	if grep -F 'function srun {' /etc/zsh/zshrc > /dev/null; then
		echo 'Do not install to zsh again.'
	else
		echo $zshAlias >> /etc/zsh/zshrc
	fi
	if grep -F 'function srun {' /etc/bash.bashrc > /dev/null; then
		echo 'Do not install to bash again.'
	else
		echo $bashAlias >> /etc/bash.bashrc
	fi
}

case $1 in
	compute)
		computeInstall
		;;
	login)
		loginInstall
		;;
	tatooine)
		mkdir /etc/exports.d
		;;
esac

foldersToCopy=(
etc/security/limits.d
usr/local/sbin/checkConnection
/lib/systemd/system/
)

function needCopy()
{
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


cd $1
for file in **/*(.)
do
	bn=$(basename $file)
	if [[ install.sh  = $bn ]]; then
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
