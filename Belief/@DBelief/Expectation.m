function e=Expectation(b,a)
%   Expectation between a belief and a alpha-element.
%
%   Expectation operator for a belief 'b' on discrete state space and a given
%   alpha element 'a' (alpha vector in this case).
%
%   This is the basic operator on which the backup relies on and,
%   consequently on which the whole planeer is based on.

  e=b.v'*a;
  