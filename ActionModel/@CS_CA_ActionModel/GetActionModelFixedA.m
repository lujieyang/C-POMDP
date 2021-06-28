function p=GetActionModelFixedA(AM,a)
%   Returns the action model for a given action.
%
%   Returns the action model when the action is is fixed to 'a'.
%   The output is a Gaussian with mean B*a and the covariance given in the
%   CS_CA_ActionModel constructor.
%
%   See also CS_CA_ActionModel.

  p=Gaussian(AM.B*a,AM.Noise);
  