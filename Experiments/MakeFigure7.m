function MakeFigure7
%  Generates Figure 7.
%
%   Figure 7-left shows the execution time for the first iteration of
%   Perseus in a discretized version of the problem in Figure 1 with an
%   increasing number of states.
%
%   Figure 7-right show the average accumulated discounted reward when
%   solving the discrete version of the problem in Figure 1 with 20 and 200
%   states, comparing it with the average accumulated discounted reward
%   obtained when solving the continuous version of the problem.
%
%   NOTE: There is a large difference between the results you will obtain
%         in this experiment and those in the paper.
%         As mentioned in page 29, the discrete version of Perseus can be
%         sped up vectorizing its operations and exploiting the sparsity of
%         the matrices defining the models. In the old version we did not
%         use those enhancements but we do in the current implementation.

  fprintf('Loading/Generating the simulation results\n');
  fname='Results/Test1-Figure7-a.mat';
  GenData=@()(GenerateFigure7aData(fname));
  Results=GetData(fname,GenData);

  h=clf;
  set(h,'name','C-POMDP Figure 7','numbertitle','off');
  
  subplot(1,2,1);
  bar(Results.ns,Results.tp);

  xlabel('No. States');
  ylabel('time (s)');
  
  fprintf('Loading/Generating the simulation results with normal parameters\n');
  GenData=@()(TestRepWithStatistics('Test1','Figure2',1:10));
  ResultsNormal=GetData('Results/Test1-Figure2-results.mat',GenData);
  
  [POMDP P]=GetTest1Parameters;
  
  fprintf('Loading/Generating the simulation results with 20 states\n');
  DPOMDP=Discretize(POMDP,20);
  P.start=DBelief(UniformDistribution(get(DPOMDP,'StateSpace')));
  GenData=@()(TestRepWithStatistics(DPOMDP,P,'Figure7-b1',1:10));
  ResultsD20=GetData('Results/Test1-discrete-20-Figure7-b1-results.mat',GenData);
  
  fprintf('Loading/Generating the simulation results with 200 states\n');
  DPOMDP=Discretize(POMDP,200);
  P.start=DBelief(UniformDistribution(get(DPOMDP,'StateSpace')));
  GenData=@()(TestRepWithStatistics(DPOMDP,P,'Figure7-b2',1:10));
  ResultsD200=GetData('Results/Test1-discrete-200-Figure7-b2-results.mat',GenData);
  
  
  subplot(1,2,2);
  plot(ResultsD20.tics,ResultsD20.SM.R,'linestyle',':');
  hold on;
  plot(ResultsD200.tics,ResultsD200.SM.R,'linestyle','--');
  plot(ResultsNormal.tics,ResultsNormal.SM.R);
  
  legend('Discrete PERSEUS (20 states)','Discrete PERSEUS (200 states)','Continuous-State PERSEUS');
  
  xlabel('time (s)');
  ylabel('Acc. Disc. Reward');
