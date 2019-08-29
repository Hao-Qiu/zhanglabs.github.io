#!/usr/bin/perl
use strict;
use warnings;
my $jobId="#JOBID#"; 
my $user=`whoami`;
###-------------------------1.below maybe need changed:output dir path-----------------------------------###
my $outputdir="";
###-------------------------2.below maybe need changed:profile hmm dir path-----------------------------------###
my $hmms_data_dir="";
###-------------------------3.below maybe need changed:dataset dir path-----------------------------------###
my $dataset_dir="";
chomp($user);
#Temporary storage path
`mkdir -p "/tmp/$user/$jobId"`;
#Store local data to a temporary file to prevent multiple simultaneous access to the same data.
`cp $outputdir/tmp/$jobId.list /tmp/$user/$jobId`;
#open the '.list' file, which store the name of hmm model
open(RD,"/tmp/$user/$jobId/$jobId.list");
my @array;
while(my $line=<RD>){
	chomp($line);
	push(@array,$line);
}
close(RD);
foreach my $chainId(@array){
	if(-e "$outputdir/$chainId/$chainId.sto.a3m"){
		next;
}

`mkdir -p "/tmp/$user/$jobId/$chainId"`;
`mkdir -p "$outputdir/$chainId"`;
chdir("/tmp/$user/$jobId/$chainId");

#commands
#get the MSA of Pfam families by hmmsearch tool
`hmmsearch -o /dev/null --noali --notextw --cpu 10 --incT 27 -T 27 -A /tmp/$user/$jobId/$chainId/${chainId}.sto  $hmms_data_dir/${chainId} $dataset_dir`;
# change the MSA's format (.sto) to '.fasta'
`reformat.pl /tmp/$user/$jobId/$chainId/${chainId}.sto /tmp/$user/$jobId/$chainId/${chainId}.fasta`;
#compute the MSA with consensus sequence
`hhconsensus -i /tmp/$user/$jobId/$chainId/${chainId}.fasta -id 90 -cov 75 -M 25 -oa3m /tmp/$user/$jobId/$chainId/${chainId}.a3m`;

#copy files to output_dir
`cp /tmp/$user/$jobId/$chainId/$chainId.sto $outputdir/$chainId`;
`cp /tmp/$user/$jobId/$chainId/$chainId.fasta $outputdir/$chainId`;
`cp /tmp/$user/$jobId/$chainId/$chainId.a3m $outputdir/$chainId`;

#change path
chdir("/temp/$user/");
#remove temporary files
`rm -rf /tmp/$user/$jobId/$chainId`;
}
`rm -rf /tmp/$user/$jobId`;