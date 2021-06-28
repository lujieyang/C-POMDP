function value=get(P,field)
%  Get function for CS_CO_CA_POMDPs.
%
%  Get function for POMDP on continuous state, continuous discrete 
%  action and continuous observation spaces.
%  Possible fields to query are
%    - StateSpace
%    - ActionSpace
%    - ObsSpace
%    - ActionModel
%    - ObsModel
%    - RewardModel
%    - nSampledActions
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
      value=P.CS_CA_ActionModel;
    case 'ObsModel'
      value=P.CS_CO_ObsModel;
    case 'RewardModel'
      value=P.CS_CA_RewardModel;
    case 'nSampledActions'
      value=P.nSampledActions;
    otherwise
      value=get(P.CS_CO_POMDP,field);
  end