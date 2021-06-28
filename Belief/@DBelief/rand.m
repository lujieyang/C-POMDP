function v=rand(b)
%   Random state from a discrete belief.
%
%   Generates a random state from a belief distribution on discrete state
%   space.

  v=RandVector(b.v);
  