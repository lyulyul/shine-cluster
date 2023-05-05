#!/bin/bash -e

# Requires a rootfull and privileged contrainer.

apt update
sed 's/#.*//' login/requirements.txt | xargs apt install -y
apt install -y wget

#git clone --depth 10 --branch v2.1.8 https://github.com/kward/shunit2.git /var/opt/shunit2
#export PATH="$PATH:/var/opt/shunit2/"



# Install mpi-servers
# Parenthesis runs in subshell.
(
./install.sh login
)


cd tests/login

wget https://raw.githubusercontent.com/kward/shunit2/d0a57ff2e6c5d8fbd27f9bebd1896037ce628f9d/shunit2
./btrfs_test.sh
