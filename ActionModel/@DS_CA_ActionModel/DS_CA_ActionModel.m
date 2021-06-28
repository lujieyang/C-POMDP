function AM=DS_CA_ActionModel(varargin)
%   DS_CA_ActionModel constructor. 
%
%   Defines an Action Model on discrete state and continuous action spaces.
%   Parameters:
%     S: The continuous state space
%     A: The discrete action space
%     T: Cell{nextState,currentState} of GMixtures in 'a'.
%
%   Note: This type of action models is not used in the current
%         implementation and, thus, is not fully debugged.
%         This action model is to be used when replicationg in the Vlassis
%         and Spaan (JAIR 2005 Section 5.2).


  switch nargin
    case 1
      if isa(varargin{1},'DS_CA_ActionModel')
        AM=varargin{1};
      else
        error('Wrong parameter type in DS_CA_ActionModel constructor');
      end
    case 3    
      if isa(varargin{1},'DSpace')
        AM.S=varargin{1};
      else
        error('Wrong parameter type in DS_CA_ActionModel constructor');
      end
      
      if isa(varargin{2},'CSpace')
        AM.A=varargin{2};
      else
        error('Wrong parameter type in DS_CA_ActionModel constructor');
      end
      
      if isa(varargin{3},'cell')
        AM.T=varargin{3};
      else
        error('Wrong parameter type in DS_CA_ActionModel constructor');
      end
      
      if dim(AM.S)~=size(RM.T,1) || dim(AM.S)~=size(RM.T,2)
        error('Size missmatch in DS_CA_ActionModel');
      end
      
      AMBase=ActionModel();
      
      AM=class(AM,'DS_CA_ActionModel',AMBase);
        
    otherwise
      error('Wrong number of parameters in DS_CA_ActionModel constructor');
  end
  