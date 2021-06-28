function OM=ObsModel(varargin)
%   ObsModel constructor.
%
%   Constructor of the observatin model base object.
%   This is used to be able to execute queries such as
%       isa(o,'ObsModel')
%   and to implement geniric observation model functions.
%
%   See also @ObsModel/Update.

  switch nargin
    
    case 0
      OM.dummy=1;
      OM=class(OM,'ObsModel');
      
    case 1
      if isa(varargin{1},'ObsModel')
        OM=varargin{1};
      else
        error('Wrong parameter type in ObsModel constructor');
      end
   
    otherwise
      error('Wrong number of parameters in ObsModel constructor');
  end