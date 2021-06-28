function P=CS_CO_DA_POMDP(varargin)
%   CS_CO_DA_POMDP constructor.
%
%   Constructor of POMDP with
%     - Continuous state spaces.
%     - Continuous observation spaces.
%     - Discrete action spaces.
%   
%   Parameters
%     name: POMDP name.
%     S: Continuous state space.
%     A: Discrete action space.
%     O: Continuous observation space.
%     AM: Action model.
%     OM: Observation model.
%     RM: Reward model.
%     nSampledObs: Num. observations to sample when discretizing
%                  observation model.
%     gamma: Discount factor.
%     maxAlphaC: Maximum number of components in the Alpha mixtures.
%
%   This type of POMDP is not used in the example of Figure 11. In this
%   example we haver continuous states, observations, and actions. When
%   discretizing the actions before  the backup we get a POMPD of this
%   type.


  switch nargin
    case 1
      if isa(varargin{1},'CS_CO_DA_POMDP')
        P=varargin{1};
      else
        error('Wrong parameter type in CS_CO_DA_POMDP');
      end
      
    case 10
      
      if isa(varargin{2},'CSpace')
        P.S=varargin{2};
      else
        error('Wrong parameter type in CS_CO_DA_POMDP');
      end

      if isa(varargin{3},'DSpace')
        P.A=varargin{3};
      else
        error('Wrong parameter type in CS_CO_DA_POMDP');
      end

      if isa(varargin{4},'CSpace')
        P.O=varargin{4};
      else
        error('Wrong parameter type in CS_CO_DA_POMDP');
      end

      if isa(varargin{5},'CS_DA_ActionModel')
        AM=varargin{5};
      else
        error('Wrong parameter type in CS_CO_DA_POMDP');
      end

      if isa(varargin{6},'CS_CO_ObsModel')
        OM=varargin{6};
      else
        error('Wrong parameter type in CS_CO_DA_POMDP');
      end
      
      if isa(varargin{7},'CS_DA_RewardModel')
        RM=varargin{7};
      else
        error('Wrong parameter type in CS_CO_DA_POMDP');
      end
      
      PBase=CS_CO_POMDP(varargin{1},varargin{8},varargin{9},varargin{10});
      
      P=class(P,'CS_CO_DA_POMDP',PBase,AM,OM,RM);
      
    otherwise
      error('Wrong number of parameters in CS_CO_DA_POMDP');
  end
