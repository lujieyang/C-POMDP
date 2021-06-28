function gmOut=plus(gm1,gm2) 
%   Adds two GMixtures.
%
%   Returns the Gaussian mixture resulting from adding the two input
%   mixtures.

  gmOut.w=[gm1.w gm2.w];
  gmOut.g=[gm1.g gm2.g];
  gmOut.n=gm1.n+gm2.n;
  gmOut=class(gmOut,'GMixture');
  