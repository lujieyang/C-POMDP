function r=Reward(RM,a,s)
%   Evaluates the reward function.
%
%   Returns the value of the reward function for a given state 's' and
%   action 'a'.

  r=sum(RM.w.*cellfun(@(g)(Value(g,a)),RM.gA).*cellfun(@(g)(Value(g,s)),RM.gS));
 