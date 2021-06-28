function DRM=DiscretizeRewardModel(RM,A)
%   Discretizes the reward model on the action side.
%
%   Defines a reward function on continuous states and discrete actions 
%   from a reward function on continuous states and actions.
%   The provided set of 'samples' in the action space is used as the set of
%   actions in the discrete set to be defined.
%
%   Parameters:
%     RM: The continous state/action action model to be discretized.
%     A: The discrete set of actions to use in the discretization.
%
%   See also CS_DA_RewardModel.

  na=dim(A);
  
  r=cell(1,na);
  for i=1:na
    r{i}=GMixture(RM.w.*cellfun(@(ga)(Value(ga,A(i))),RM.gA),RM.gS);
  end
  
  DRM=CS_DA_RewardModel(RM.S,A,r);