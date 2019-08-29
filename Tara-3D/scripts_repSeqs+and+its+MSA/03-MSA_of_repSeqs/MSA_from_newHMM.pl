#!/usr/bin/perl
use strict;
use warnings;
my $jobId="#JOBID#"; 
my $user=`whoami`;
chomp($user);
###-------------------------1.below maybe need changed:output dir path-----------------------------------###
my $outputdir="";
###-------------------------2.below maybe need changed:profile hmm dir path-----------------------------------###
my $hmms_data_dir="";
###-------------------------3.below maybe need changed:dataset dir path-----------------------------------###
my $dataset_dir="";

`mkdir -p "/tmp/$user/$jobId"`;
`cp $outputdir/tmp/$jobId.list /tmp/$user/$jobId`;
open(RD,"/tmp/$user/$jobId/$jobId.list");
my @array;
while(my $line=<RD>){
	chomp($line);
	push(@array,$line);
}
close(RD);

foreach my $chainId(@array){
	if(-e "$outputdir/$chainId/$chainId.a3m"){
		next;
}

`mkdir -p "/tmp/$user/$jobId/$chainId"`;
`mkdir -p "$outputdir/$chainId"`;
chdir("/tmp/$user/$jobId/$chainId");

#commands
# get the MSA using new HMM model by hmmsearch tool
`hmmsearch -o /dev/null --noali --notextw --cpu 10 --incT 27 -T 27 -A /tmp/$user/$jobId/$chainId/${chainId}.sto $hmms_data_dir/${chainId} $dataset_dir`;
#change the format of MSA to '.fasta'
`reformat.pl /tmp/$user/$jobId/$chainId/${chainId}.sto /tmp/$user/$jobId/$chainId/${chainId}.fasta`;


`cp /tmp/$user/$jobId/$chainId/$chainId.sto $outputdir/$chainId`;
`cp /tmp/$user/$jobId/$chainId/$chainId.fasta $outputdir/$chainId`;
#`cp /tmp/$user/$jobId/$chainId/$chainId.a3m $outputdir/$chainId`;
chdir("/temp/$user/");
`rm -rf /tmp/$user/$jobId/$chainId`;
}
`rm -rf /tmp/$user/$jobId`;
