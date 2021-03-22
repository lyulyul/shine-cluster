alias squeueF='squeue --Format "JobID:8,Partition:11,Name:10,UserName:10,StateCompact:4,TimeUsed:11,NumCPUs:5,tres-per-node:15,ReasonList"'

function sinteractive
{
	command srun --pty "$@" bash -i
}

alias sinteractive-g='sinteractive --gres=gpu --nice'
