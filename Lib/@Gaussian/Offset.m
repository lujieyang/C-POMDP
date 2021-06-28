function gOut=Offset(g,o)
%   Adds a constant to a Gaussian.
%
%   Apply a constnat offset to the Gaussian mean.

  gOut=Gaussian(g.m+o,g.S);
  