function m=Mean(gm)
%   Mean of a Gmixture.
%
%   Returns the weighted average of the mean of the components in the
%   input Gaussian mixture.

  if gm.n>0
    m=gm.w(1)*get(gm.g{1},'mean');
    for i=2:gm.n
      m=m+gm.w(i)*get(gm.g{i},'mean');
    end
  else
    m=0;
  end
  