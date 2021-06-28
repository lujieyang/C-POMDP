function DO_POMDP=DiscretizeObsModel(CO_POMDP)
%   Discretizes the observation model on the observation side.
%
%   Wrapper for the DS_CO_ObsModel/DiscretizeObsModel.
%
%   See also @DS_CO_ObsModel/DiscretizeObsModel.m.

  S=get(CO_POMDP,'StateSpace');
  A=get(CO_POMDP,'ActionSpace');
  nSampledObs=get(CO_POMDP,'nSampledObs'); 
  O=DSpace(nSampledObs);
  
  AM=get(CO_POMDP,'ActionModel');
  
  DS_CO_OM=get(CO_POMDP,'ObsModel');
  OM=DiscretizeObsModel(DS_CO_OM,nSampledObs);
  
  RM=get(CO_POMDP,'RewardModel');
  
  name=get(CO_POMDP,'name');
  gamma=get(CO_POMDP,'gamma');
  
  nSampledActions=get(CO_POMDP,'nSampledActions');
  
  DO_POMDP=DS_DO_CA_POMDP(name,S,A,O,AM,OM,RM,nSampledActions,gamma);
  