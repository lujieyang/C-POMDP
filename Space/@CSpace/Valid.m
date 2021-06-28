function b=Valid(CS,s)
%   True for poins inside the continuous space.
%
%   Returns true if the state 's' is inside the bounds of the continuous
%   space CS for all dimensions.

  b=sum((CS.min<=s)&&(s<=CS.max))==CS.dim;
  