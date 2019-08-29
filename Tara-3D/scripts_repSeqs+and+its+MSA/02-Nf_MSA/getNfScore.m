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
