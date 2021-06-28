function p=UniformProbability(CS)
%   Uniform probability value on a continuous space.
%
%   Returns the value of a uniform probability defined on the bounds of the
%   given continuous space.
%
%   See also @CSpace/UniformDistribution.

  p=prod(ones(1,CS.dim)./CS.range);
  