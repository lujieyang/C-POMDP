function RM=CS_DA_RewardModel(varargin)
%   CS_DA_RewardModel constructor.
%
%   Defines a reward function on continuous state and discrete
%   action spaces, r(s,a).
%   This is the type of reward functions defined at the end of section 5.1
%   in the paper.
%
%   Note that the mixture defining this type of reward model is not
%   normalized.
%
%   Parameters
%      S: Continuous state space.
%      A: Discrete action space.
%      r: A cell array of Gaussian mixture in 's' (one for each action).

  switch nargin
    case 1
      if isa(varargin{1},'CS_DA_RewardModel')
        RM=varargin{1};
      else
        error('Wrong parameter type in CS_DA_RewardModel constructor');
      end
    case 3
      if isa(varargin{1},'CSpace')
        RM.S=varargin{1};
      else
        error('Wrong parameter type in CS_DA_RewardModel constructor');
      end
      if isa(varargin{2},'DSpace')
        RM.A=varargin{2};
      else
        error('Wrong parameter type in CS_DA_RewardModel constructor');
      end
      if isa(varargin{3},'cell')
        RM.r=varargin{3}; 
      end
      
      if size(RM.r,2)~=dim(RM.A)
        error('Size missmatch in  CS_DA_RewardModel constructor');
      end
      
      RM=class(RM,'CS_DA_RewardModel');   
    otherwise
      error('Wrong number of parameters in CS_DA_RewardModel constructor');
  end
  