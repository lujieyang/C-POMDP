function MakeFigure2
%   Generates Figure 2.
%
%   Generates the data for Figure 2 in the paper.
%   This functions uses GetData to check if the results are already
%   pre-computed and stored in the Results directory.
%   If they are not, we execute 10 repetitions of Perseus and collect the
%   average statistics. This can be extremely time demanding (about one day
%   of non-stop computing on an average computer).
%   I compute the experiments in parallel in a cluster of computers
%   executing:
%     Computer1> TestRep('Test1','myresults',1);
%     Computer2> TestRep('Test1','myresults',2);
%     ...
%     Computer10> TestRep('Test1','myresults',10);
%
%   and at the end
%
%     Computer1> [tics SM SD]=GetPOMDPAverageStatistics('Test1-myresults')
%
%   The results I obtained are downlodable from the same place where you
%   get this solftware. Using those pre-compute results, you will get he
%   plot in Figure 2 in few seconds.
%
%   See also GetData, TestRep, GetPOMDPAverageStatistics, 
%            TestRepWithStatistics, MakeFigureSimulation.

  fprintf('Loading/Generating the simulation results\n'); 
  GenData=@()(TestRepWithStatistics('Test1','Figure2',1:10));
  Results=GetData('Results_6/Test1-Figure2-results.mat',GenData);

  MakeFigureSimulation('C-POMDP Figure 2',Results);