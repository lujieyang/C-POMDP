function CS_DA_AM=DiscretizeActionModel(CS_CA_AM,A)
%   Generates a new action model discretizing the action space. 
%
%   Produces an action model defined on a discrete action space from an
%   action model defined on continuous action spaces.
%   In both the input and output action models, the state space is
%   continuous.
%   Parameters:
%     CS_CA_AM: The continous state/action action model to be discretized.
%     A: The discrete set of actions to use in the discretization.
%
%   See also CS_DA_ActionModel.

  na=dim(A);
  varS=cell(1,na);
  for i=1:na
    varS{i}=CS_CA_AM.B*A(i);
  end
  CS_DA_AM=CS_DA_ActionModel(CS_CA_AM.S,A,varS,{CS_CA_AM.Noise});
  