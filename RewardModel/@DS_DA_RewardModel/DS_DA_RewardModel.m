function RM=DS_DA_RewardModel(varargin)
%   DS_DA_RewardModel constructor.
%
%   Defines a reward function on discrete state and 
%   action spaces, r(s,a).
%   This is the type of reward functions used in the usual POMDPs.
%
%   Parameters
%      S: Discrete state space.
%      A: Discrete action space.
%      r: A cell array iwth one column vector (of the dimension of the 
%         state space) for each action.


  switch nargin
    case 1
      if isa(varargin{1},'DS_DA_RewardModel')
        RM=varargin{1};
      else
        error('Wrong parameter type in DS_DA_RewardModel constructor');
      end
    case 3
      if isa(varargin{1},'DSpace')
        RM.S=varargin{1};
      else
        error('Wrong parameter type in DS_DA_RewardModel constructor');
      end
      if isa(varargin{2},'DSpace')
        RM.A=varargin{2};
      else
        error('Wrong parameter type in DS_DA_RewardModel constructor');
      end
      if isa(varargin{3},'cell')
        RM.r=varargin{3};
      end
      
      if dim(RM.S)~=size(RM.r{1},1)
        error('Size missmatch in DS_DA_RewardModel constructor');
      end
      
      if dim(RM.A)~=size(RM.r,2)
        error('Size missmatch in DS_DA_RewardModel constructor');
      end
      
      RM=class(RM,'DS_DA_RewardModel');
    otherwise
      error('Wrong number of parameters in DS_DA_RewardModel constructor');
  end