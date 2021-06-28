function v=Value(gm,x)
%   Evaluates a GMixture.
%
%   Evaluates the Gaussian mixture 'gm' on a given point, 'x'.
  v=0;
  for i=1:gm.n
    v=v+gm.w(i)*Value(gm.g{i},x);
  end
  