#! /usr/bin/bash

# 设置job名称，能不能有空格参见 https://slurm.schedmd.com/sbatch.html
#SBATCH --job-name=torch-on-gpu

# 在一个节点运行
#SBATCH --nodes=1

# 把输出重定向到文件，%j表示任务编号。其他写法参见同一链接。
#SBATCH --output=%j.out

# 使用1个GPU、1个CPU
#SBATCH --gres=gpu:1
#SBATCH --nice
#SBATCH --cpus-per-task=1

# 设置此任务的最长运行时间为7小时56分钟。其他写法参见同一链接。
##SBATCH --time=7:55:44
#SBATCH --time=01:00

# 邮件提醒。其他选项值参见同一链接。
##SBATCH --mail-type=BEGIN
##SBATCH --mail-user=your-email@ipm.edu.mo

#SBATCH --check-doc=https://slurm.schedmd.com/

source /opt/anaconda3/bin/activate
conda activate torch
# -u: disable buffer, let print flush to the output file.
python -u pytorch.py
