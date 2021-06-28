function alpha_j_a_o=ComputeAlpha_j_a_o(P,V,j,a,o)
%   Computes a particular alpha-element.   
%
%   Computes a single alpha_j_a_o element as described in Section 5.2 
%   pages 15 and 16 of the paper.
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

  p_o_s1=GetObsModelFixedO(P,o);
  if get(p_o_s1,'n')==0
    alpha_j_a_o=GMixture();
  else
    p_s1_a_s=GetActionModelFixedA(P,a); %Gaussian on the varS given a
    alpha_j_a_o=Compress(Compose(V{j}*p_o_s1,-p_s1_a_s),P.maxAlphaC);
  end
