function P=CS_CO_POMDP(varargin)
%   CS_CO_POMDP constructor.
%
%   Generic object for POMDP with
%     - Continuous state spaces.
%     - Continuous observation spaces.
% 
%   The action space can be discrete or continuous.
%   This object is defined to provide methods that work for both types of
%   action spaces.
%
%   Parameters
%     name: POMDP name.
%     nSampledObs: Num. observations to sample when discretizing
%                  observation model.
%     gamma: Discount factor.
%     maxAlphaC: Maximum number of components in the Alpha mixtures.
%
%   See also CS_CO_DA_POMDP, CS_CO_CA_POMDP.

  if (nargin==1) && isa(varargin{1},'CS_CO_POMDP')
    P=varargin{1};
  else
    CS_POMDP_Base=CS_POMDP(varargin{1},varargin{3:end});
    P.nSampledObs=varargin{2};
    P=class(P,'CS_CO_POMDP',CS_POMDP_Base);
  end
  