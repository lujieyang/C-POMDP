function [P id]=AddAlpha(P,element,action)
%   Adds a new alpha-element to a policy.
%
%   Adds a new element (with the associated action) to a given
%   policy object.
%   Returns the updated policy and the identifier assigned to 
%   the new element.
%
%   See also Policy.

  if P.n==0
    P.elements={element};
    P.actions={action};
    P.n=1;
  else
    P.elements=[P.elements {element}];
    P.actions=[P.actions {action}];
    P.n=P.n+1;
  end
  id=P.n;
