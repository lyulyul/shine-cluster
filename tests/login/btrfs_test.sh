#!/bin/bash

oneTimeSetUp() {
	mkdir /ramdisks
	mount -t tmpfs tmpfs /ramdisks
	mkdir /ramdisks/raw /ramdisks/mnt

}

setUp() {
	echo setup!
	dd if=/dev/zero of=/ramdisks/raw/disk0 bs=1M count=256


	# jb=$(jobs -p)
	# if [[ -n "$jb" ]]; then
	#   wait "$jb"
	# fi

	mkfs.btrfs /ramdisks/raw/disk0
	mount -o loop /ramdisks/raw/disk0 /home

}

tearDown() {
	echo 'umount'
	umount /home
}



testWhenDiskMoreThan45 () {
	dd if=/dev/urandom of=/home/filler.bin bs=1M count=80 >/dev/null
	percent=$(df --output=pcent --sync /home | grep -o -P '\d+')
	msg=$(/etc/update-motd.d/76-disk-quota 2>&1)

	assertNotContains $"MOTD shouldn't throw error when /home is ${percent}% full but diskquota is not enabled.\n$msg\n" \
					"$msg" "ERROR"
}

testAddNewUsers() {
	adduser --disabled-login --uid 5001 --gecos ',,,,' u1
	adduser --disabled-login --uid 5002 --gecos ',,,,' u2
	dd if=/dev/urandom of=/home/u1/filler.bin bs=1M count=80 >/dev/null
	dd if=/dev/urandom of=/home/u2/filler.bin bs=1M count=80 >/dev/null

	df -h --sync

	diskquote update


}

source shunit2
