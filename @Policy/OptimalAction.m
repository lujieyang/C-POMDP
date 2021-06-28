function [a v]=OptimalAction(P,b)
%   Returns the optimal action for a given belief.
%
%   Returns the action associated with the element that maximizes the Policy
%   value for a given belief.
%   Additionally it also returns the maximazing value for the belief.
%
%   See also Policy.

  [v nAlpha]=max(Values(P,b));
  a=P.actions{nAlpha};