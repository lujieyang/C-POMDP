function P=set(P,field,value)
% Set function for PODMP (base type) 
% 
% Allows to change some fields of the basic POMDP structure
%
% Possible fields to change are
%    - gamma (discount factor)
%    - name (name given to the POMDP. Used to generate output files).

  switch field
    case 'gamma'
      P.gamma=value;
    case 'name'
      P.name=value;
    otherwise
      error('Unknown field in POMDP set');
  end

  
