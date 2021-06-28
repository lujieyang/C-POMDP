function gmC=GetLargestComponents(gm,m)
%   Gets the components with the largest weigth.
%
%   Returns a Gaussian mixture formed by the 'm' elements of the
%   input mixture with larger weigth.

  if gm.n<=m
    gmC=gm;
  else
    [w ndx]=sort(gm.w,2,'descend');
    nw=gm.w(ndx(1:m)); 
    gmC=GMixture(nw/sum(nw),gm.g(ndx(1:m)));
  end