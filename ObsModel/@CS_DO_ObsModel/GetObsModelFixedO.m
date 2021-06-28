function p=GetObsModelFixedO(OM,o)
%   Defines p(o|s) for a fixed 'o'.
%
%   Instantiates the observation model for a particular observation 'o'.
%   We use the fact that p(o|s)=p(o,s)/p(s) and we assume a uniform
%   distribution in 's'.
%
%   The output is not normalized.
%
%   See also CS_CO_ObsModel.

  ps=UniformProbability(OM.S);
  p=OM.p{o}/ps;
  