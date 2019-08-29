#!/bin/sh
#-------------------------1.below maybe need changed;-----------------------------------
input_dir=''
seqfilelist=`ls $input_dir`
for stofile in $seqfilelist
do

	extension=${stofile##*.}
	ext=a3m
	if [ $extension = $ext ]
	then
		perl seq_len.pl -i $input_dir/${stofile}  -percent  25
	fi
done

