function value=get(P,field)
%  Get function for CS_CO_DA_POMDPs.
%
%  Get function for POMDP on continuous state, discrete action
%  and continuous observation spaces.
%  Possible fields to query are
%    - StateSpace
%    - ActionSpace
%    - ObsSpace
%    - ActionModel
%    - ObsModel
%    - RewardModel
%    - nSampledObs
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
      value=P.CS_CO_ObsModel;
    case 'RewardModel'
      value=P.CS_DA_RewardModel;
    otherwise
      value=get(P.CS_CO_POMDP,field);
  end