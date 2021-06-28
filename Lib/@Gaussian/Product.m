function [g d]=Product(g1,g2)
%   Product of two Gaussians.
%
%   Returns the Gaussian resulting from multiplying two other Gaussians.
%   Note that the result of multiplying two Gaussians is a un-normalized
%   Gaussian. Here we return the normalized Gaussian 'g' and the
%   'un-normalization' factor 'd'.

  if g1.dim~=g2.dim
		error('Gaussians with different dimensions in Gaussian product');
  end
	
  iS=g1.iS+g2.iS;
  
  R=chol(iS);
  iR=R\eye(size(R));
  S=iR*iR';
  
  % Matlab object fields must be defined always in the same order...
  g.m=S*(g1.iS*g1.m+g2.iS*g2.m);
  g.dim=g1.dim;
  g.S=S;
  g.d=1/(prod(diag(R))^2);
  g.iS=iS;
  g.ct=1/sqrt(((2*pi)^g.dim)*g.d);
  
  g=class(g,'Gaussian');
	
  d=ProductNormFactor(g1,g2);
