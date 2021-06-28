function p=GaussianCPD(g,t)
%   Gaussian cummulative probability distribution.
%
%   Cumulative probability distribution for a point, t, in a 
%   uni-dimensional Gaussian.

  if g.dim>1
		error('Gaussian CPD is only defined one one-dimensional Gaussians');
  end
  p=0.5*(1+erf((t-g.m)/sqrt(2*g.S)));
  