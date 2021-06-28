function v=ComponentsValue(gm,x)
%  Evaluates a Gaussian mixture component-wise.
%
%  Returns a vector with the weighted value for each component in the
%  mixture evaluated at 'x'.
%  
%  See also Value.

  v=gm.w.*cellfun(@(g)Value(g,x),gm.g);
  