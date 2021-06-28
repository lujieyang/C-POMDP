function gm=mrdivide(gm1,ct)
  if isa(gm1,'GMixture') && isa(ct,'double')
    gm=gm1*(1/ct);
  else
    error('Wrong parameter type in GMixture mrdivide');
  end