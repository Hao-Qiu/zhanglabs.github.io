#!/usr/bin/perl
use strict;
use warnings;
my $jobId="#JOBID#"; 
my $user=`whoami`;
chomp($user);
###-------------------------1.below maybe need changed:input dir path(representative sequences of PFAM families)-----------------------------------###
my $standard_seq_dir="";
###-------------------------2.below maybe need changed:work dir path-----------------------------------###
my $workdir="";
###-------------------------3.below maybe need changed:hhfilter output dir path-----------------------------------###
my $hhfilter_dir="";
###-------------------------4.below maybe need changed:profile hmm dir path-----------------------------------###
my $new_hmm_dir="";
###-------------------------3.below maybe need changed:dataset dir path-----------------------------------###
my $dataset_dir="";
open(RD,"$workdir/tmp/$jobId.list");
my @array;
while(my $line=<RD>){
	chomp($line);
	push(@array,$line);
}
close(RD);
foreach my $chainId(@array){
	if(-e "$new_hmm_dir/$chainId"){
		next;
}
#change path
chdir("$standard_seq_dir/$chainId");
#commands
#get initial MSA of representative sequence by hhblits tools
`hhblits -cpu 10 -i ${chainId}.fasta -d $dataset_dir -oa3m ${chainId}.a3m -n 8 -e 1E-20   -neffmax 20 -all`;
#filter the initial MSA
`hhfilter -i ${chainId}.a3m  -o $hhfilter_dir/${chainId}.a3m  -id 90 -cov 75 -M a2m`;
# change the format of filtered MSA
`reformat.pl $hhfilter_dir/${chainId}.a3m   $hhfilter_dir/${chainId}.a2m`;
#build the new hmm by hmmbuild tool
`hmmbuild $new_hmm_dir/${chainId}  $hhfilter_dir/${chainId}.a2m`;
}
