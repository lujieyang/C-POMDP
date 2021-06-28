function value=get(P,field)
%  Get function for CS_DO_DA_POMDPs.
%
%  Get function for POMDP on continuous state spaces but on discrete action
%  and observation spaces.
%  Possible fields to query are
%    - StateSpace
%    - ActionSpace
%    - ObsSpace
%    - ActionModel
%    - ObsModel
%    - RewardModel
%    - Any filed defined in higher levels of the POMDP object hierarchy
%
%  See also @CS_POMDP/get, @POMDP/get
  switch field
    case 'StateSpace'
      value=P.S;
    case 'ActionSpace'
      value=P.A;
    case 'ObsSpace'
      value=P.O;
    case 'ActionModel'
      value=P.CS_DA_ActionModel;
    case 'ObsModel'
      value=P.CS_DO_ObsModel;
    case 'RewardModel'
      value=P.CS_DA_RewardModel;
    otherwise
      value=get(P.CS_DO_POMDP,field);
  end