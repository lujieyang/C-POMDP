function gmOut=GetRandomComponents(gm,m)
%   Selects components at random.
%
%   Returns a Gaussian mixture formed by 'm' elements of the
%   input mixture selected at random.
  
  rp=randperm(gm.n);
  lm=rp(1:m);
  nw=gm.w(lm);
  gmOut=GMixture(nw/sum(nw),gm.g(lm));
  