#!/bin/bash

function checkLong() {
grep --exclude-dir=.git --no-filename --only-matching -rw -E \
-e 'sacct.+$' \
-e 'sacctmgr.+$' \
-e 'salloc.+$' \
-e 'sattach.+$' \
-e 'sbatch.+$' \
-e 'sbcast.+$' \
-e 'scancel.+$' \
-e 'scontrol.+$' \
-e 'scrontab.+$' \
-e 'sdiag.+$' \
-e 'sh5util.+$' \
-e 'sinfo.+$' \
-e 'sprio.+$' \
-e 'squeue.+$' \
-e 'sreport.+$' \
-e 'srun.+$' \
-e 'sshare.+$' \
-e 'sstat.+$' \
-e 'strigger.+$' \
-e 'sview.+$' \
"$1" | grep -P -e '--(?!.*(pty|nice))\w+(?!=)\b'
}
