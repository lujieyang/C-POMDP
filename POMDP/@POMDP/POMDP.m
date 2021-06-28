function P=POMDP(varargin)
%   POMDP constructor.
%
%   Base object for all POMDP objects.
%
%   Parameters
%     name: name for the POMDP.
%     gamma: discount factor.
%
%   See also DS_POMDP, CS_POMDP.

  switch nargin
    
    case 1
      if isa(varargin{1},'POMDP')
        P=varargin{1};
      else
        error('Wrong parameter type in POMDP constructor');
      end
      
    case 2
      if isa(varargin{1},'char')
        P.name =varargin{1};
      else
        error('Wrong parameter type in POMDP constructor');
      end
      
      if isa(varargin{2},'double')
        P.gamma =varargin{2};
      else
        error('Wrong parameter type in POMDP constructor');
      end

      P=class(P,'POMDP');
      
    otherwise
      error('Wrong number of parameters in POMDP constructor');
  end