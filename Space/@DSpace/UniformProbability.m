function p=UniformProbability(DS)
%   Uniform probability value on a discrete space.
% 
%   Returns the probability value assigned to each point in the discrete
%   space by a uniform probability distribution.
%
%   See also @DSpace/UniformDistribution.

  p=1/DS.max;
  