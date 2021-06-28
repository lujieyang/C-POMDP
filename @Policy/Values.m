function v=Values(P,b)
%   Belief value with all alpha-elements in the Policy.
%
%   Return the values of the given belief, b, for all the elements stored
%   in the Policy, P.
%   Recall that the optimal element for a belief is the one maximizing its
%   value, i.e., the one maximizing the output of this function.
%
%   See also MaxAlpha, OptimalAction.

  v=cellfun(@(e)(Expectation(b,e)),P.elements);
  