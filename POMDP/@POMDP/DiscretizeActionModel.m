function POut=DiscretizeActionModel(P,a,n)
%   Discretizes a POMDP on the action side.
%
%   Generic stub that basically triggers and error if the action space for
%   the input POMDP ('P') is continuous.
%   In other works, this function only discretize already discretized
%   action sets.
%   This function is provided so that line 14a of Table 2, page 21 of the 
%   paper can be executed for any type of POMDP.

  if isa(get(P,'ActionSpace'),'CSpace')
    error('This in to be applied only to POMDPs with discrete action spaces');
  end
  
  POut=P;
  