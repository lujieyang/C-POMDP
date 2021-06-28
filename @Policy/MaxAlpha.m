function [nAlpha v]=MaxAlpha(P,b)
%   Returns the maximizing alpha-element for a belief.
%
%   Returns the identifier of the Policy element maximizing the value for a
%   given belief, b.
%   Additionally, it returns the actual value for the given belief.
%
%   See also Policy.

  [v nAlpha]=max(Values(P,b));
  