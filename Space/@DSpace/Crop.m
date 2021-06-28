function sOut=Crop(DS,s)
%   Forces a state to be in a given discrete space.
%
%   Ensures 's' to be an integer in between 1 and the number of
%   dimensionality of the given discrete space.

  sOut=floor(min(max(s,1),DS.max));
  