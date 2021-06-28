function DA_POMDP=DiscretizeActionModel(CA_POMDP,optimalAction,iteration)
% Discretizes the action space DS_DO_CA_POMDP.
%
%   Discretizes the action space of a DS_DO_CA_POMDP and returns a 
%   DS_DO_DA_POMDP.
%   The discretization affects the action space, the action model,
%   and reward model.
%   This function is used in Perseus (and iPerseus) in order to define a
%   POMDP with a discre action set so that the normal backup can be executed
%   without any issue. The discretization is 'belief' based (different for
%   each belief and it is executed just before the backup). 
%   The parameter 'optimalAction' is the optimal action for the belief in the
%   previous Perseus iteration. In the current implementation, this action
%   is added to the discrete set of actions.
%   Parameter 'iteration' is the current Perseus (or iPerseus) iteration. 
%   Right now the discretization is done sampling uniformly, but could also
%   progressively focus toward the optimal action as 'iteration' increases.
%
%   Parameters:
%     CA_POMDP: The DS_DO_CA input POMDP.
%     optimalAction: The previous optimal action .
%     iteration: Current iteration (not used in this implementation).
%
%   See also Perseus, iPerseus.

  S=get(CA_POMDP,'StateSpace');
  A=Discretize(CA_POMDP.A,CA_POMDP.nSampledActions-1,{optimalAction});
  O=get(CA_POMDP,'ObsSpace');
  
  AM=DiscretizeActionModel(CA_POMDP.DS_CA_ActionModel,A);
  OM=get(CA_POMDP,'ObsModel');
  RM=DiscretizeRewardModel(CA_POMDP.DS_CA_RewardModel,A);
  
  name=get(CA_POMDP,'name');
  gamma=get(CA_POMDP,'gamma');
  
  DA_POMDP=DS_DO_DA_POMDP(name,S,A,O,AM,OM,RM,gamma);
  