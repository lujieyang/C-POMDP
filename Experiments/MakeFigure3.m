function MakeFigure3(varargin)
%   Generates Figure 3.
%
%   Simulates a POMDP on one of the results obtained in the experiment in
%   Figure 1. If the results are not pre-computed we compute them on the
%   fly (this can be quite time consuming).
%   
%
%   The simulation shows the evolution of the belief and the
%   executed actions and the obtained reward are printed in the Matlab
%   console. 
%   At the end we also print the accumulated discounted reward for the
%   trial.
%   This data can be used to generate a sequence of snapshots as
%   those in the figure.
%
%   This is an example of how to use the resulting policy out of a planning
%   experiment.
%
%   Parameters
%     n: Number of steps of the simulation. If not given 15.
%
  % 'n' == simulation steps 
  
  if nargin==0
    n=15;
  else
    n=varargin{1};
  end

  fprintf('Loading/Generating the simulation results\n');

  GenData=@()(TestRep('Test1','Figure2',1));
  Results=GetData('Results/Test1-Figure2-1.mat',GenData);
  
  % Get the parameters used to generate the results
  P=Results.P;
  
  % Get the POMDP
  POMDP=Results.POMDP;
  
  % Get the las policy of the simulation
  Policy=Results.V{end};
  
  % Get the initial belief from the parmeters
  b=P.start;
  
  % The hidden state is selecte at random
  s=rand(b);
  
  fprintf('SIMULATING\n');
  fprintf('INITIAL STATE %f\n',s);
   
  h=clf;
  set(h,'name','C-POMDP Figure 3','numbertitle','off');
  
  h=plot(b); 
  xlabel('s');
  ylabel('p(s)')
  axis([-20 20 0 1]);
  hold on;
  rAll=0;
  gamma=get(POMDP,'gamma');
  g=1;
  for i=1:n
    fprintf('\nSTEP %u: ',i);
    a=OptimalAction(Policy,b);
    fprintf('  action: %u (',a);
    switch a
      case 1
        fprintf('Move-Left');
      case 2
        fprintf('Move-Right');
      case 3
        fprintf('Enter-Door');
    end
    [s b o r]=SimulationStep(POMDP,b,s,a);
    rAll=rAll+g*r;
    g=g*gamma;
    fprintf(')  state:%f  reward: %f   ',s,r);
    delete(h);
    h=plot(b);
    fprintf('<press a key>');
    pause;
  end
  hold off
  fprintf('\n\nDiscounted reward: %f\n',rAll);
  
  
  