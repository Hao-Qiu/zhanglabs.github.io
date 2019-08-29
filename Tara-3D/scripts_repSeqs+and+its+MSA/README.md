Download these scripts as a zip archive at [https://zhanglab.ccmb.med.umich.edu/Tara-3D/scripts_repSeqs+and+its+MSA.zip](https://zhanglab.ccmb.med.umich.edu/Tara-3D/scripts_repSeqs+and+its+MSA.zip).

These scripts are used to select the Pfam families for predicting, and generate the representative sequences and their corresponding MSAs of selected Pfam families.  These scripts are divided into three parts: MSA generation, Nf caculation, and representative sequence and its MSA production.

Step 1: MSA generation  
   a) run ``MSA_from_seqs.pl`` for generating the MSA for all Pfam families;  
   b) run ``gapfilter.sh`` for filter the gaps of MSA;  

Step 2: Nf caculation  
   a) run ``preprocessMSA.m`` for removing the first line of MSA, which is the comment line;  
   b) run ``NfCaculateMain.m`` for calculating the Nf-score of Pfam family;  
	
Step 3: representative sequence and its MSA production  
   a) select the representative sequences for Pfam families by hmmsearch tool;  
   b) run ``buildhmm.pl`` for generating the new hmm model for representative sequence;  
   c) run ``MSA_from_newHMM.pl`` for generating the MSA for representative sequence;  
   d) run ``top_repSeqs.m`` for remove the representative sequence to the first position of MSA;  
   e) filter the preprocessed MSA by hhfilter as follows:  
   ```bash
   hhfilter -i filename.fasta -id 90 -cov 75 -M first -o filename.a3m;
   ```
   e) run ``gapfilter.sh`` for filter the gaps of MSA;  
	
Finally, the first sequence in the *.cut.msa or *.cut.fas file is the cut representative sequence, and the *.cut.msa or *.cut.fas 
file is its corresponding MSA. This file can be used to generating constraints for predicting the 3D structure of cut representative sequence. 
