function db=DBelief(varargin)
%   Discrete belief constructor.
%
%   Generates a belief on a discrete state space.
%   The belief is basically a column vector with the probabilities for each
%   state.

  switch nargin  
    case 1
      if isa(varargin{1},'DBelief')
        db=varargin{1};
      else
        if isa(varargin{1},'double')
          db.v=varargin{1};
          [s1 s2]=size(db.v);
          if s2>1
            error('Vectors are column arrays');
          end
          db.v=db.v/sum(db.v);
          
          b=Belief();
          db=class(db,'DBelief',b);
        else
          error('Wrong parameter type in DBelief constructor');
        end
      end
    otherwise
      error('Wrong number of parameters in DBelief constructor');
  end