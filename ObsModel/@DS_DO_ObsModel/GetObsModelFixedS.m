function p=GetObsModelFixedS(OM,s)
%   Defines p(o|s).
%
%   Instantiates the observation model for a particular state 's'.
%   In this case, the output is a vector with the size of the
%   number of observation in the discrete observation space on which this
%   model is defined. This vector is defined selecting the element 's' from
%   the cell array of vectors (one for each observatoin) given in the
%   object constructor.
%
%   The output is normalized.
%
%   See also DS_DO_ObsModel.

  p=cellfun(@(x)(x(s)),OM.p);
  p=p/sum(p);
