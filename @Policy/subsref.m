function [e a]=subsref(P,S)
%   Gets alpha-elements from a policy.
%
%   Retrives a given element (and the associated action) from a Policy
%   object. 
%
%   Example of use:  [e a]=P{1};
%
  if strcmp(S.type,'{}')
    e=P.elements{S.subs{:}};
    a=P.actions{S.subs{:}};
  else
    error('Undefined Polcy subsref')
  end
