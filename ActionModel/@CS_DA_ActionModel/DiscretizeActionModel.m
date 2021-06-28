function DAM=DiscretizeActionModel(AM,DS)
%   Produces a new action model discretizing the state space.
%
%   Produces an action model defined on a discrete state space from an
%   action model defined on continuous state spaces.
%   In both the input and output action models, the action space is
%   discrete.
%   Parameters:
%     AM: The continuous state, discrete action action model to be discretized.
%     DS: The discrete space with the samples to be used as discrete states 
%         in the discretization.
%
%   See also DS_DA_ActionModel.

  ns=dim(DS);
  
  na=dim(AM.A);
  T=cell(1,na);
  for i=1:na
    m=get(AM.gA{i},'mean');
    S=get(AM.gA{i},'covariance');
    T{i}=zeros(ns,ns);
    for j=1:ns
      % Gaussian on next state form current state 'j' when
      % action 'i' is executed.
      g=Gaussian(Crop(AM.S,DS(j)+m),S);
      for k=1:ns
        T{i}(k,j)=Value(g,DS(k));
      end      
      T{i}(:,j)=T{i}(:,j)/sum(T{i}(:,j));
    end
  end
  
  DAM=DS_DA_ActionModel(DS,AM.A,T);
  
