function P=CS_DO_POMDP(varargin)
%   CS_DO_POMDP constructor.
%
%   Generic object for POMDP with
%     - Continuous state spaces.
%     - Discrete observation spaces.
% 
%   The action space can be discrete or continuous.
%   This object is defined to provide methods that work for both types of
%   action spaces.
%
%   Parameters
%     name: POMDP name.
%     gamma: Discount factor.
%     maxAlphaC: Maximum number of components in the Alpha mixtures.
%
%   See also CS_DO_DA_POMDP, CS_DO_CA_POMDP.

  if (nargin==1) && isa(varargin{1},'CS_DO_POMDP')
    P=varargin{1};
  else
    CS_POMDP_Base=CS_POMDP(varargin{1:end});
    P=class(struct([]),'CS_DO_POMDP',CS_POMDP_Base);
  end
  