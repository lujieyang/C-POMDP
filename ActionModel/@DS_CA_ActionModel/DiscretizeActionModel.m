function DS_DA_AM=DiscretizeActionModel(DS_CA_AM,ActionSet)
%   Generates a new action model discretizing the action space of the given model.
%
%   Produces an action model defined on a discrete action space from an
%   action model defined on continuous action spaces.
%   In both the input and output action models, the state space is
%   discrete.
%   Parameters:
%     DS_CA_AM: The discrete state continuous action action model to be 
%               discretized.
%     ActionSet: The discrete set of actions to use in the discretization.
%
%   See also DS_DA_ActionModel.

  na=size(ActionSet,2);
  T=zeros(DS_CA_AM.ns,DS_CA_AM.ns,na);
  for i=1:DS_CA_AM.ns
    for j=1:DS_CA_AM.ns
      T(i,j,:)=cellfun(@(a)(Value(DS_CA_AM.T{i}{j},a)),ActionSet);
    end
  end
  DS_DA_AM=DS_DA_ActionModel(T);
  