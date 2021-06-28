function out=get(g,field)
%   Gaussian object get function.
%
%   Returns the information associated with a Gaussian
%   Possible queries are
%      - dim: The dimensionality of the space where the Gaussian is defined
%      - mean:  The mean vector.
%      - covariance: The covariance matrix.
%      - invCovariance: The inverse of the covariance matrix.
%      - volume: The volume of the ellipsoid defined from the covariance matrix.
%      - normalizationFactor: The normalization factor for a Gaussian (the constant
%        that multiplies the exponential defining the Gaussian
%        distribution).
%      - ellipse: Returns a line representing the iso-countour of the
%        ellipse defined from the mean and covariance at a 95% confidence
%        value. For higher-dimensional Gaussians, we marginalize and only
%        use the first 2 components of the Gaussians.

  switch field
    case 'dim'
      out=g.dim;
		case 'mean'
			out=g.m;
		case 'covariance'
			out=g.S;
		case 'information'
			out=g.iS;
		case 'volume'
			out=g.d;
		case 'normalizationFactor'
			out=g.ct;
		case 'ellipse'
			S2d=g.S(1:2,1:2);
      % For 2 dim, a Xi squared distribution gives that the
      % 90% confidence level is obtained at 2.1459
      R=chol(S2d);
      y = 2.1459*[cos(0:0.1:2*pi);sin(0:0.1:2*pi)];
      el=R*y;
      out = [el el(:,1)]+repmat(g.m(1:2),1,size(el,2)+1);
      
    otherwise
      error('Unknow field in Gaussian get');
	end