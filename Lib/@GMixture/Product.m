function gmOut=Product(gm1,gm2)
% gmOut=Product(gm1,gm2)
%   Returns the Gaussian mixutre resulting from multiplying the two input
%   mixtures.
  
  n=gm1.n*gm2.n;
  w=zeros(1,n);
  g=cell(1,n);
  k=1;
  
  for i=1:gm1.n
    for j=1:gm2.n
      [g{k} d]=Product(gm1.g{i},gm2.g{j});
      w(k)=gm1.w(i)*gm2.w(j)*d;
      k=k+1;
    end
  end
  gmOut=GMixture(w,g);
