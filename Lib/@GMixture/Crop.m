function gmOut=Crop(gm,Sp)
%   Limits all means to be inside the given space.
%
%   Crops all the elements in the mixture so that their mean is inside the
%   given continous space, 'Sp'.
%   
%   See also @Gaussian/Crop

  c=cell(1,gm.n);
  for i=1:gm.n
    c{i}=Crop(gm.g{i},Sp);
  end
  gmOut=GMixture(gm.w,c);