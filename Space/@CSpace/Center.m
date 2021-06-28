function c=center(CS)
%   Central point of a continuous space.
%
%   Returns the central point of the continuous space CS.

  c=(CS.max-CS.min)/2;
  