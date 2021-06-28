function c=ProductInt(gm1,gm2)
%   Product and marginalization of two GMixtures.
%
%   Returns the result of multiplying two Gaussian mixtures and then
%   marginalizing all over the space where those Gaussians are defined.
%   The result is the sum of the product of pairs of weights in the
%   mixtures and the normalization factor of multiplying the corresponding
%   Gaussians.
%   This is used in Section 5.2 of the paper to compute tha alpha functions
%   to be used in the Backup.
% 
%   See also @Gaussian/ProductNormFator.

  c=0.0;
  if gm1.n>0
    %z=0*get(gm1.g{1},'mean');
    for i=1:gm1.n
      m1=get(gm1.g{i},'mean');
      S1=get(gm1.g{i},'covariance');
      val=cellfun(@(x)(Value(Gaussian(get(x,'mean'),S1+get(x,'covariance')),m1)),gm2.g);
      c=c+gm1.w(i)*sum(gm2.w.*val);
    end
  end
