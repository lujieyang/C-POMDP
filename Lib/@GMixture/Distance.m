function d=Distance(gm1,gm2)
%   Approximated Kullback-Leibler distance between Gaussian mixture.
%
%   Returns the weighted KL distance between two Gaussian mixtures as
%   defined in Appendix A. 
%   
%   See also CompressGR.

  if (gm1.n==0)||(gm2.n==0)
    d=inf;
  else
    d=0;
    for i=1:gm1.n
      g1=gm1.g{i};
      d=d+gm1.w(i)*min(cellfun(@(g2)(GaussianKL(g1,g2)),gm2.g));
    end
  end
   