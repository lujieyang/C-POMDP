function v=rand(CS)
%   Random state from a continuous space.
%
%   Generates a random point in the bounds of the given continuous space
%   sampling with uniform probability.
%
  v=CS.min+rand(CS.dim,1).*CS.range;
  