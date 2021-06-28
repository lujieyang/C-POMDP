function P=CS_DO_DA_POMDP(varargin)
%   CS_DO_DA_POMDP constructor.
%
%   Constructor of POMDP with
%     - Continuous state spaces.
%     - Discrete observation spaces.
%     - Discrete action spaces.
%   
%   Parameters
%     name: POMDP name.
%     S: Continuos state space.
%     A: Discrete action space.
%     O: Discrete observation space.
%     AM: Action model.
%     OM: Observation model.
%     RM: Reward model.
%     gamma: Discount factor.
%     maxAlphaC: Maximum number of components in the Alpha mixtures.
%
%   This is the type of POMDP used in almost all the experiments in the
%   paper (Figures 1,2,3,4,5,6,7,9).

  switch nargin
    case 1
      if isa(varargin{1},'CS_DO_DA_POMDP')
        P=varargin{1};
      else
        error('Wrong parameter type in CS_DO_DA_POMDP');
      end
      
    case 9
      
      if isa(varargin{2},'CSpace')
        P.S=varargin{2};
      else
        error('Wrong parameter type in CS_DO_DA_POMDP');
      end

      if isa(varargin{3},'DSpace')
        P.A=varargin{3};
      else
        error('Wrong parameter type in CS_DO_DA_POMDP');
      end

      if isa(varargin{4},'DSpace')
        P.O=varargin{4};
      else
        error('Wrong parameter type in CS_DO_DA_POMDP');
      end

      if isa(varargin{5},'CS_DA_ActionModel')
        AM=varargin{5};
      else
        error('Wrong parameter type in CS_DO_DA_POMDP');
      end

      if isa(varargin{6},'CS_DO_ObsModel')
        OM=varargin{6};
      else
        error('Wrong parameter type in CS_DO_DA_POMDP');
      end
      
      if isa(varargin{7},'CS_DA_RewardModel')
        RM=varargin{7};
      else
        error('Wrong parameter type in CS_DO_DA_POMDP');
      end
      
      PBase=CS_DO_POMDP(varargin{1},varargin{8},varargin{9});
      
      P=class(P,'CS_DO_DA_POMDP',PBase,AM,OM,RM);
      
    otherwise
      error('Wrong number of parameters in CS_DO_DA_POMDP');
  end
