function r=Reward(RM,a,s)
%   Evaluates the reward function.
%  
%   Returns the value of the reward function for a given state 's' and
%   action 'a'.

  r=Value(RM.r{a},s) * 10;
  