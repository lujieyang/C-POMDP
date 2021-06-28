function gmOut=Compose(gm,g)
%  Composes a Gaussian mixture with a Gaussian.
%
%  Convolutes all the components of a Gaussian mixture with a given
%  gaussian, 'g'.
%  In other words, adds the given Gaussian 'g' to the Gaussians defining
%  the mixture.
%
%  See also @Gaussian/plus.

   gmOut=gm;
   gmOut.g=cellfun(@(g2)(g+g2),gm.g,'UniformOutput',false);