function v=Value(g,x)
%   Evaluation of a Gaussian.
%
%   Returns the evaluation of a Gaussian on a given set of points, 'x'. 

  l=size(x,2);
  Sn=-0.5*g.iS;

  v=zeros(1,l);
  for i=1:l
    m=x(:,i)-g.m;
    v(i)=g.ct*exp(m'*Sn*m);
  end
  
