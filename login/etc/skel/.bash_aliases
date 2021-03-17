
function sinteractive
{
	command srun --pty "$@" bash -i
}

alias sinteractive-g='sinteractive --gres=gpu --nice'
