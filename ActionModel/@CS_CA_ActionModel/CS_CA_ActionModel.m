function AM=CS_CA_ActionModel(varargin)
%   CS_CA_ActionModel constructor. 
%
%   Defines an Action Model on continuous state and action spaces.
%   Parameters:
%     S: The continuous state space
%     A: The continuous action space
%     B: Matrix defining a ineal mapping from 'a' to  's'. 
%        B*a gives a displacement in the state space.
%     S: Covariance for the white noise for all actions.
%        Noise for the displacement produced for each action (the same for
%        all actions in this implementation).
%
% See also CSpace.

  switch nargin
    case 1
      if isa(varargin{1},'CS_CA_ActionModel')
        AM=varargin{1};
      else
        error('Wrong parameter type in CS_CA_ActionModel constructor');
      end
    case 4
      
      if isa(varargin{1},'CSpace')
        AM.S=varargin{1};
      else
        error('Wrong parameter type in CS_CA_ActionModel constructor');
      end
      
      if isa(varargin{2},'CSpace')
        AM.A=varargin{2};
      else
        error('Wrong parameter type in CS_CA_ActionModel constructor');
      end
      
      if isa(varargin{3},'double')
        AM.B=varargin{3};
      else
        error('Wrong parameter type in CS_CA_ActionModel constructor');
      end
      
      if isa(varargin{4},'double')
        AM.Noise=varargin{4};
      else
        error('Wrong parameter type in CS_CA_ActionModel constructor');
      end
      
      AMBase=ActionModel();
      
      AM=class(AM,'CS_CA_ActionModel',AMBase);
      
    otherwise
      error('Wrong number of parameters in CS_CA_ActionModel constructor');
  end
  