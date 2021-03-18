#!/usr/bin/env python

import tensorflow as tf


print(f'tensorflow version is {tf.__version__}.')
print()

print("Number of physical GPUs: ", len(tf.config.experimental.list_physical_devices('GPU')))
print('If the number is different than expected, check tensorflow log if it has something like "Ignoring visible gpu device. The minimum required count is ..."')

tf.debugging.set_log_device_placement(True)
devices = tf.config.list_logical_devices('GPU')
print("Number of logical GPUs: ", len(devices))

if __name__ == '__main__':
	with open('data.txt', 'r') as f:
		size = int(f.readline())

	m = tf.random.uniform(shape=[size])
	print(m)
