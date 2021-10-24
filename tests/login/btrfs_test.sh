#!/bin/bash

setUp() {
	mkdir /ramdisks
	mount -t tmpfs tmpfs /ramdisks
	mkdir /ramdisks/raw /ramdisks/mnt
	dd if=/dev/zero of=/ramdisks/raw/disk0 bs=1M count=256


	# jb=$(jobs -p)
	# if [[ -n "$jb" ]]; then
	#   wait "$jb"
	# fi

	mkfs.btrfs /ramdisks/raw/disk0
	mount -o loop /ramdisks/raw/disk0 /home

}



testWhenDiskMoreThan45 () {
	dd if=/dev/urandom of=/home/filler.bin bs=1M count=80 >/dev/null
	percent=$(df --output=pcent --sync /home | grep -o -P '\d+')
	msg=$(/etc/update-motd.d/76-disk-quota 2>&1)

	if [[ "$msg" == *"ERROR"* ]]; then
		fail $"MOTD shouldn't throw error when /home is ${percent}% full but diskquota is not enabled.\n$msg"
	fi
}

source shunit2
