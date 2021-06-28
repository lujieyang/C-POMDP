function d=ProductNormFactor(g1,g2)
%   Normalization constant of the product of two Gaussians.
%
%   Returns the 'un-normalization' factor resulting from multiplying two
%   Gaussians.
%
%   See also Product, mtimes.

  d=Value(Gaussian(g2.m,g1.S+g2.S),g1.m);
