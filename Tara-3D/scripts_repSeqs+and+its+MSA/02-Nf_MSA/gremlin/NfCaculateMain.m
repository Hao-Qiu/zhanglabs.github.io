
fileFolder='E:\gapfilter\';
dirInput=dir(fullfile(fileFolder,'*.msa'));
fileNames={dirInput.name}';
numfiles=size(fileNames,1);
fid=fopen('E:\Nfstatics\NfScores.txt','w');
for j=1:numfiles
   filepath=strcat(fileFolder,fileNames{j,1});
   outfile=' ';
   eNf=getNfScore(filepath, outfile);
   name=fileNames{j,1};
   fprintf(fid,'%s\r',name(1:7));
   fprintf(fid,'%s\r\n',num2str(eNf));
end
fclose(fid);

		





function Nf = getNfScore(fname_train, outfile, varargin)
if(nargin>2)
  opts = varargin;
else
  opts = cell(0);
end;

if(mod(length(opts),2)~=0)
  error('Incorrect number of input parameters!');
  return;
end;
options = parse_gremlin_options(opts)

X  = read_msa(fname_train);
nStates= max(max(X));
if(isfield(options, 'reweight'))
  options.seqDepWeights = (1./(1+sum(squareform(pdist(X, 'hamm')<options.reweight))))';
  %disp(['reweighing sequences n ' num2str(size(X,1)) ' neff ' num2str(sum(options.seqDepWeights))]);
  Nf=sum(options.seqDepWeights)/sqrt(size(X,2));
end
end
