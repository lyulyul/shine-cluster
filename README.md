## 如果你遇到了一个bug……
请尝试确定是不是你的代码问题，是不是Python的问题（应该用Python 3.7，而你装了Python 3.8），是不是包的问题（应该用PyTorch 1.7，而你装了PyTorch 1.8），是不是Ubuntu的问题（在Windows上能运行，在Ubuntu上不能运行），是不是shell的问题（用Bash没问题，用ZSH有问题），是不是路径的问题（要访问C盘的文件，但服务器上没有C盘）。如果是集群配置的问题，请create issues。

如果你不能确定，也可以create issues。

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
sudo apt install -y build-essential zlib1g-dev libssl-dev autoconf 
sudo apt install -y libpam0g-dev libselinux1-dev

wget https://cloudflare.cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-8.4p1.tar.gz
tar -xzf openssh-8.4p1.tar.gz
cd openssh-8.4p1/

# https://unix.stackexchange.com/questions/313080/infinite-activating-state-for-custom-build-openssh-hpn-sshd-on-ubuntu-16
sudo apt install -y libsystemd-dev pkg-config
wget https://salsa.debian.org/ssh-team/openssh/-/raw/master/debian/patches/systemd-readiness.patch
patch -p1 < systemd-readiness.patch

autoreconf
./configure --prefix=/usr/ --with-systemd --with-md5-passwords --with-pam --with-selinux --with-privsep-path=/var/lib/sshd/ --sysconfdir=/etc/ssh 
make
./sshd -V; ./ssh -V #确保ssh和sshd都正常运行
sudo make install
/usr/sbin/sshd -V; /usr/bin/ssh -V #确保安装后也能运行
sudo systemctl restart ssh
```

## 安装7-zip
p7zip的最后更新时间是2016年，版本为16.02，而7-zip已经更新到了20。所以安装7-zip Linux版。

The multithreaded 7z/LZMA2 decompression was implemeted in 7-Zip 18.03. [ref](https://sourceforge.net/p/sevenzip/discussion/45797/thread/136f029b/#ff6a)

```bash
mkdir 7z
cd 7z
wget https://www.7-zip.org/a/7z2103-linux-x64.tar.xz
tar -xf 7z2103-linux-x64.tar.xz
sudo mv 7zz /usr/local/bin
sudo chown root: /usr/local/bin/7zz
sudo ln -s /usr/local/bin/7zz /usr/local/bin/7z
```

7z2103-linux-x64.tar.xz的帮助文件是HTML形式的，man命令看不了，所以就不安装了。


## Install

Adminstrators, please install your personal settings first.

```
git clone https://github.com/gqqnbig/mpi-servers.git
cd mpi-servers
git checkout migrate
sudo ./setup.sh
```
