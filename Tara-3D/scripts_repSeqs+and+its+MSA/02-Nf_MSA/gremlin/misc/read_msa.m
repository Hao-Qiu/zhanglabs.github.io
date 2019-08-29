function X  = read_msa(fname_train)
[names,seqs]= textread(fname_train, '%s %s');
if(isempty(seqs{1}))%msa doesn't have names
  seqs = textread(fname_train, '%s');
end;

ll= length(seqs{1,1});
for j=2:size(seqs,1)
    la=length(seqs{j,1});
    aa=ll-la;
    if aa>0
        for ih=1:aa
          ss='-';
          seqs{j,1}=strcat(seqs{j,1},ss);
        end
    end
end


X= converttonumericmsa((seqs)); % now reads in msa file.
if (min(min(X)) == 0) 
   X = X + 1;
end
