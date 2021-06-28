function [alpha a v]=Backup(P,b,V,Alphas_j_a_o)
%   Backupt for a given belief (discrete state version).
%
%   Belief backup function for POMDP defined on discrete state spaces.
%   The backup operator is introduced in Section 4 (page 12) but without any
%   assumption on the type of state space.
%
%   This function basically computes one Alpha-vector for each action and
%   selects the one that gives higher value for the given belief.
%
%   Parameters:
%     P: The POMDP
%     b: The belief
%     V: The previous policy/value function/set of alpha-elements.
%     Alphas_j_a_o: The set of pre-compute alpha_j_a_o elements. If empty,
%                   the alpha_j_a_o elements are computed on the fly.

  A=get(P,'ActionSpace'); % This is suposed to be discrete
  if isa(A,'CSpace')
    error('The Action Space must be discrete at this point');
  end
  Elements_a=arrayfun(@(a)(ComputeAlpha_a(P,V,b,a,Alphas_j_a_o)),1:dim(A),'UniformOutput',false);
  [v a]=max(cellfun(@(ea)(Expectation(b,ea)),Elements_a));
  alpha=Elements_a{a};
 