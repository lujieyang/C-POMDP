function As=ComputeAlphas_j_a_o(P,V)
%   Computes the set of al possible alpha-elements.
%
%   Compute the whole se of alpha_j_a_o elements.
%
%   This function only works for POMDP with discrete action and observation
%   spaces.
%
%   The function is a generic implementation that uses the particular 
%   ComputeAlpha_j_a_o function of the corresponding type of POMDP.
%
%   Parameters
%     P: The POMDP.
%     V: The previous policy/value function/set of alpha-elements.
%
%   See also @DS_ComputeAlpha_j_a_o, @CS_ComputeAlpha_j_a_o.


  A=get(P,'ActionSpace');
  O=get(P,'ObsSpace');
  if isa(A,'DSpace') && isa(O,'DSpace')
    na=dim(A);
    no=dim(O);
    nj=size(V);
    ro=1:no;
    As=cell(nj,na,no);
    for j=1:nj
      for a=1:na
        As(j,a,:)=arrayfun(@(o)(ComputeAlpha_j_a_o(P,V,j,a,o)),ro,'UniformOutput',false);
      end
    end
  else
    As={};
  end
