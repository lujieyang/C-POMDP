function MakeFigure6
%   Generates Figure 6.
%
%   Displays the Figure 6 in the paper.
%   
%   Shows the accumulated discounted reward averaged for several trials 
%   using the final plan obtained when representing beliefs and alpha
%   mixtures with different number of components.
%
%   If results for the plots are not pre-computed they are generted on the
%   fly and this can be veeery time consuming.

  fprintf('Loading/Generating the simulation results with normal parameters');
  fprintf('   (4-components beliefs and 9-components alpha-mixtures)\n');
  GenData=@()(TestRepWithStatistics('Test1','Figure2',1:10));
  ResultsNormal=GetData('Results/Test1-Figure2-results.mat',GenData);
  
  fprintf('Loading/Generating the simulation results 1-component beliefs\n');
  [POMDP P]=GetTest1Parameters(1,9);
  GenData=@()(TestRepWithStatistics(POMDP,P,'Figure6-a',1:10));
  ResultsB1=GetData('Results/Test1-Figure6-a-results.mat',GenData);
  
  fprintf('Loading/Generating the simulation results 3-components alpha mixtures\n');
  [POMDP P]=GetTest1Parameters(4,3);
  GenData=@()(TestRepWithStatistics(POMDP,P,'Figure6-b',1:10));
  ResultsA3=GetData('Results/Test1-Figure6-b-results.mat',GenData);
  
  h=clf;
  set(h,'name','C-POMDP Figure 6','numbertitle','off');

  plot(ResultsB1.tics,ResultsB1.SM.R,'linestyle',':');
  hold on;
  plot(ResultsA3.tics,ResultsA3.SM.R,'linestyle','--');
  plot(ResultsNormal.tics,ResultsNormal.SM.R);
  
  legend('1-component beliefs','3-component \alpha-functions','9-c. \alpha-func. + 4-c. beliefs');
  
  xlabel('time (s)');
  ylabel('Acc. Disc. Reward');