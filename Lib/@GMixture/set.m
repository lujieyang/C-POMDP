function gm=set(gm,field,value)
%  Set method for Gaussian mixtures.
%
%  Set function for Gaussian mixtures.
%  Possible fields to set:
%    - w Changes the vector of weigths for the mixture components.
  switch field
    case 'w'
      if size(value,1)==1 && size(value,2)==gm.n
        gm.w=value;
      else
        error('Missmatch size in GMixture set');
      end
    otherwise
      error('Unknown field in GMixture set');
  end