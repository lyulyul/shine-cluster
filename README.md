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

## 更新sshd

ref: [How to Install OpenSSH 8.0 Server from Source in Linux](https://www.tecmint.com/install-openssh-server-from-source-in-linux/)
```bash
ssh -V
# 如果版本小于8.4则要更新
sudo apt update 
sudo apt install -y build-essential zlib1g-dev libssl-dev
sudo apt install -y libpam0g-dev libselinux1-dev

wget https://cloudflare.cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-8.4p1.tar.gz
tar -xzf openssh-8.4p1.tar.gz
cd openssh-8.4p1/
./configure --with-md5-passwords --with-pam --with-selinux --with-privsep-path=/var/lib/sshd/ --sysconfdir=/etc/ssh 
make
./sshd -V; ./ssh -V #确保ssh和sshd都正常运行
sudo make install
sudo systemctl restart ssh
```
