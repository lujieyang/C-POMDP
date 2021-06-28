function h=plot(gm,varargin)
%   Plots a Gaussian mixture.
%
%   This function only works for  Gaussian mixtures defined on 
%   one-dimensional spaces.
%   The function accepts all the parameters applicable to Matlab lines
%   (linestyle, color, etc).

  if gm.n>0
    if get(gm.g{1},'dim')==1
      l=zeros(1,gm.n);
      u=zeros(1,gm.n);
      for i=1:gm.n
        c=sqrt(get(gm.g{i},'covariance'));
        m=get(gm.g{i},'mean');
        l(i)=m-3*c;
        u(i)=m+3*c;
      end
      mi=min(l);
      ma=max(u);
      
      n=1000;
      X=mi:(ma-mi)/(n-1):ma;
      Y=Value(gm,X);
      h=line(X,Y);
			if nargin>1
				set(h,varargin{1:end});
			end
    else
      error('Plot of multi-dimensional GMixtures is not implemented yet');
    end
  end