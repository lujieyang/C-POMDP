function gOut=minus(g,ct)
%   Substract a Gauussian and a constant/Gaussian.
%
%   Substracts two Gaussians or a constant from a Gaussian.

  gOut=plus(g,-ct);