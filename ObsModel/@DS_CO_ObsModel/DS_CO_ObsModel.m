function OM=DS_CO_ObsModel(varargin)
%   DS_CO_ObsModel constructor.
%
%   Constructor of observation models (p(o|s))  with continuous state 
%   spaces and discrete observation spaces.
%
%   Parameters
%     S: Discrete state space.
%     O: Continuous observation space.
%     p: One GMixture (in 'o') for each state.
%   
%   None of the experiments actually use this observatio model so it might
%   include bugs. This is to be used when replication Hoey's IJCAI'05 work

  switch nargin
    case 1
      if isa(varargin{1},'DS_CO_ObsModel')
        OM=varargin{1};
      else
        error('Wrong parameter type in DS_CO_ObsModel constructor');
      end
    case 3
      if isa(varargin{1},'DSpace')
        OM.S=varargin{1};
      else
        error('Wrong parameter type in DS_CO_ObsModel constructor');
      end
      if isa(varargin{2},'CSpace')
        OM.O=varargin{2};
      else
        error('Wrong parameter type in DS_CO_ObsModel constructor');
      end
      if isa(varargin{3},'cell')
        OM.p=varargin{3};
      else
        error('Wrong parameter type in DS_CO_ObsModel constructor');
      end
      
      if dim(OM.S)~=size(OM.p,2) 
        error('Size missmatch in DS_CO_ObsModel constructor');
      end
      
      OMBase=ObsModel();
      
      OM=class(OM,'DS_CO_ObsModel',OMBase);
      
    otherwise
      error('Wrong number of parameters in DS_CO_ObsModel constructor');
  end
  