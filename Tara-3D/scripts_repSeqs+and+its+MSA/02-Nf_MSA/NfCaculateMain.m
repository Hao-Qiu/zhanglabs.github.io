%function:计算NFscore，需要用到getNFScore.m及gremlin;
currentFolder = pwd;
addpath(genpath(currentFolder))
%-------------------------1.below maybe need changed:input_dir (msa_file)-----------------------------------
fileFolder='';
%-------------------------2.below maybe need changed:output_file-----------------------------------
output_file='';
dirInput=dir(fullfile(fileFolder,'*.msa'));
fileNames={dirInput.name}';
numfiles=size(fileNames,1);
fid=fopen(output_file,'w');
fprintf(fid,'%s\t','PFAM ID');
%-------------------------2.below maybe need changed:列名-----------------------------------
fprintf(fid,'%s\r\n','TaraProtein+UniRef100'); 
for j=1:numfiles
    j
   filepath=strcat(fileFolder,fileNames{j,1});
   outfile=' ';
   eNf=getNfScore(filepath, outfile);
   name=fileNames{j,1};
   fprintf(fid,'%s\t',name(1:7));
   fprintf(fid,'%s\t\n',num2str(eNf));
end
fclose(fid);