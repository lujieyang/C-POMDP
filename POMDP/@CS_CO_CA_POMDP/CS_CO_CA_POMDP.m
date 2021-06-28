function P=CS_CO_CA_POMDP(varargin)
%   CS_CO_CA_POMDP constructor.
%
%   Constructor of POMDP with
%     - Continuous state spaces.
%     - Continuous observation spaces.
%     - Continuous action spaces.
%   
%   Parameters
%     name: POMDP name.
%     S: Continuous state space.
%     A: Continuous action space.
%     O: Continuous observation space.
%     AM: Action model.
%     OM: Observation model.
%     RM: Reward model.
%     nSampledActions: Num. actions to sample when discretizing the action
%                      set
%     nSampledObs: Num. observations to sample when discretizing
%                  observation model.
%     gamma: Discount factor.
%     maxAlphaC: Maximum number of components in the Alpha mixtures.
%
%   This type of POMDP is used in the last experiment of the paper 
%   (Figure 11).

  switch nargin
    case 1
      if isa(varargin{1},'CS_CO_CA_POMDP')
        P=varargin{1};
      else
        error('Wrong parameter type in CS_CO_CA_POMDP');
      end
      
    case 11
      
      if isa(varargin{2},'CSpace')
        P.S=varargin{2};
      else
        error('Wrong parameter type in CS_CO_CA_POMDP');
      end

      if isa(varargin{3},'CSpace')
        P.A=varargin{3};
      else
        error('Wrong parameter type in CS_CO_CA_POMDP');
      end

      if isa(varargin{4},'CSpace')
        P.O=varargin{4};
      else
        error('Wrong parameter type in CS_CO_CA_POMDP');
      end

      if isa(varargin{5},'CS_CA_ActionModel')
        AM=varargin{5};
      else
        error('Wrong parameter type in CS_CO_CA_POMDP');
      end

      if isa(varargin{6},'CS_CO_ObsModel')
        OM=varargin{6};
      else
        error('Wrong parameter type in CS_CO_CA_POMDP');
      end
      
      if isa(varargin{7},'CS_CA_RewardModel')
        RM=varargin{7};
      else
        error('Wrong parameter type in CS_CO_CA_POMDP');
      end
      
      P.nSampledActions=max(1,varargin{8});
      
      PBase=CS_CO_POMDP(varargin{1},varargin{9},varargin{10},varargin{11});
      
      P=class(P,'CS_CO_CA_POMDP',PBase,AM,OM,RM);
      
    otherwise
      error('Wrong number of parameters in CS_CO_CA_POMDP');
  end
