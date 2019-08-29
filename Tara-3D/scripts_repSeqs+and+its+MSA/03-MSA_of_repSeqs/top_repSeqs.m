%function：置顶reformat.pl生成的.fasta文件中的代表性序列
%需要置顶standard seq的fasta
%-------------------------1.below maybe need changed-----------------------------------
input_dir='';
%-------------------------2.below maybe need changed-----------------------------------
fasta_namelist='';
%-------------------------3.below maybe need changed-----------------------------------
standardseq_dir='';
%-------------------------4.below maybe need changed:output_dir-----------------------------------
outputdir='';
namelist = dir(fasta_namelist);
num=size(namelist,1);
for j=1:num
    name=namelist(j,1).name;
    strname=name(1,1:7);
    strpath=strcat(input_dir,name);
    [Header, Sequence] = fastaread(strpath);
    if iscell(Header)==1
        HHheader=strings(size(Header,2),1);
        for k=1:size(Header,2)
            headername=Header{1,k};
            C = strsplit(headername,{'/',' '});
            HHheader(k,1)=string(C{1,1});
        end
        repseqPath=strcat(standardseq_dir,strname,'.hmm/',strname,'.hmm.fasta');
        [HH, Seq] = fastaread(repseqPath);
        SS=strsplit(HH,' ');
        str2=SS{1,1};
        repseqname=string(str2);
        
        [Hx,Wx]=find(HHheader(:,1)==repseqname);
        Mfirst=0;
        if isempty(Hx)==0
            Mfirst=Hx(1,1);
        else
            Mfirst=1;
        end
        %置顶，排序
        data=[];
        data(1).Header=Header{1,Mfirst};
        data(1).Sequence=Sequence{1,Mfirst};
        kk=1;
        for ii=1:k
            if ii~=Mfirst
                kk=kk+1;
                data(kk).Header=Header{1,ii};
                data(kk).Sequence=Sequence{1,ii};
            end
        end
        fastaMSApath=strcat(outputdir,strname,'.fasta');
        fastawrite(fastaMSApath, data)
    end
end