function P=DS_CO_DA_POMDP(varargin)
%   DS_CO_DA_POMDP constructor.
%
%   Constructor of POMDP with
%     - Discrete state spaces.
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
%
%   This type of POMDP is not used in the current implementation and, thus
%   it is not even implemented (an error will be triggered if you try to
%   define an object of this type).
%
%   This correspond to the type of POMDP in the work by Hoey and Poupar
%   (IJCAI-2005).

  switch nargin
    case 1
      if isa(varargin{1},'DS_CO_DA_POMDP')
        P=varargin{1};
      else
        error('Wrong parameter type in DS_CO_DA_POMDP');
      end
      
    case 9
      
      if isa(varargin{2},'CSpace')
        P.S=varargin{2};
      else
        error('Wrong parameter type in DS_CO_DA_POMDP');
      end

      if isa(varargin{3},'DSpace')
        P.A=varargin{3};
      else
        error('Wrong parameter type in DS_CO_DA_POMDP');
      end

      if isa(varargin{4},'CSpace')
        P.O=varargin{4};
      else
        error('Wrong parameter type in DS_CO_DA_POMDP');
      end

      if isa(varargin{5},'DS_DA_ActionModel')
        AM=varargin{5};
      else
        error('Wrong parameter type in DS_CO_DA_POMDP');
      end

      if isa(varargin{6},'DS_CO_ObsModel')
        OM=varargin{6};
      else
        error('Wrong parameter type in DS_CO_DA_POMDP');
      end
      
      if isa(varargin{7},'DS_DA_RewardModel')
        RM=varargin{7};
      else
        error('Wrong parameter type in DS_CO_DA_POMDP');
      end
      
      PBase=DS_CO_POMDP(varargin{1},varargin{8},varargin{9});
      
      P=class(P,'DS_CO_DA_POMDP',PBase,AM,OM,RM);
      
    otherwise
      error('Wrong number of parameters in CS_CO_DA_POMDP');
  end
