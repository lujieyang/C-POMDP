function pb=PBelief(varargin)
%   Particle-based belief constructor.
%
%   Generates a belief on a continuous state space using a particles.
%
%   Parameters:
%      w: Weights for the particles
%      samples: Value for the particle in the state space.
%

  switch nargin
    case 1
      if isa(varargin{1},'PBelief')
        pb=varargin{1};
      else
        error('Wrong parameter type in PBelief constructor');
      end
    case 2
      if isa(varargin{1},'double') && isa(varargin{2},'double')
        pb.w=varargin{1};
        [s1 pb.np]=size(pb.w);
        if s1>1
          error('Weights are row arrays');
        end
        pb.w=pb.w/sum(pb.w);
        
        pb.samples=varargin{2};
        [pb.ss t2]=size(pb.samples);
        if t2~=pb.np
          error('Mismatch sizes in PBelief creation');
        end

        pb.noiselessMovedSamples=pb.samples;
        pb.noise=zeros(pb.ss);
        
        b=Belief();
        pb=class(pb,'PBelief',b);
      else
        
      end
    otherwise
      error('Wrong number of parameters in PBelief constructor');
  end
  