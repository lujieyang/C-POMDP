function P=DS_DO_CA_POMDP(varargin)
%   DS_CO_DA_POMDP constructor.
%
%   Constructor of POMDP with
%     - Discrete state spaces.
%     - Discrete observation spaces.
%     - Continuous action spaces.
%   
%   Parameters
%     name: POMDP name.
%     S: Continuous state space.
%     A: Discrete action space.
%     O: Continuous observation space.
%     AM: Action model.
%     OM: Observation model.
%     RM: Reward model.
%     nSampledActions: No. actions to sample when discretizing the action
%                      set.
%     gamma: Discount factor.
%
%   This type of POMDP is not used in the current implementation and, thus
%   it is not even implemented (an error will be triggered if you try to
%   define an object of this type).
%
%   This correspond to one of the types of POMDP in the work by Sappan 
%   and Vlasis (JAIR-2005).

  switch nargin
    case 1
      if isa(varargin{1},'DS_DO_CA_POMDP')
        P=varargin{1};
      else
        error('Wrong parameter type in DS_DO_CA_POMDP');
      end
      
    case 9
      
      if isa(varargin{2},'DSpace')
        P.S=varargin{2};
      else
        error('Wrong parameter type in DS_DO_CA_POMDP');
      end

      if isa(varargin{3},'CSpace')
        P.A=varargin{3};
      else
        error('Wrong parameter type in DS_DO_CA_POMDP');
      end

      if isa(varargin{4},'DSpace')
        P.O=varargin{4};
      else
        error('Wrong parameter type in DS_DO_CA_POMDP');
      end

      if isa(varargin{5},'DS_CA_ActionModel')
        AM=varargin{5};
      else
        error('Wrong parameter type in DS_DO_CA_POMDP');
      end

      if isa(varargin{6},'DS_DO_ObsModel')
        OM=varargin{6};
      else
        error('Wrong parameter type in DS_DO_CA_POMDP');
      end
      
      if isa(varargin{7},'DS_CA_RewardModel')
        RM=varargin{7};
      else
        error('Wrong parameter type in DS_DO_CA_POMDP');
      end
      
      P.nSampledActions=max(1,varargin{8});
      
      PBase=DS_DO_POMDP(varargin{1},varargin{9});
      
      P=class(P,'DS_DO_CA_POMDP',PBase,AM,OM,RM);
      
    otherwise
      error('Wrong number of parameters in DS_DO_CA_POMDP');
  end
