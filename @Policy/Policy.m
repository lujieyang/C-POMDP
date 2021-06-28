function P=Policy(varargin)
%   Policy constructor.
%
%   Defines an empty Policy object.
%   A Policy is a set of elements  that can be vectors or Gaussian mixtures 
%   depending on the nature of the state space (discrete vs. continuous).
%   Each element in a policy has an associated action.
%   The element (and thus, the action) to be assigned to each belief is the
%   one that maximizes the value for that belief. Recall that the value is
%   computed using the expectation operator between the element and the
%   belief. See the different belief implementations for details on this
%   operator.

  switch nargin
    case 0
      P.elements={};
      P.actions={};
      P.n=0;
      P=class(P,'Policy');
    case 1
      if isa(varargin{1},'Policy')
        P=varargin{1};
      else
        error('Wrong parameter type in Policy copy constructor.');
      end
    otherwise
      error('Wrong number of parameters in Policy creation.');
  end