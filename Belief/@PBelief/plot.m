function h=plot(pb,varargin)
%   Displays a particle-based belief.
%
%   Plots a particle set.
%   Currently this function only works for particles defined on one-dimensional
%   state spaces. When applied to other spaces it triggers an error.

  if size(pb.samples,1)>1
    error('Plot of multidimensional samples is not implemented');
  else
    n=size(pb.samples,2);
    X=zeros(1,3*n);
    Y=zeros(1,3*n);
    
    r=3*(1:n);    
    X(r)=pb.samples;
    %Y(r)=0;
    
    r=r-1;
    X(r)=pb.samples;
    Y(r)=pb.w;
    
    r=r-1;
    X(r)=pb.samples;
    %Y(r)=0:
    
    h=line(X,Y);
    
    if nargin>1
      set(h,varargin{1:end});
    end
  end