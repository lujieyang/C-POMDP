function RM=DS_CA_RewardModel(varargin)
%   DS_CA_RewardModel constructor.
%
%   Defines a reward function on discrete state and continuous
%   action spaces, r(s,a).
%   This is the type of reward functions is not used in the paper. It is
%   the type of reward functions used in Spaan and Vlassis work (JAIR 2005)
%
%   Note that the mixture defining this type of reward model is not
%   normalized.
%
%   Parameters
%      S: Discrete state space.
%      A: Continuous action space.
%      r: A cell array of Gaussian mixture in 'a' (one for each state).

  switch nargin
    case 1
      if isa(varargin{1},'DS_CA_RewardModel')
        RM=varargin{1};
      else
        error('Wrong parameter type in DS_CA_RewardModel constructor');
      end
      
    case 3
      if isa(varargin{1},'DSpace')
        AM.S=varargin{1};
      else
        error('Wrong parameter type in DS_CA_RewardModel constructor');
      end
      if isa(varargin{2},'CSpace')
        AM.A=varargin{2};
      else
        error('Wrong parameter type in DS_CA_RewardModel constructor');
      end
      if isa(varargin{3},'cell')
        RM.r=varargin{3};
      end
      
      if dim(RM.S)~=size(RM.r,2)
        error('Size missmatch in DS_CA_RewardModel constructor');
      end
      
      RM=class(RM,'DS_CA_RewardModel');
    otherwise
      error('Wrong number of parameters in DS_CA_RewardModel constructor');
  end