function sOut=Crop(CS,s)
%   Forces a state to be in a given continuous sub-space.
%
%   Crops the given state 's' with the boundary of the given continuous
%   space for all dimensions.

  sOut=min(CS.max,max(CS.min,s));
  