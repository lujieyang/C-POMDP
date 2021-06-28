function p=GetActionModelFixedA(AM,a)
%   Returns the action model for a given action.
%
%   Returns the action model when the action is is fixed to 'a'.
%   The output is a Gaussian with the mean and covariance given in the
%   CS_DA_ActionModel constructor.
%
%   See also CS_DA_ActionModel.

  % Gaussian in the displacement
  p=AM.gA{a};
 