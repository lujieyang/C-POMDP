function DRM=DiscretizeRewardModel(RM,DS)
%   Discretizes the reward model on the state side.
%
%   Defines a reward function on discrete states and actions from a reward
%   function on continuous states and discrete actions.
%
%   See also DS_DA_RewardModel.

  ns=dim(DS);
  
  na=dim(RM.A);
  r=cell(1,na);
  for i=1:na
    r{i}=zeros(ns,1);
    for j=1:ns
      r{i}(j)=Value(RM.r{i},DS(j));
    end
  end
  
  DRM=DS_DA_RewardModel(DS,RM.A,r);