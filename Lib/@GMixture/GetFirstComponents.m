function gmOut=GetFirstComponents(gm,m)
%   Gets the first components of a GMixture.
%
%   Returns a Gaussian mixture formed by the 'm' first elements of the
%   input mixture.

  if gm.n>m
    nw=gm.w(1:m);
    gmOut=GMixture(nw/sum(nw),gm.g(1:m));
  else
    gmOut=gm;
  end