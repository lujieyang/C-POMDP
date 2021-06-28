function ra=GetRewardModelFixedA(RM,a)
%   Defines the reward function for a given action.
%
%   Particularizes a reward function defined on continuous state and action
%   spaces for a particular action 'a'.
%
%   The particularization is obtained by evaluating the Gaussians in 'a'
%   given when defining the model. The result is a Gaussian mixture in 's'.
%
%   See also CS_CA_RewardModel.

  w=RM.w.*cellfun(@(x)(Value(x,a)),RM.gA);
  ra=GMixture(w,RM.gS);
  
  