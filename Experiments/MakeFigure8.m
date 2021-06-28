function MakeFigure8
%  Generates Figure 8.
%
%   Generates the data for Figure 8 in the paper.
%   In this figure we show the performance of planning in the example in
%   Figure 1 when using particles to represent the beliefs.
%
%   See also MakeFigure2, GetData, TestRep, GetPOMDPAverageStatistics, 
%            TestRepWithStatistics, MakeFigureSimulation.

   fprintf('Loading/Generating the simulation results\n'); 
   GenData=@()(TestRepWithStatistics('Test1p','Figure8',1:10));
   Results=GetData('Results/Test1p-Figure8-results.mat',GenData);
 
   MakeFigureSimulation('C-POMDP Figure 8',Results);