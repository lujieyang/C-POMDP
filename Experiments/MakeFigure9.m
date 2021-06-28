function MakeFigure9
%   Generates Figure 9.
%
%   This figure compare the average accumulate discounted reward obtained
%   for the problem in Figure 1 when using actions sets with different size
%   in the displacement (1, 2, and 4).
%
%   This is an experiment to properly frame that in figure 10, when using
%   continous action sets (i.e., when Perseus has to select the adequate
%   displacement size in each case).
%

  h=clf;
  set(h,'name','C-POMDP Figure 9','numbertitle','off');

  fprintf('Loading/Generating the simulation results with normal parameters\n');
  GenData=@()(TestRepWithStatistics('Test1','Figure2',1:10));
  ResultsNormal=GetData('Results/Test1-Figure2-results.mat',GenData);
  
  [POMDP P]=GetTest1Parameters(4,9,1);
  GenData=@()(TestRepWithStatistics(POMDP,P,'Figure9-a',1:10));
  ResultsA1=GetData('Results/Test1-Figure9-a-results.mat',GenData);
  
  [POMDP P]=GetTest1Parameters(4,9,4);
  GenData=@()(TestRepWithStatistics(POMDP,P,'Figure9-b',1:10));
  ResultsA4=GetData('Results/Test1-Figure9-b-results.mat',GenData);

  
  plot(ResultsA1.tics,ResultsA1.SM.R,'linestyle',':');
  hold on;
  plot(ResultsNormal.tics,ResultsNormal.SM.R);
  plot(ResultsA4.tics,ResultsA4.SM.R,'linestyle','--');

  
  legend('Action Set \pm 1','Action Set \pm 2','Action Set \pm 4');
  
  xlabel('time (s)');
  ylabel('Acc. Disc. Reward');