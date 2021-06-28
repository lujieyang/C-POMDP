function v=rand(gm,varargin)
%   Generates random points on a GMixture.
%
%   Return random vectors following the distribution represented by the
%   mixture. Observe that this works for unnormalized mixtures too. The
%   components are selected proportionally to the absolute value of their
%   corresponding weigth.
%   This function accepts two parameters
%     - The Gaussian mixture.
%     - The number of samples to drawn. If not given only one sample is
%       generated.

  if gm.n==0
    v=0;
  else
    if nargin>1
      n=varargin{1};
    else
      n=1;
    end
    
    dim=get(gm.g{1},'dim');
    v=zeros(dim,n);
    for i=1:n
      v(:,i)=rand(gm.g{RandVector(gm.w)},1);
    end
  end
  