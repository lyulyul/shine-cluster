# if you want to pass bash alias to other programs, eg.
# watch -n 1 squeueF
# will not work. Instead, you use
# watch -n 1 ${BASH_ALIASES[squeueF]}


alias squeueF='squeue --Format "JobID,Partition,Name,UserName,StateCompact,TimeUsed,NumCPUs,tres-per-node,Nice,PriorityLong,ReasonList" | column -t'
