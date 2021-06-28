function C=Covariance(gm)
%   Average covariance of a Gaussian mixture.
%
%   Returns the weighted average of the covariance of the components in the
%   input Gaussian mixture.

  if gm.n>0
    C=gm.w(1)*get(gm.g{1},'covariance');
    for i=2:gm.n
      C=C+gm.w(i)*get(gm.g{i},'covariance');
    end
  else
    C=0;
  end
  