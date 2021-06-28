function p=GetActionModelFixedA(AM,a)
%   Returns the action model for a given action.
%
%   Returns the action model when the action is is fixed to 'a'.
%   The output is a table p(stateTo,stateFrom).
%
%   Note the difference with respect to action models on continuous state
%   spaces. Here the output is a probability on the state space and not a
%   distribution on the displacement produced by 'a'.
%
%   See also DS_DA_ActionModel.

  p=AM.T{a};
  
  