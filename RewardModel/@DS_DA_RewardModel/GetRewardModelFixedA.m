function ra=GetRewardModelFixedA(RM,a)
%   Defines the reward function for a given action.
%  
%   Particularizes a reward function defined on discrete state and 
%   action spaces for a particular action 'a'.
%
%   The particularization is directly obtained from the vectors given in
%   the object definition. The output is a column vector with the size of
%   the state space.
%
%   See also DS_DA_RewardModel.

  ra=RM.r{a};
  