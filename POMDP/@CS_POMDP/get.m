function value=get(P,field)
%  Get function for CS_POMDPs.
%
%  Get function for POMDP on continuous state spaces (independently of the
%  observation and action space type).
%
%  Possible fields to query are
%    - maxAlphaC: maximum number of components in the alpha elements.
%    - Any filed defined in higher levels of the POMDP object hierarchy.
%
%  See also @POMDP/get.

  switch field
    case 'maxAlphaC'
      value=P.maxAlphaC;
    otherwise
      value=get(P.POMDP,field);
  end
  