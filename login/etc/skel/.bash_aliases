# if you want to pass bash alias to other programs, you have to use like
#   watch -n 1 ${BASH_ALIASES[squeueF]}
# 
# If you use ZSH, you can simply use
#   watch -n 1 squeueF

alias squeueF='squeue --Format "JobID:8,Partition:11,Name:10,UserName:10,StateCompact:4,TimeUsed:11,NumCPUs:5,tres-per-node:15,ReasonList"'

function sinteractive
{
	command srun --pty "$@" bash -i
}

alias sinteractive-g='sinteractive --gres=gpu --nice'
