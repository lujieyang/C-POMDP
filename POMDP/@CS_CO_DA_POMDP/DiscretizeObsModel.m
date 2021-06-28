function DO_POMDP=DiscretizeObsModel(CO_POMDP,V,b,a)
%   Discretizes the observation model on the observation side.
%
%   Wrapper for the CS_CO_ObsModel/DiscretizeObsModel.
%
%   See also @CS_CO_ObsModel/DiscretizeObsModel.m.

  S=get(CO_POMDP,'StateSpace');
  A=get(CO_POMDP,'ActionSpace'); 
  O=DSpace(size(V));
  
  AM=get(CO_POMDP,'ActionModel');
  
  CS_CO_OM=get(CO_POMDP,'ObsModel');
  nSampledObs=get(CO_POMDP,'nSampledObs');
  ba=BeliefPrediction(AM,b,a,S);
  OM=DiscretizeObsModel(CS_CO_OM,V,ba,nSampledObs);
  
  RM=get(CO_POMDP,'RewardModel');
  
  name=get(CO_POMDP,'name');
  gamma=get(CO_POMDP,'gamma');
  ncAlpha=get(CO_POMDP,'maxAlphaC');
  
  DO_POMDP=CS_DO_DA_POMDP(name,S,A,O,AM,OM,RM,gamma,ncAlpha);
  