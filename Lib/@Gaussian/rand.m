function r=rand(g,varargin) 
%   Generates random ponts on a Gaussian.
%
%   Generates a random point following the given Gaussian distribution, g.
%
% Returns
%   R: A column-wise set of randomly generated vectors.

  if nargin>1
    n=varargin{1};
  else
    n=1;
  end
  
	if g.d==0
		r=repmat(g.m,1,n);
  else  
		L=chol(g.S);
		A_temp=normrnd(0,1,g.dim,n);
		A=L*A_temp;
    r=repmat(g.m,1,n)+A;
	end
