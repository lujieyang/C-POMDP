function v=rand(DS)
%   Random state from a discrete space.
% 
%   Selects one of the possible values of the given discrete space randomly
%   with uniform probability.
%
%   See also DSpace.

  v=ceil(rand*DS.max);
  