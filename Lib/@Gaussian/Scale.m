function gOut=Scale(g,a)
%  Product of a Gaussian and a constant (matrix).
%
%  Return the Gaussian resulting from applying the linear mapping A*g.

  gOut=Gaussian(a*g.m,a*g.S*a');
  