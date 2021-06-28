function p=GetObsModelFixedS(OM,s)
%   Defines p(o|s).
%
%   Instantiates the observation model for a particular state 's'.
%   In this case, the output is a Gaussian mixture in 'o' (obtained from
%   the set of mixtures given in the constructor).
%
%   The output is normalized.
%
%   See also DS_CO_ObsModel.

  p=OM.p{s};
  