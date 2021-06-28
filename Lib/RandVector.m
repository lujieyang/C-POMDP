function i=RandVector(v)
%   Selects and element from a discrete probability distribution.
%
%   Returns an element at random using the (absolute) values of the input 
%   vector as selection weights.

  va=abs(v);

  r=rand*sum(va);
  i=1;
  s=va(i);
  while s<r
    i=i+1;
    s=s+va(i);
  end
