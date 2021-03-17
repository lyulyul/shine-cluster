# if you want to pass bash alias to other programs, eg.
# watch -n 1 squeueF
# will not work. Instead, you use
# watch -n 1 ${BASH_ALIASES[squeueF]}


alias squeueF='squeue --Format "JobID:8,Partition:11,Name:10,UserName:10,StateCompact:4,TimeUsed:11,NumCPUs:5,tres-per-node:15,Nice:6,PriorityLong:12,ReasonList"'
