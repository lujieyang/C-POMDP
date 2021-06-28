function P=DS_DO_DA_POMDP(varargin)
%   DS_DO_DA_POMDP constructor.
%
%   Constructor of POMDP with
%     - Discrete state spaces.
%     - Discrete observation spaces.
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
%     gamma: Discount factor.
%
%   This corresponds to the classical POMDP used in most of the papers so
%   far. This type of POMDP are implemented and solved using the Perseus
%   algoritm (Spaan and Vlassis JAIR 2005).

  switch nargin
    case 1
      if isa(varargin{1},'DS_DO_DA_POMDP')
        P=varargin{1};
      else
        if isa(varargin{1},'char')
          % Reading from a file in ASCII format
          POMDPData=ReadDiscretePOMDPData([varargin{1} '.POMDP']);
          
          S=DSpace(POMDPData.nStates);
          O=DSpace(POMDPData.nObs);
          A=DSpace(POMDPData.nActions);
          
          AM=DS_DA_ActionModel(S,A,POMDPData.T);
          OM=DS_DO_ObsModel(S,O,POMDPData.O);
          RM=DS_DA_RewardModel(S,A,POMDPData.R);
          
          P=DS_DO_DA_POMDP(varargin{1},S,A,O,AM,OM,RM,POMDPData.gamma);
        else
          error('Wrong parameter type in DS_DO_DA_POMDP');
        end
      end
      
    case 2
      % Reading from a file in MAT format
      if isa(varargin{1},'char') && isa(varargin{2},'char') && strcmp(varargin{2},'-MAT')
        POMDPData=load(varargin{1},'-MAT');
        
        P=DS_DO_DA_POMDP(POMDPData.S,POMDPData.A,POMDPData.O,...
          POMDPData.AM,POMDPData.OM,POMDPData.RM,POMDPData.start,POMDPData.gamma);
      end
      
    case 8
      
      if isa(varargin{2},'DSpace')
        P.S=varargin{2};
      else
        error('Wrong parameter type in DS_DO_DA_POMDP');
      end

      if isa(varargin{3},'DSpace')
        P.A=varargin{3};
      else
        error('Wrong parameter type in DS_DO_DA_POMDP');
      end

      if isa(varargin{4},'DSpace')
        P.O=varargin{4};
      else
        error('Wrong parameter type in DS_DO_DA_POMDP');
      end

      if isa(varargin{5},'DS_DA_ActionModel')
        AM=varargin{5};
      else
        error('Wrong parameter type in DS_DO_DA_POMDP');
      end

      if isa(varargin{6},'DS_DO_ObsModel')
        OM=varargin{6};
      else
        error('Wrong parameter type in DS_DO_DA_POMDP');
      end
      
      if isa(varargin{7},'DS_DA_RewardModel')
        RM=varargin{7};
      else
        error('Wrong parameter type in DS_DO_DA_POMDP');
      end
    
      PBase=DS_DO_POMDP(varargin{1},varargin{8});
      
      P=class(P,'DS_DO_DA_POMDP',PBase,AM,OM,RM);
      
    otherwise
      error('Wrong number of parameters in DS_DO_DA_POMDP');
  end
