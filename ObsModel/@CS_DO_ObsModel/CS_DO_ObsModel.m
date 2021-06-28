function OM=CS_DO_ObsModel(varargin)
%   CS_DO_ObsModel constructor.
%
%   Defines an observation model (p(o|s))  on continuous state and discrete 
%   observation spaces.
%
%   Parameters
%    S: Continuous state space.
%    O: Discrete observation space.
%    p: A cell array with one GMixture (in 's') for each observation.

  switch nargin
    case 1
      if isa(varargin{1},'CS_DO_ObsModel')
        OM=varargin{1};
      else
        error('Wrong parameter type in CS_DO_ObsModel constructor');
      end
    case 3
      if isa(varargin{1},'CSpace')
        OM.S=varargin{1};
      else
        error('Wrong parameter type in CS_DO_ObsModel constructor');
      end
      if isa(varargin{2},'DSpace')
        OM.O=varargin{2};
      else
        error('Wrong parameter type in CS_DO_ObsModel constructor');
      end
      if isa(varargin{3},'cell')
        OM.p=varargin{3};
      else
        error('Wrong parameter type in CS_DO_ObsModel constructor');
      end
         
      no=dim(OM.O);
      if no~=size(OM.p,2) 
        error('Size missmatch in DS_CO_ObsModel constructor');
      end
      
      % p(s) should be uniform in 's'. We compute p(s) as
      %      p(s) = sum_o p(o,s)
      % and, assuming it is constant, we scale p(o,s) so that p(s) is
      % actually uniform.
      o=OM.p{1};
      for i=2:no
        o=o+OM.p{i};
      end
      % Scale factor to apply = What it should be (UniformProbability(OM.S))
      % vs. what actually is (Value(o,Center(OM.S)))
      % We estimate p(s) via sampling (small variations can occur)
      ps=0;
      for i=1:10
        ps=ps+Value(o,rand(OM.S));
      end
      ps=ps/10;
      scale=UniformProbability(OM.S)/ps;
      for i=1:no
        OM.p{i}=OM.p{i}*scale;
      end
      
      OMBase=ObsModel();
      
      OM=class(OM,'CS_DO_ObsModel',OMBase);
      
    otherwise
      error('Wrong number of parameters in CS_DO_ObsModel constructor');
  end
  
  