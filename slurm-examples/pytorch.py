#!/usr/bin/env python

import sys
import torch

print(f'Python version is {sys.version}.')
print(f'pytorch version is {torch.__version__}.')
print(f'CUDA version is {torch.version.cuda}.')
print()
print("Number of physical GPUs: ", torch.cuda.device_count())

if __name__ == '__main__':
	with open('data.txt', 'r') as f:
		size = int(f.readline())

	m = torch.rand(size)
	for i in range(torch.cuda.device_count()):
		print(m.cuda(i))
