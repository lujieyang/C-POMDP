function Element_a=ComputeAlpha_a(P,V,b,a,Alphas_j_a_o)
%   Compute the alpha_i_n-element for the given action and belief.
%
%   Define the alpha-elements to be used in the backup (The \alpha_n^i
%   elements).
%   
%   The defintion of this function is given in abstract way (without regard
%   of the type of the underlying state space using an abstract expectation
%   operator) in Section 3.1 equation (8).

  rj=num2cell(1:size(V));
  O=get(P,'ObsSpace');  
  gamma=get(P,'gamma');
  no=dim(O);
  Element_a=GetRewardModelFixedA(P,a);
  for o=1:no
    if isempty(Alphas_j_a_o)
      Elements_j=cellfun(@(j)(ComputeAlpha_j_a_o(P,V,j,a,o)),rj,'UniformOutput',false);
    else
      Elements_j=Alphas_j_a_o(:,a,o);
    end
    [v_a_o nAlpha_j]=max(cellfun(@(g)(Expectation(b,g)),Elements_j));
    Element_a=Element_a+gamma*Elements_j{nAlpha_j};
  end
  
  
  
