function p=GetObsModelFixedS(OM,s)
%   Defines p(o|s) for a fixed 's'.
%
%   Instantiates the observation model for a particular state 's'.
%
%   The CS_CO_ObsModel defines p(o,s) via Kernel smoothing: using a double
%   Gaussian on 's' and on 'o'. From here:
%       p(o|s)=p(o,s)/p(s)
%   Where we assume p(s) as uniform.
%
%   Observe that the output vector is normalized. In this way we do not
%   need to explicitly compute the normalization factor, p(s).
%
%   See also CS_CO_ObsModel

  w=OM.w.*cellfun(@(x)(Value(x,s)),OM.gS);
  p=Normalize(GMixture(w,OM.gO));
  