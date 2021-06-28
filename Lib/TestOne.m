function [POMDP P B V Val Alpha t]=TestOne(varargin)
%   Samples beliefs and executes Perseus on a given problem.   
%
%   Executes one iteration of Perseus as described a Table 1 of page 12 of
%   the paper. It first samples a set of belief by randomly simulating the
%   POMDP.
%   Possible parameters
%     - POMDP,P: The POMDP to solve and the set of parameters to use
%     - 'name': A function called 'Get'+name+'Parametres' is used to obtain
%       both the POMDP and the set of parameters, P.
%   Outputs:
%     - POMDP: The POMDP.
%     - P: The set of parameters.
%     - B: The set of beliefs.
%     - V: The set of Policies (one per iteration) out of Perseus.
%     - Val: Set of values for each iteration/belief.
%     - Alpha: Alpha element maximizing the value for each belief in each
%              iteration.
%     - t: Time at which each iteration was compleated.
%
%  Example of use
%     [POMDP P B V Val Alpha t]=TestOne('Test1');

  switch nargin
    case 1
      if isa(varargin{1},'char')
        [POMDP P]=eval(['Get' varargin{1} 'Parameters']);
      else
        error('Wrong type of parameters in TestOne');
      end
      
    case 2
      POMDP=varargin{1};
      P=varargin{2};
      
    otherwise
      error('Wrong number of parameters in TestOne');
  end
  
  % Simulate and get some beliefs
  fprintf('Sampling Beliefs\n');
  B=SampleBeliefs(POMDP,P.start,P.nBeliefs,P.dBelief,P.stepsXtrial,P.rMin,P.rMax);
      
  % Solve
  fprintf('Solving\n');
  [V Val Alpha t]=iPerseus(POMDP,B,P.stopCriteria);
 