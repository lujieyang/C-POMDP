function POut=DiscretizeObsModel(P)
%   Discretizes a POMDP on the observation side.
%
%   Generic stub that basically triggers and error if the observation space
%   for the input POMDP ('P') is continuous.
%   In other works, this function only discretize already discretized
%   observation sets.

  if isa(get(P,'ObsSpace'),'CSpace')
    error('This in to be applied only to POMDPs with discrete observation spaces');
  else
    POut=P;
  end
  