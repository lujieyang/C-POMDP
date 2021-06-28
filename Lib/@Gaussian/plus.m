function g=plus(g1,g2)
%   Adds a Gaussian and a constant/Gaussian.
%
%   Add two Gaussians: Add the mean and the covariance. This results on a
%   convolution of one Gassian into another.
%   If one of the parameters is not a Gaussian, we offset the mean of the
%   Gaussian given as a parameter.
%
%   See also offset.

  if isa(g1,'Gaussian')
    if isa(g2,'Gaussian')
      g=Gaussian(g1.m+g2.m,g1.S+g2.S);
    else
      if isa(g2,'double')
        g=Offset(g1,g2);
      else
        error('Invalid parameter type in Gaussian mtimes')
      end
    end
  else
    g=plus(g2,g1);
  end

  