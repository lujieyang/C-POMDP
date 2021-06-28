function b=Valid(DS,s)
%   True for poins inside the discrete space.
%
%   Returns true if the given 's' is one of the valid values for the
%   discrete space 'DS' (i.e., it is an integer from 1 to 'dim').

  b=(s>0)&&(s<=DS.man)&&(floor(s)==s);
  