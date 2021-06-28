function gOut=uminus(g)
%   Inverts a the sign of a Gaussian.
%
%   Inverts a Gaussian. Returns a Gaussian with the same covariance as the
%   input one but where the sign of the mean is changed.
%

  gOut=g;
  gOut.m=-gOut.m;