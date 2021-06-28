function p=GetObsModelFixedO(OM,o)
%   Defines p(s|o).
%
%   Instantiates the observation model for a particular observation 'o'.
%   In this case, the output is a vector with one value 
%   for each state. The value for each state is directly obtained from the
%   cell array of vectors (one for each observation) given in the
%   constructor.
%
%   The output is not normalized.
%
%   See also DS_DO_ObsModel.

  p=OM.p{o};
  