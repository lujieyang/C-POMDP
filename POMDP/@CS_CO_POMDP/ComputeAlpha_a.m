function Element_a=ComputeAlpha_a(P,V,b,a,Alphas_j_a_o)
%   Compute the alpha_i_n-element for the given action and belief.
%
%   Define the alpha-elements to be used in the backup (The \alpha_n^i
%   elements).
%   Particularly, this function defines those elements as described at the
%   end of section 6.2 of the paper (see the last equation before 
%   Section 7).
%
%   This function is only applied to POMDPs with discrete actions sets.
%   Recall that continuous action sets are always discretized before
%   entering the backup (See Table 2 in page 21). Thus, in practice the
%   input 'P' is a DS_CO_DA_POMDP.
%
%   Note that in this case the Alpha_j_a_o elements can not be pre-computed
%   and that this parameter is given for compatibility with similar
%   functions for other types of POMDP.

  P1=DiscretizeObsModel(P,V,b,a); % This returns a CS_DO_DA_POMDP
  nj=size(V);
  gamma=get(P,'gamma');
  Element_a=ComputeAlpha_j_a_o(P1,V,1,a,1);
  for j=2:nj
    Element_a=Element_a+ComputeAlpha_j_a_o(P1,V,j,a,j);
  end  
  Element_a=GetRewardModelFixedA(P,a)+gamma*Element_a;


