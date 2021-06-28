function AM=CS_DA_ActionModel(varargin)
%   CS_DA_ActionModel constructor.
%
%   Defines an Action Model on continuous state and discrete action spaces.
%   Parameters:
%     S: The continuous state space
%     A: The discrete action space
%     mean: Cell array with the displacements in state space produce for 
%           each action.
%     Sigma: Noise for each action (a single Covariance matrix if all
%            actions produce same noise).


  switch nargin
    case 1
      if isa(varargin{1},'CS_DA_ActionModel')
        AM=varargin{1};
      else
        error('Wrong parameter type in CS_DA_ActionModel constructor');
      end
    case 4
      
      if isa(varargin{1},'CSpace')
        AM.S=varargin{1};
      else
        error('Wrong parameter type in CS_DA_ActionModel constructor');
      end
      
      if isa(varargin{2},'DSpace')
        AM.A=varargin{2};
      else
        error('Wrong parameter type in CS_DA_ActionModel constructor');
      end
      
      if isa(varargin{3},'cell') && isa(varargin{4},'cell') 
        na=dim(AM.A);
        if na~=size(varargin{3},2)
          error('Missmatch size in CS_DA_ActionModel constructor');
        end
        AM.gA=cell(1,na);
        sn=size(varargin{4},2);
        for i=1:na
          if sn==1 % Same noise for all actions
            AM.gA{i}=Gaussian(varargin{3}{i},varargin{4}{1});
          else
            AM.gA{i}=Gaussian(varargin{3}{i},varargin{4}{i});
          end
        end
      else
        error('Wrong parameter type in CS_DA_ActionModel constructor');
      end
      
      AMBase=ActionModel();
      
      AM=class(AM,'CS_DA_ActionModel',AMBase);
    otherwise
      error('Wrong number of parameters in CS_DA_ActionModel constructor');
  end
  
  