function d=diameter(CS)
%   Diameter of a continuous space.
%
%   Returns the diameter of the continuous space CS for each dimension.

  d=(CS.max-CS.min);
  