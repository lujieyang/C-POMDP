function gm=GMixture(varargin)
%   Gaussian mixture constructor.
%
%   Defines a (non-necessarily normalized) Gaussian mixture given the
%   weights and the Gaussian  for each component.
%   Possible parameters
%     - None: Defines an empty Gaussian mixture.
%     - Another Gaussian mixture: Copy constructor.
%     - w,g: The (row) vector of weigths and a cell array of Gaussians.
%     - g: The cell array of Gaussians. In this case the weights are
%          assumed uniform.

  switch nargin
    case 0
      gm.w=[];
      gm.g={};
      gm.n=0;
      gm=class(gm,'GMixture');
    case 1
      if isa(varargin{1},'GMixture')
        gm=varargin{1};
      else
        if isa(varargin{1},'cell')
          n=size(varargin{1},2);
          gm=GMixture(ones(1,n)/n,varargin{1});
        else
          error('Wrong type of parameters in GMixture constructor');
        end
      end
    case 2
      n1=size(varargin{1},2);
      n2=size(varargin{2},2);
      if n1~=n2
        error('Size missmatch in GMixture constructor');
      end
      if isa(varargin{1},'double')
        gm.w=varargin{1};
      else
        error('Wrong type of parameters in GMixture constructor');
      end
      if isa(varargin{2},'cell')
        gm.g=varargin{2};
      else
        error('Wrong type of parameters in GMixture constructor');
      end
      gm.n=n1;
      gm=class(gm,'GMixture');
    otherwise
      error('Wrong number of parameters in GMixture constructor');
  end