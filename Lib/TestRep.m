function TestRep(varargin)
%   Executes many times of Perseus on a given problem. 
%
%   Executes a sequence of experiments on a given problem and stores the
%   results in a file. 
%   The aim of this is to obtain statistically significant data to generate
%   the plots in the paper.
%
%   Parameters can be
%      - POMDP, P, range: The POMDP, the set of parameters, and the range
%        for the repetitions.
%      - name, range: The name is used to obtain the POMDP and the
%        parameters P calling a function with name 'Get'+name+'Parameters'
%
%   The execution of each repetition is extremely computationally
%   demanding. The range is typically used to execute different repetitions
%   in different computers, in parallel. 
%
%   Finally note that, before executing anything, we check whether the file
%   to generat is already available. If so nothing is executed.
%
%   Examples of use:
%     Get the experiment parameters     
%        [POMDP P]=GetHallwayParameters;
%        [POMDP P]=GetTest1Parameters;
%     and execute   
%        TestRep(POMDP,P,infix,1:10);
%
%     or directly use
%        TestRep('Hallway',infix,1:10);
%        TestRep('Test1',infix,1:10);
%
%   After each experiment statistics are obtained using GetPOMDPSolutionStatistics
%   At the end of the execution, a file with the results and the statistics is 
%   generated.
%   This file is named as
%         Results/POMDPname-infix-n.mat
%
%   where - POMDPname is the output of get(POMDP,'name').
%         - infix is the parameter given when calling this function.
%         - n is the repetition number (in the given range).
%
%   See also SampleBeliefs, iPerseus, GetPOMDPSolutionStatistics.

  switch nargin
    case 3
      if isa(varargin{1},'char')
%         [POMDP P]=eval(['Get' varargin{1} 'Parameters']);
        [POMDP P] = GetTest1Parameters_sharp;
      else
        error('Wrong type of parameters in TestOne');
      end
      infix=varargin{2};
      rep=varargin{3};
      
    case 4
      POMDP=varargin{1};
      P=varargin{2};
      infix=varargin{3};
      rep=varargin{4};
      
    otherwise
      error('Wrong number of parameters in TestRep');
  end
  
  % Tag for the output files
  prefix=sprintf('Results/%s-%s',get(POMDP,'name'),infix);
  
  for i=rep
    name=sprintf('%s-%u.mat',prefix,i);
    
    f=fopen(name);
    if f<0
      fprintf('Repetition %u\n',i);

      % Sample a set of beliefs
      fprintf('  Sampling Beliefs\n');
      B=SampleBeliefs(POMDP,P.start,P.nBeliefs,P.dBelief,P.stepsXtrial,P.rMin,P.rMax);

      % Solve the problem
      fprintf('  Solving\n');
      [V Val Alpha time]=iPerseus(POMDP,B,P.stopCriteria);

      % Collect statistics on the resulting set of plans
      [tics aV aR nA nC]=GetPOMDPSolutionStatistics(POMDP,P,B,V,Alpha,time,P.maxTime,P.stTime);
    
      % Save results for this repetition
      save(name,'POMDP','P','B','V','Val','Alpha','time','tics','aV','aR','nA','nC');
    else
      fprintf('Repetition %u is already generated\n',i);
      fclose(f);
    end
    
  end
