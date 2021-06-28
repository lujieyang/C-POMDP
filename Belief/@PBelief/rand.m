function v=rand(b)
%   Random state from a belief.
%  
%   Generates a random state from a particle based belief.

  v=b.samples(RandVector(b.w));
  