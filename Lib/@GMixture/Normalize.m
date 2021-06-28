function gmC=Normalize(gm)
%   Normalize a GMixture.
%
%   Normalize the weights of a Gaussian mixture. All weights are converted
%   to possitive in the range [0,1] and their sum is set to 1.
  w=abs(gm.w);
  gmC=GMixture(w/sum(w),gm.g);
  