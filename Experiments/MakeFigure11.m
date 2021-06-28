function MakeFigure11
%  Generates Figure 11.
%
%   Generates the data for Figure 11 in the paper.
%   In this figure we show the performance of planning in the example in
%   Figure 1 when using a continuous action and observation sets.
%
%   This simulation takes longer that those in the paper because in this
%   implementation focus is on clarity and not on efficiency.
%
%   See also MakeFigure2, MakeFigure 11, GetData, TestRep, 
%            GetPOMDPAverageStatistics, 
%            TestRepWithStatistics, MakeFigureSimulation.

   fprintf('Loading/Generating the simulation results\n'); 
   GenData=@()(TestRepWithStatistics('Test1co','Figure11',1:10));
   Results=GetData('Results/Test1co-Figure11-results.mat',GenData);
 
   MakeFigureSimulation('C-POMDP Figure 11',Results);