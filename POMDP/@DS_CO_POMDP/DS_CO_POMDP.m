function P=DS_CO_POMDP(varargin)
%   DS_CO_POMDP constructor.
%
%   Generic object for POMDP with
%     - Discrete state spaces.
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
%
%   See also DS_CO_DA_POMDP, DS_CO_CA_POMDP.


  if (nargin==1) && isa(varargin{1},'DS_CO_POMDP')
    P=varargin{1};
  else
    DS_POMDP_Base=CS_POMDP(varargin{1},varargin{3:end});
    P.nSampledObs=varargin{2};
    P=class(P,'DS_CO_POMDP',DS_POMDP_Base);
  end
  