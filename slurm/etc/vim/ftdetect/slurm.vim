function CheckSlurmComment()
	let lines = getline(1,5)
	for l in lines
		if l =~ '^#SBATCH\s'
			set filetype+=.slurm
			break
		endif
	endfor
endfunction

au BufRead,BufNewFile *.slurm set filetype+=.slurm
au Syntax sh call CheckSlurmComment()
au Syntax python call CheckSlurmComment()
