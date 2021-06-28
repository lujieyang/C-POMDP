function ra=GetRewardModelFixedA(RM,a)
%   Defines the reward function for a given action.
%
%   Particularizes a reward function defined on discrete state and
%   continuous action spaces for a particular action 'a'.
%
%   The particularization is obtained evaluating the set of Gaussian
%   mixtures in 'a' for the different states. The result is a column vector
%   with the same dimension as number of states in the state space.
%
%   See also DS_CA_RewardModel.

  ra=cellfun(@(x)(Value(x,a)),RM.r)';
  