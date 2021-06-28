function alpha_j_a_o=ComputeAlpha_j_a_o(P,V,j,a,o)
%   Computes a particular alpha-element.   
% 
%   Computes a single alpha_j_a_o element as described in Section 3.1
%   equation (6), but particularized for discrete state spaces.
%   
%   This function can be used when pre-computing the set of all alpha_j_a_o
%   elements before the backup operation or when computing only one of 
%   them during the backup.
%
%   Parameters
%     P: The POMDP
%     V: The previous policy/value function/set of alpha-elements.
%     j: Index of the previous alpha element to use.
%     a: Index of the action to use.
%     o: Index of the observation to use.

  S=get(P,'StateSpace');
  ns=dim(S);
  p_s1_a_s=GetActionModelFixedA(P,a);
  p_o_s1=GetObsModelFixedO(P,o);
  alpha_j_a_o=full(sum(repmat(V{j}.*p_o_s1,1,ns).*p_s1_a_s,1)');
  
 
