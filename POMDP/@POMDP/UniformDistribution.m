function u=UniformDistribution(POMDP)
%   Uniform distribution in the POMDP state space.
%
%   Generates a uniform distribution in the state space where the POMDP is
%   defined. 
%   It basically uses the adequate UniformDistribution function of the
%   state space stored in the POMDP.

  u=UniformDistribution(get(POMDP,'StateSpace'));