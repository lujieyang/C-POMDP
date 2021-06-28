function CS=CSpace(varargin)
%   CSpace constructor.
%
%   Defines a continuous space.
%   Actually we define an axis aligned box in a continuous space.
%   
%   Parameters:
%     min: column vector with lower bound for each one of the dimension of
%          the state space.
%     max: column vector with upper bound for each one of the dimension of
%          the state space.

  switch nargin
    case 1
      if isa(varargin{1},'CSpace')
        CS=varargin{1};
      else
        error('Wrong type of parameters in CSpace constructor');
      end
    case 2
      if isa(varargin{1},'double')
        CS.min=varargin{1};
      else
        error('Wrong type of parameters in CSpace constructor');
      end
      if isa(varargin{2},'double')
        CS.max=varargin{2};
      else
        error('Wrong type of parameters in CSpace constructor');
      end
      CS.dim=size(CS.min,1);
      CS.range=CS.max-CS.min;
      if sum(CS.range>0)~=CS.dim
        error('Wrong bounds in CSpace constructor');
      end
      if CS.dim~=size(CS.max,1) || size(CS.min,2)~=1 || size(CS.max,2)~=1
        error('Size missmatch in CSpace constructor');
      end
      CS=class(CS,'CSpace');
    otherwise
      error('Wrong number of parameters in CSpace constructor');
  end