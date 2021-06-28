function P=CS_POMDP(varargin)
%   CS_POMDP constructor.
%
%   Base object for all POMDP with continuous state spaces.
%
%   Parameters
%     name: name for the POMDP.
%     gamma: discount factor.
%     maxAlphaC: Maximum number of components in the Alpha mixtures.
%
%   See also CS_DO_POMDP, CS_CO_POMDP.

  switch nargin
    case 1
      if isa(varargin{1},'CS_POMDP')
        P=varargin{1};
      else
        error('Wrong type of parameters in CS_POMDP constructor');
      end
      
    case 3 
      if isa(varargin{3},'double')
        P.maxAlphaC=varargin{3};
      else
        error('Wrong type of parameters in CS_POMDP constructor');
      end
      POMDP_Base=POMDP(varargin{1:2});
      P=class(P,'CS_POMDP',POMDP_Base);
      
    otherwise
      error('Wrong number of parameters in CS_POMDP constructor');
  end
 