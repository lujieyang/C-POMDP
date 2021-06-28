function OM=CS_CO_ObsModel(varargin)
%   CS_CO_ObsModel constructor.
%
%   Defines an observation model (p(o|s)) on continuous state and 
%   observation spaces.
%   This kind of observation models are defined via kernel smoothing (see
%   Section 6.2, pag 22 of the paper)
%
%   The CS_CO_ObsModel defines p(o,s) via Kernel smoothing: using a double
%   Gaussian on 's' and on 'o'. From here:
%       p(o|s)=p(o,s)/p(s)
%   Where we assume p(s) as uniform.
%   For simplicity the 1/p(s) scale factor is integrated into the kernel
%   weight.
%
%   Parameters
%      S: Continuous state space.
%      O: Continuous observation space.
%      w: weights of the double mixture.
%      gS: Gaussians in 's'.
%      gO: Gaussians in 'o'.

  switch nargin
    case 1
      if isa(varargin{1},'CS_CO_ObsModel')
        OM=varargin{1};
      else
        error('Wrong parameter type in CS_CO_ObsModel constructor');
      end
    case 5
      if isa(varargin{1},'CSpace')
        OM.S=varargin{1};
      else
        error('Wrong parameter type in CS_CO_ObsModel constructor');
      end
      if isa(varargin{2},'CSpace')
        OM.O=varargin{2};
      else
        error('Wrong parameter type in CS_CO_ObsModel constructor');
      end
      if isa(varargin{3},'double')
        OM.w=varargin{3}*(1/UniformProbability(OM.S));
      end
      if isa(varargin{4},'cell')
        OM.gS=varargin{4};
      end
      if isa(varargin{5},'cell')
        OM.gO=varargin{5};
      end
      
      % Scale factor to apply = What it should be (UniformProbability(OM.S))
      % vs. what actually is (Value(o,Center(OM.S)))
      % We estimate p(s) via sampling (small variations can occur)
      gS=GMixture(OM.w,OM.gS); % p(s)=int_o p(o,s) 
      ps=0;
      % draw 10 sample on 's' to estimate p(s). 
      for i=1:10
        ps=ps+Value(gS,rand(OM.S));
      end
      ps=ps/10;
      scale=UniformProbability(OM.S)/ps;
      OM.w=OM.w*scale;
      
      OMBase=ObsModel();
      
      OM=class(OM,'CS_CO_ObsModel',OMBase);
    otherwise
      error('Wrong number of parameters in CS_CO_ObsdModel constructor');
  end
  