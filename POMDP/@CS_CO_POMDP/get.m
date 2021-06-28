function value=get(P,field)
%  Get function for CS_CO_POMDPs.
%
%  Get function for POMDP on continuous state spaces but on discrete action
%  and observation spaces.
%  Possible fields to query are
%    - nSampledObs
%    - Any filed defined in higher levels of the POMDP object hierarchy
%
%  See also @CS_POMDP/get, @POMDP/get

  switch field
    case 'nSampledObs'
      value=P.nSampledObs;
    otherwise
      value=get(P.CS_POMDP,field);
  end
  