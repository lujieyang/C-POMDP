function OM=DS_DO_ObsModel(varargin)
%   DS_DO_ObsModel constructor.
%
%   Defines an observation model (p(o|s)) on discrete state and 
%   observation spaces.
%
%   Parameters
%    S: Discrete state space.
%    O: Discrete observation space.
%    p: A cell array with one vector (of size of the number of states) for 
%       each obs.

  switch nargin
    case 1
      if isa(varargin{1},'DS_DO_ObsModel')
        OM=varargin{1};
      else
        error('Wrong parameter type in DS_DO_ObsModel constructor');
      end
    case 3
      if isa(varargin{1},'DSpace')
        OM.S=varargin{1};
      else
        error('Wrong parameter type in DS_DO_ObsModel constructor');
      end
      if isa(varargin{2},'DSpace')
        OM.O=varargin{2};
      else
        error('Wrong parameter type in DS_DO_ObsModel constructor');
      end
      
      if isa(varargin{3},'cell')
        OM.p=varargin{3}; % one vector (of size numStates) for each obs
        no=dim(OM.O);
        for i=1:no
          if nnz(OM.p{i})/numel(OM.p{i})<0.5
            OM.p{i}=sparse(OM.p{i});
          end
        end
      else
        error('Wrong parameter type in DS_DO_ObsModel constructor');
      end
      
      if dim(OM.O)~=size(OM.p,2) || dim(OM.S)~=size(OM.p{1},1) 
        error('Size missmatch in DS_DO_ObsModel constructor');
      end
      
      OMBase=ObsModel();
      
      OM=class(OM,'DS_DO_ObsModel',OMBase);
    otherwise
      error('Wrong number of parameters in DS_DO_ObsModel constructor');
  end