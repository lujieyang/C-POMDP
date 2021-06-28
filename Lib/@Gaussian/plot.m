function h=plot(g,varargin)
%  Plots a Gaussian.
%
%  Plots a Gaussian. For one-dimensinal Gaussians produces a
%  one-dimensional plot. For higher dimensional Gaussians an ellipse
%  representing the marginal of the Gaussian on the two first dimensions is
%  shown.
%  The fuction accepts an optional parameter with the color for the plot.
%
%  Returns:
%    h: The handler of the line/ellipse representing the Gaussian.

  if g.d==0
		h=0;
	else
		if g.dim==1
			  r=3*sqrt(g.S); % represent the Gaussian from -3*sigma to 3*sigma
				n=100; %points of the curbe representing the gaussain
      
				X=(-r:(2*r)/(n-1):r)+g.m;
				Y=Value(g,X);
  
				plot(X,Y);
		else
			h=line([g.m(1) g.m(1)],[g.m(2) g.m(2)]);
			set(h, 'marker','*');
			if nargin>1
				set(h, 'Color',varargin{1});
			end
			el=get(g,'ellipse');
			h = line(el(1,:),el(2,:));

			if nargin>1
				set(h, 'Color',varargin{1});
			end
		end
	end
