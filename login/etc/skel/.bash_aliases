# if you want to pass bash alias to other programs, you have to use like
#   watch -n 1 ${BASH_ALIASES[squeueF]}
# 
# If you use ZSH, you can simply use
#   watch -n 1 squeueF

alias squeueF='squeue --Format "JobID,Partition,Name,UserName,StateCompact,TimeUsed,NumCPUs,tres-per-node,Nice,PriorityLong,ReasonList" | column -t'

function sit
{
	if [[ "$ZSH_NAME" ]]; then 
		# If zsh runs with emulate -L, option changes are local.
		# But I still set local_options for safety.
		setopt local_options SH_WORD_SPLIT
	fi

	option=
	while [[ "$#" -gt 0 ]]; do
		case $1 in
			--internet) option="$option --x11 -w tatooine" ;;
			-g) option="$option --gres=gpu:1 --nice" ;;
			*) option="$option $1";;
		esac
		shift
	done
	
	command srun --pty $option $SHELL -i
}

if [[ "$ZSH_NAME" ]]; then 
	function _sit() {
		_arguments '-g[Use 1 GPU]' \
				'--internet[Choose a node with high speed Internet connection]'
	}

	compdef _sit sit
else
	complete -W "--internet -g" sit
fi

alias df-real='df -h -x tmpfs -x devtmpfs -x squashfs'
