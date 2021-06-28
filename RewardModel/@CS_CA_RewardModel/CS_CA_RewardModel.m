function RM=CS_CA_RewardModel(varargin)
%   CS_CA_RewardModel constructor.
%
%   Defines a reward function on continuous state and 
%   action spaces, r(s,a).
%   This kind of reward models is never directly used since continuous
%   action spaces are discretized (See line 14a of Table 2 in page 21 in
%   the paper).
%
%   Note that the mixture defining this type of reward model is not
%   normalized.
%
%   Parameters
%      S: Continuous state space.
%      A: Continuous action space.
%      w: weights of the double mixture.
%      gS: Gaussians in 's'.
%      gA: Gaussians in 'a'.


  switch nargin
    case 1
      if isa(varargin{1},'CS_CA_RewardModel')
        RM=varargin{1};
      else
        error('Wrong parameter type in CS_CA_RewardModel constructor');
      end
    case 5
      if isa(varargin{1},'CSpace')
        RM.S=varargin{1};
      else
        error('Wrong parameter type in CS_CA_RewardModel constructor');
      end
      if isa(varargin{2},'CSpace')
        RM.A=varargin{2};
      else
        error('Wrong parameter type in CS_CA_RewardModel constructor');
      end
      if isa(varargin{3},'double')
        RM.w=varargin{3};
      end
      if isa(varargin{4},'cell')
        RM.gS=varargin{4};
      end
      if isa(varargin{5},'cell')
        RM.gA=varargin{5};
      end
      
      RM=class(RM,'CS_CA_RewardModel');
      
    otherwise
      error('Wrong number of parameters in CS_CA_RewardModel constructor');
  end
  