function p=GetObsModelFixedO(OM,o)
%   Defines p(o|s) for a fixed 'o'.
%
%   Instantiates the observation model for a particular observation 'o'.
%   The CS_CO_ObsModel defines p(o,s) via Kernel smoothing: using a double
%   Gaussian on 's' and on 'o'. From here:
%       p(o|s)=p(o,s)/p(s)
%   Where we assume p(s) as uniform.
%
%   The output is not normalized.
%
%   See also CS_CO_ObsModel

  w=OM.w.*cellfun(@(x)(Value(x,o)),OM.gO);
  ps=UniformProbability(OM.S);
  p=GMixture(w,OM.gS)/ps;
  