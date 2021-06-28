function d=SMahalanobis(G,p)
%  Squared Mahalanobis  of a point and a Gaussian.
%
%  Returns the squared Mahalanobis distance of a point, p, with respect to the given
%  Gaussian, G.
%
%  Returns:
%    d: The squared Mahalanobis distance of the point w.r.t. the Gaussian.

  vp=p-G.m;
  d=vp'*G.iS*vp;
  