function value=get(gm,field,varargin)
%   Get function for the GMixture object.
%
%   Get for the GMixture object
%   Possible fields
%     'n' Number of components in the mixture.
%     'w' The vector of weigths of the components in the mixture.
%     'minW' Minimum weights for all components in the mixture.
%     'components' Array of Gaussians, one for each component.
%     'component' Returns the Gaussian for a particular component.

  switch field
    case 'n'
      value=gm.n;
    case 'w'
      value=gm.w;
    case 'minW'
      value=min(gm.w);
    case 'components'
      value=gm.g;
    case 'component'
      value=gm.g{varargin{1}};
    otherwise
      error('Unknown field in GMixture get');
  end