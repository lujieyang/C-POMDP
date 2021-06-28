function [p v]=UniformDistribution(DS)
%   Uniform probability on a discrete space.
%  
%   Generates a uniform distribution on the given discrete space.
%   The output is a column vector with the size of the dimensionality of
%   the given discrete space with all entries with the same value (that
%   given by the UniformProbability function).
%
%   See also @DSpace/UniformProbability.

  p=ones(DS.max,1)/DS.max;
  v=1/DS.max;