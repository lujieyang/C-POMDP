function b=Belief(varargin)
%   Belief constructor.
%
%   Defines the basic belief. 
%   Currently it include no information but is used for queries such as
%   isa(b,'Belief') and to implement functions generic to all kind of
%   beliefs.

  switch nargin
    case 0
      b.dummy=1;
      b=class(b,'Belief');
      
    case 1
      if isa(varargin{1},'Belief')
        b=varargin{1};
      else
        error('Belief copy constructor with wrong parameter');
      end
  end
  