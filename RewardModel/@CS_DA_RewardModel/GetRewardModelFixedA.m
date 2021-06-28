function ra=GetRewardModelFixedA(RM,a)
%    Defines the reward function for a given action.
%
%   Particularizes a reward function defined on continuous state and discrete
%   action spaces for a particular action 'a'.
%
%   The particularization is obtained directly from the set of Gaussian
%   mixtures given in the model definition. The result is a Gaussian
%   mixture in 's'.
%
%   See also CS_DA_RewardModel.

  ra=RM.r{a};
  