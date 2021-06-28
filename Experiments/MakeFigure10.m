function MakeFigure10
%  Generates Figure 10.
%
%   Generates the data for Figure 10 in the paper.
%   In this figure we show the performance of planning in the example in
%   Figure 1 when using a continuous action set.
%
%   See also MakeFigure2, GetData, TestRep, GetPOMDPAverageStatistics, 
%            TestRepWithStatistics, MakeFigureSimulation.

   fprintf('Loading/Generating the simulation results\n'); 
   GenData=@()(TestRepWithStatistics('Test1ca','Figure10',1:10));
   Results=GetData('Results/Test1ca-Figure10-results.mat',GenData);
 
   MakeFigureSimulation('C-POMDP Figure 10',Results);