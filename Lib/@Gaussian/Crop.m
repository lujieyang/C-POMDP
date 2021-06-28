function gOut=Crop(g,Sp)
%   Forces the Gaussian mean to be in a given space.
%
%   Crops the mean of a given Gaussian so that is is inside the
%   continuous sub-space defined by Sp.
%
%   See also CSpace.

  gOut=g;
  gOut.m=Crop(Sp,g.m);
  
