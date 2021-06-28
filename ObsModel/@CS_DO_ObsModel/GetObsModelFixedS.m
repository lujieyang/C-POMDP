function p=GetObsModelFixedS(OM,s)
%   Defines p(o|s)
%
%   Instantiates the observation model for a particular observation 'o'.
%   We use the fact that p(o|s)=p(o,s)/p(s) and we assume a uniform
%   distribution in 's'.
%
%   Since the output is normalized p(s) is not actually needed.
%
%   See also CS_CO_ObsModel.

  p=cellfun(@(gm)(Value(gm,s)),OM.p);
  p=(p/sum(p))';
  