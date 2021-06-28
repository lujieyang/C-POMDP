function AM=DS_DA_ActionModel(varargin)
%   DS_DA_ActionModel constructor.
%
%   Defines an Action Model on discrete state and action spaces.
%   Parameters:
%     S: The discrete state space
%     A: The discrete action space
%     T: cell(1,numActions) with a table p(nextState,currentState).



  switch nargin
    case 1
      if isa(varargin{1},'DS_DA_ActionModel')
        AM=varargin{1};
      else
        if isa(varargin{1},'double')
          AM.T=varargin{1}; % cell with Table(nextState,currentState)
          AM.na=size(RM.T,3);
          AM.ns=size(RM.T,1);
          AM=class(AM,'DS_DA_ActionModel');
        else
          error('Wrong parameter type in DS_DA_ActionModel constructor');
        end
      end
    case 3
      if isa(varargin{1},'DSpace')
        AM.S=varargin{1};
      else
        error('Wrong parameter type in DS_DA_ActionModel constructor');
      end
      
      if isa(varargin{2},'DSpace')
        AM.A=varargin{2};
      else
        error('Wrong parameter type in DS_DA_ActionModel constructor');
      end
      
      if isa(varargin{3},'cell')
        AM.T=varargin{3};
        na=dim(AM.A);
        for a=1:na
          if nnz(AM.T{a})/numel(AM.T{a})<0.5
            AM.T{a}=sparse(AM.T{a});
          end
        end
      else
        error('Wrong parameter type in DS_DA_ActionModel constructor');
      end
      
      if dim(AM.S)~=size(AM.T{1},1) || dim(AM.S)~=size(AM.T{1},2) || dim(AM.A)~=size(AM.T,2)
        error('Size missmatch in DS_CA_ActionModel');
      end
      
      AMBase=ActionModel();
      
      AM=class(AM,'DS_DA_ActionModel',AMBase);
    otherwise
      error('Wrong number of parameters in DS_DA_ActionModel constructor');
  end
  