function AM=ActionModel(varargin)
%   Action Model constructor.
%
%   Defines the basic Action Model object, i.e., the object that includes
%   the common part of the different types of action models: with
%   discrete/continuous states/actions.
%   Currently this basic Action Model is empty and it is only used to
%   identify action model objects, idependently of their sub.type: 
%   i.e., to use queries such as 'isa(A,'ActionModel')', 
%   Moreover, it is also used to provide implementation of functions
%   independent of the spacific action model used.
%
%   See also BeliefPredicition.

  switch nargin
    
    case 0
      AM.dummy=1;
      AM=class(AM,'ActionModel');
      
    case 1
      if isa(varargin{1},'ActionModel')
        AM=varargin{1};
      else
        error('Wrong parameter type in ActionModel constructor');
      end
   
    otherwise
      error('Wrong number of parameters in ActionModel constructor');
  end
