#! /usr/bin/bash

# 设置job名称，注意不能有空格
#SBATCH --job-name=tf-on-gpu

# 在一个节点运行
#SBATCH --nodes=1

# 把输出重定向到文件，%j表示任务编号。其他写法参见 https://slurm.schedmd.com/sbatch.html 之 filename pattern
#SBATCH --output=%j.out

# 使用1个GPU、1个CPU
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=1

# 设置此任务的最长运行时间为7小时56分钟。其他写法参见 https://slurm.schedmd.com/sbatch.html
##SBATCH --time=7:55:44
#SBATCH --time=01:00

source /opt/anaconda3/bin/activate
conda activate tf
TF_CPP_MIN_LOG_LEVEL=2
./tf.py
