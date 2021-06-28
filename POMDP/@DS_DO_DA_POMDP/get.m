function value=get(P,field)
%  Get function for DS_DO_DA_POMDPs.
%
%  Get function for POMDP on discrete state, action, and observation
%  spaces.
%  Possible fields to query are
%    - StateSpace
%    - ActionSpace
%    - ObsSpace
%    - ActionModel
%    - ObsModel
%    - RewardModel
%    - Any filed defined in higher levels of the POMDP object hierarchy
%
%  See also @DS_POMDP/get, @POMDP/get

  switch field
    case 'StateSpace'
      value=P.S;
    case 'ActionSpace'
      value=P.A;
    case 'ObsSpace'
      value=P.O;
    case 'ActionModel'
      value=P.DS_DA_ActionModel;
    case 'ObsModel'
      value=P.DS_DO_ObsModel;
    case 'RewardModel'
      value=P.DS_DA_RewardModel;
    otherwise
      value=get(P.DS_DO_POMDP,field);
  end