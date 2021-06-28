function gb=GBelief(varargin)
%   Gaussian-based belief constructor.
% 
%   Generates a belief on a continuous state space using a gaussian
%   mixture.
%   Parameters:
%      GM: The Gaussian mixture.
%      maxC: The maximum number of components in the mixtures representing
%            beliefs. Beliefs with larger mixtures are compressed to fit in
%            this threshold.
%
%   Note that GBelief inherits from Belief but also from GMixture. Thus,
%   all GMixture functions are directly appliable to GBeliefs.
 
  switch nargin
    
    case 1
      if isa(varargin{1},'GBelief')
        gb=varargin{1};
      else
        if isa(varargin{1},'GMixture')
          gb=GBelief(varargin{1},0);
        else
          error('Wrong parameter type in GBelief constructor');
        end
      end
      
    case 2
      if isa(varargin{1},'GMixture') && isa(varargin{2},'double')
        
        gb.maxC=floor(varargin{2});
        gm=Normalize(Compress(varargin{1},gb.maxC));
        
        b=Belief();
        
        gb=class(gb,'GBelief',b,gm);
      else
        error('Wrong parameter type in GBelief constructor');
      end
      
    otherwise
      error('Wrong number of parameters in GBelief constructor');
  end
  