function P=DS_DO_POMDP(varargin)
%   DS_DO_POMDP constructor.
%
%   Generic object for POMDP with
%     - Discrete state spaces.
%     - Discrete observation spaces.
% 
%   The action space can be discrete or continuous.
%   This object is defined to provide methods that work for both types of
%   action spaces.
%
%   Parameters
%     name: POMDP name.
%     gamma: Discount factor.
%
%   See also DS_DO_DA_POMDP, DS_DO_CA_POMDP.

% Parameters
%   See DS_POMDP

  if (nargin==1) && isa(varargin{1},'DS_DO_POMDP')
    P=varargin{1};
  else
    DS_POMDP_Base=DS_POMDP(varargin{1:end});
    P=class(struct([]),'DS_DO_POMDP',DS_POMDP_Base);
  end
  