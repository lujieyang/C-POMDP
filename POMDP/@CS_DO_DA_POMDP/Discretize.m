function DP=Discretize(CP,n)
%  Discretizes the state space of the CS_DO_DA_POMDP.
%
%  Converts a POMDP on a continuous state space (but discrete actions and
%  observations) into a POMDP on a discrete state space.
%  Parameter 'n' is the number of states of the output state space.
%  This procedure samples 'n' states (uniformly for one-dimensional
%  continuous state spaces and randomly for higher dimenional spaces) and
%  adjust the action/observation/reward models acordingly.
%  The name given to the output POMDP is the same as that of the input
%  POMDP but adding '-discrete' at the end. Remember that this name is used
%  to generate files of planning results.
%
  nameC=get(CP,'name');
  
  CS=get(CP,'StateSpace');
  CA=get(CP,'ActionSpace');
  CO=get(CP,'ObsSpace');
  
  COM=get(CP,'ObsModel');
  CAM=get(CP,'ActionModel');
  CRM=get(CP,'RewardModel');
  
  DS=Discretize(CS,n);
  DA=CA;
  DO=CO;
  
  DAM=DiscretizeActionModel(CAM,DS);
  DOM=DiscretizeObsModel(COM,DS);
  DRM=DiscretizeRewardModel(CRM,DS);
 
  gamma=get(CP,'gamma');
  
  nameD=sprintf('%s-discrete-%u',nameC,n);
  
  DP=DS_DO_DA_POMDP(nameD,DS,DA,DO,DAM,DOM,DRM,gamma);
  