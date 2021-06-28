function g=mtimes(g1,g2)
%   Product of a Gaussian and a constant/Gaussian.
%
%   Product of two Gaussians or of a Gaussian and a constant factor.
%   If the two parameters are gaussians it returns the Gaussian resulting 
%   from multiplying two other Gaussians.
%   Note that the result of multiplying two Gaussians is a un-normalized
%   Gaussian. Here, however, the output is normalized.
%   Function ProductNormFactor returns the scale factor that
%   'un-normalizes' the product.
%
%   If one of the inputs is a constant factor, say g2=A, we return the Gaussian
%   resulting from applying the linear mapping A*g1.
%
%   See also Product, Scale, ProductNormFactor.

  if isa(g1,'Gaussian')
    if isa(g2,'Gaussian')
      g=Product(g1,g2);
    else
      if isa(g2,'double')
        g=Scale(g1,g2);
      else
        error('Invalid parameter type in Gaussian mtimes')
      end
    end
  else
    g=mtimes(g2,g1);
  end