function DS=DSpace(varargin)
%   DSpace constructor.
%
%   Defines a discrete space (a space where only a discrete number of
%   values are possible).
%
%   Parameters:
%     dim: Dimensinality of the space. Number of elements in the discrete
%          set of values.
%     values: [optional] A discrete set (cell array) of values. If not
%             given values are assumed the cardinals (1 to dim).
%

  switch nargin
    case 1
      if isa(varargin{1},'DSpace')
        DS=varargin{1};
      else
        if isa(varargin{1},'double')
          DS.max=varargin{1};
          % Default values
          DS.values=cell(1,DS.max);
          for i=1:DS.max
            DS.values{i}=i;
          end
          DS=class(DS,'DSpace');
        else
          if isa(varargin{1},'cell')
            DS.max=size(varargin{1},2);
            DS.values=varargin{1};
            DS=class(DS,'DSpace');
          else
            error('Wrong type of parameters in DSpace constructor');
          end
        end
      end
    case 2
      if isa(varargin{1},'double') && isa(varargin{2},'cell')
        DS.max=varargin{1};
        DS.values=varargin{2};
        if size(DS.values,2)~=DS.max
          error('Size missmatch in DSpace constructor');
        end
        DS=class(DS,'DSpace');
      else
        error('Wrong type of parameters in DSpace constructor');
      end
    otherwise
      error('Wrong number of parameters in DSpace constructor');
  end
  