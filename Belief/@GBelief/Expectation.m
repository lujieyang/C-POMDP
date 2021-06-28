function e=Expectation(b,a)
%   Expectation between a belief and a alpha-element.
% 
%   Expectation operator for a Gaussian-based belief 'b' on continuous 
%   state space and a given alpha element 'a' (a Gaussian mixture in this case).
%
%   This is the basic operator on which the backup relies on and,
%   consequently on which the whole planeer is based on.

  e=ProductInt(b.GMixture,a);
  