function [p v]=UniformDistribution(CS)
%   Uniform probability on a continuous space.
%
%   Generates a uniform distribution on the bounds defining the given
%   continuous space.
%   Right now, the output is a Gaussian mixture with a single component
%   with a spherical covariance defined given the bounds of the space in
%   each dimension.
%   
%   Parameters:
%     CS: The continuous space where to define the probability
%         distribution.
%   Outputs:
%     p: The Gaussian mixture.
%     v: Value for the distribution in the continuous space. This is lower
%        as the space gets larger. In principle this is the same value as
%        that returned by UniformProbability but it could be slightly
%        different since the returned distribution is only an approximation 
%        of the uniform distribution and not the real one.
%
%   See also @CSpace/UniformProbability.

  d=CS.max-CS.min;
  md=max(d);
  c=CS.min+d/2;
  g1=Gaussian(c,ones(CS.dim)*200*md);
  p=GMixture(1,{g1});
  v=Value(g1,CS.min);
  