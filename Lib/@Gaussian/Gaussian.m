function g=Gaussian(varargin)
%   Gaussian construtor.
%
%   Multi-dimensional Gaussian constructor. The input parameters can be 
%   another Gaussian, from a collection of points of from the mean and 
%   covariance matrix.

  switch nargin
		case 1
      if isa(varargin{1},'Gaussian')
        g=varargin{1};
      else
        if isa(varargin{1},'double')
          % assuming we have to define the Gaussian from samples (arranged
          % in columns)
          n=size(varargin{1},2); % number of data
          m=mean(varargin{1},2);
          Pz=(varargin{1}-repmat(m,1,n)); % zero centered points
          C=(Pz*Pz')/(n-1); % unbiased covariance
          g=Gaussian(m,C);
        else
          error('Gaussian copy constructor from not a Guassian and not a raw data');
        end
      end
      
		case 2
			g.m=varargin{1};
			g.dim=size(g.m,1);
			g.S=varargin{2};
      
      if (g.dim~=size(g.S,1)) || (g.dim~=size(g.S,2))
        error('Non-coherent size of mean an covariance in Gaussian creation');
      end

      m=max(max(g.S));
      if m==0
        g.d=0;
        g.iS=inf*eye(g.dim);
        g.ct=0;
      else
        if g.dim==1
          g.d=g.S;
          g.iS=1/g.S;
          g.ct=1/sqrt(2*pi*g.d);
        else
          R=chol(g.S);
          g.d=prod(diag(R))^2;
          iR=R\eye(g.dim);
          g.iS=iR*iR';
          %The normalization factor (in multiplicative form)
          g.ct=1/sqrt(((2*pi)^g.dim)*g.d);
        end
      end
      g=class(g,'Gaussian');
    otherwise
			error('Wrong number of parameters in Gaussian constructor');
	end
	