function g=FuseComponents(gm)
%   Fuses a Gaussian mixture into a single Gaussian.
%
%   Summarizes the information on a Gaussian mixture into a single
%   Gaussian.
%   The mean of the output Gaussian is the weighted mean of the components
%   in the input mixture.
%   The covariance is basically the weighted mean of the covariance of the
%   components but it also take into account the dispersion of the mean of
%   the components.
%
%   See also @GMixture/Mean, @GMixture/Covariance, CompressGR.
  m=Mean(gm);
  S=Covariance(gm);
  for i=1:gm.n
    v=(get(gm.g{i},'mean')-m);
    S=S+gm.w(i)*(v*v');
  end
  g=Gaussian(m,S);
  