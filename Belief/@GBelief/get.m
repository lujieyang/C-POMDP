function v=get(gb,field)
%   Get for GBeliefs.
%
%   get function for Gaussian-based beliefs.
%
%   See also GBelief.

  switch field
    case 'maxC'
      v=gb.maxC;
      
    otherwise
      v=get(gb.GMixture,field);
  end
      