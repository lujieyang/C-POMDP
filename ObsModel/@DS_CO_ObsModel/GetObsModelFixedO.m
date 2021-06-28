function p=GetObsModelFixedO(OM,o)
%   Defines p(s|o).
%
%   Instantiates the observation model for a particular observation 'o'.
%   In this case, the output is a vector with one value 
%   for each state. The value for each state is obtained from evaluating 
%   the Gaussian mixture in 'o' given for the corresponding state in the
%   object constructor.
%
%   The output is not normalized.
%
%   See also DS_CO_ObsModel.

  p=cellfun(@(gm)(Value(gm,o)),OM.p)';

  