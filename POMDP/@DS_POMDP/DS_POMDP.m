function P=DS_POMDP(varargin)
%   DS_POMDP constructor.
%
%   Base object for all POMDP with discrete state spaces.
%
%   Parameters
%     name: name for the POMDP.
%     gamma: discount factor.
%
%   See also DS_DO_POMDP, DS_CO_POMDP.


  if (nargin==1) && isa(varargin{1},'DS_POMDP')
    P=varargin{1};
  else
    POMDP_Base=POMDP(varargin{1:end});
    P=class(struct([]),'DS_POMDP',POMDP_Base);
  end
  