function GenerateFigure5Data(fname)
%   Generates the data for Figure 5.
%
%   In this experiment we compute the time (in seconds) for the first 
%   iteration of Perseus using different number of components to represent 
%   the beliefs and the alpha-mixtures. 
%   This give an idea of the complexity added when incresing the number of
%   components in the beliefs or in the alpha-mixtures.
%   Figure 6 shows the performace degradation when using too few components
%   in beliefs or in alpha-mixtures.
%
%   Parameters:
%     fname: file where to store the results.
%
%   See also MakeFigure1, MakeFigure5.

  cb=4:4:32;
  ca=9:3:33;
  
  stopCriteria=@(n,t,vc)(n>1);
  nRep=5; % times we repeat the first iteration to get an average value
  
  nb=size(cb,2);
  tb=zeros(1,nb);
  k=1;
  for ncBelief=cb
    [POMDP P]=GetTest1Parameters(ncBelief,9);
    
    fprintf('Sampling Beliefs\n');
    B=SampleBeliefs(POMDP,P.start,P.nBeliefs,P.dBelief,P.stepsXtrial,P.rMin,P.rMax);
    r=0;
    for s=1:nRep
      [V Val Alpha t]=Perseus(POMDP,B,stopCriteria);
      r=r+t(2);
    end
    tb(k)=r/nRep;
    k=k+1;
  end
  
  na=size(ca,2);
  ta=zeros(1,na);
  k=1;
  for ncAlpha=ca
    [POMDP P]=GetTest1Parameters(4,ncAlpha);
    
    fprintf('Sampling Beliefs\n');
    B=SampleBeliefs(POMDP,P.start,P.nBeliefs,P.dBelief,P.stepsXtrial,P.rMin,P.rMax);
    r=0;
    for s=1:nRep
      [V Val Alpha t]=Perseus(POMDP,B,stopCriteria);
      r=r+t(2);
    end
    ta(k)=r/nRep;
    k=k+1;
  end
  
  save(fname,'cb','tb','ca','ta');