function value=get(P,field)
%  Get functio for POMDPs.
%
%  Get function for generic POMDP.
%  Possible fields to query are
%    - gamma (discount factor)
%    - name (name given to the POMDP. Used to generate output files).

  switch field
    case 'gamma'
      value=P.gamma;
    case 'name'
      value=P.name;
    otherwise
      error('Unknown field in POMDP get');
  end