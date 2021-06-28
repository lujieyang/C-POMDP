function d=GaussianKL(g1,g2)
%   Gaussian Kullback-Leibler distance.
%
%   Computes the KL distance between two Gaussians.

  if g1.dim~=g2.dim
    error('Non coherent sizes in GaussianKL');
  end
  m12=(g2.m-g1.m);
  d=0.5*( log(g2.d/g1.d) + trace(g2.iS*g1.S) + m12'*g2.iS*m12 - g1.dim);

