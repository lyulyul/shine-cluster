## slurm
```bash
sudo ln -s ~/mpi-servers/slurm/etc/slurm/cgroups.conf /etc/slurm/cgroups.conf
sudo ln -s ~/mpi-servers/slurm/etc/slurm/gres.conf /etc/slurm/gres.conf
sudo ln -s ~/mpi-servers/slurm/etc/slurm/slurm.conf /etc/slurm/slurm.conf
```

支持ssh证书登录
```bash
sudo ln -s ~/mpi-servers/etc/ssh/sshd_config.d/certificateLoginOnly.conf /etc/ssh/sshd_config.d/certificateLoginOnly.conf
sudo systemctl restart sshd
```
