function CS_DO_OM=DiscretizeObsModel(CS_CO_OM,V,ba,nSamples)
%   Discretizes the observation model on the observation side.
%
%   Implementation of the lossless discretization of the observation model
%   defined in section 6.2 of the paper. 
%   The output is an observation model on a continuous state space but on a
%   discrete a observation space. The dimensionality of this observation
%   space is given by the number of elements in V (number of alpha elements
%   in the previous iteration policy).
%   This is only use in the experiment in Figure 11.
%
%   See also MakeFigure11.

  nj=size(V); % number of synthetic observations
  oData=cell(1,nj); %Weights for the GMixtures in 's' (one for each element in 'V')
 

  % Sample the observations
  % Caution: 
  %     To actually get a good discrete observation model
  %     we must have p(s)=\sum_o p(s|o) p(o) = ct
  %     This is a strong assumption make in Section 5.1, page 14.
  %     If this is not this way the whole system breaks.
  %     Even with acarefully defined p(o,s) in  the CS_CO_ObsModel 
  %     p(s) would only be constant if we discretize the obs model with 
  %     a uniform sampling on the observation space. 
  %     This can only be achieved by carefully selecting the samples
  %     (this is what we do for one-dimensional obs. spaces) or using
  %     a very large number of uniformly sampled observations (that is
  %     what it should be done in higher dimensional observations).
  %     The number of observations to sample is probably so large that
  %     could make this approach not very useful.
  %
  if dim(CS_CO_OM.O)==1
    oMin=min(CS_CO_OM.O);
    oMax=max(CS_CO_OM.O);
    oStep=(oMax-oMin)/(nSamples-1);
    os=oMin:oStep:oMax;
  else
    DO=Discretize(CS_CO_OM.O,nSamples);
    os=zeros(dim(DO),nSamples);
    for i=1:nSamples
      os(:,i)=DO{i};
    end
  end
    
  nm=zeros(1,nj);
  po=UniformProbability(CS_CO_OM.O);  

  for i=1:nSamples
    o=os(:,i);
    
    [bao Os]=Update(CS_CO_OM,ba,o,CS_CO_OM.S);
    [v j]=max(Values(V,bao));
    
    if nm(j)==0
      oData{j}=get(Os,'w')/po;
    else
      oData{j}=oData{j}+get(Os,'w')/po;
    end
    nm(j)=nm(j)+1;
  end
  
  % Obs models are defined giving p(o,s) and
  % oData is a kind of p(o|s).
  % We use the fact that p(o,s)=p(o|s)*p(s)
  ps=UniformProbability(CS_CO_OM.S);  
  for i=1:nj
    if nm(i)==0
      oData{i}=GMixture();
    else
      oData{i}=GMixture(oData{i}*(ps/nSamples),CS_CO_OM.gS);
    end
  end

  CS_DO_OM=CS_DO_ObsModel(CS_CO_OM.S,DSpace(nj),oData);
  
