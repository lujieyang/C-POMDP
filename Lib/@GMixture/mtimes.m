function gm=mtimes(gm1,gm2)
%   Product of a GMixture and a constant/GMixture.
%
%   Returns the Gaussian mixutre resulting from multiplying the two input
%   parameters. Those can be two Gaussian mixtures or a Gaussian mixture
%   and double. In this second case the weigths of the mixture get scaled.
  if isa(gm1,'GMixture')
    if isa(gm2,'GMixture')
      gm=Product(gm1,gm2);
    else
      if isa(gm2,'double')
        gm=gm1;
        gm.w=gm2*gm.w;
      else
        error('Invalid parameter type in Gaussian mtimes')
      end
    end
  else
    gm=mtimes(gm2,gm1);
  end
  