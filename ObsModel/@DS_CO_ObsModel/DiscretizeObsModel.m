function DS_DO_OM=DiscretizeObsModel(DS_CO_OM,V,AM,nSamples)
%   Discretizes the observation model on the observation side.
%
%   Implementation of the lossless discretization of the observation model
%   defined in Hoey and Poupart IJCAI 2005. 
%   The output is an observation model on a discrete state space but on a
%   discrete a observation space. The dimensionality of this observation
%   space is given by the number of elements in V (number of alpha elements
%   in the previous iteration policy).
%
%   None of the experiments actually use this observatio model so it might
%   include bugs.

  nj=size(V); % number of synthetic observations
  ns=size(DS_CO_OM.S);  
  nm=zeros(ns,nj);
  z=zeros(ns,1);
  for j=1:ns
    b=z;
    b(j)=1;
    ba=Move(AM,b);
    nm=zeros(nj,1);
    for i=1:nSamples
      o=rand(CS_CO_OM.O);
      Os=GetObsModelFixedO(CS_CO_OM,o);
      bao=Os.*ba;
      [v l]=max(Values(V,bao));
      
      nm(j,l)=nm(j,l)+1;
    end
  end
  
  nm=(1/nSamples)*nm;
  oData=cell(1,nj);
  for i=1:nj
    oData{i}=nm(i,:)';
  end
  
  DS_DO_OM=DS_DO_ObsModel(DS_CO_OM.S,DSpace(nj),oData);
   