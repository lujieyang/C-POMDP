function Element_a=ComputeAlpha_a(P,V,b,a,Alphas_j_a_o)
%   Compute the alpha_i_n-element for the given action and belief.
%
%   Define the alpha-elements to be used in the backup (The \alpha_n^i
%   elements).
%
%   Actually, this function implements the last equation of section 5.2 in
%   the paper.
%
%   Note that in this case the Alpha_j_a_o elements can be pre-computed.
%   If they are, the Alphas_j_a_o parameter is a non-emtpy cell array with
%   one entry for each alpha-element (of the previous policy), each action 
%   and each observation. 
%   If this set is empty, the corresponding alpha elements are computed on
%   the fly inside this function.

  rj=num2cell(1:size(V));
  O=get(P,'ObsSpace');
  no=dim(O);
  gamma=get(P,'gamma');
  noP=isempty(Alphas_j_a_o);
  Element_ao=GMixture;
  for o=1:no
    if noP
      Alphas_j=cellfun(@(j)(ComputeAlpha_j_a_o(P,V,j,a,o)),rj,'UniformOutput',false);
    else
      Alphas_j=Alphas_j_a_o(:,a,o);
    end
    [v_a_o nAlpha_j]=max(cellfun(@(g)(Expectation(b,g)),Alphas_j));
    Element_ao=Element_ao+Alphas_j{nAlpha_j};
  end
  Element_a=GetRewardModelFixedA(P,a)+gamma*Element_ao;
  
  
 