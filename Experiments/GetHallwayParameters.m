function [POMDP P]=GetHallwayParameters
%   The hallway discrete POMDP.
%
%   Exemple of how to define the POMDP and the parameters for a discrete
%   POMDP (the ususal type of POMDP in the literature).
%   
%   The POMDP is read from a file and the parameters are directly set here.
%   The outputs of this function can be latter used to solve the problem
%   using:
%
%      [POMDP P B V Val Alpha t]=TestOne(POMP,P);
%
%   However, TestOne can be directly called as
%
%      [POMDP P B V Val Alpha t]=TestOne('Hallway');
%
%   In this case TestOne directly calls GetHallwayParameters to get the
%   POMDP and the P objects.
%
%   All problems (and their parameters) should be encoded in a file like
%   this one.
%
%   See also ReadDiscretePOMDPData, TestOne, POMDP, GetTest1Parameters.

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % Define the POMDP
    POMDP=DS_DO_DA_POMDP('Data/hallway');
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % Define the parameters for sampling beliefs
    P.start=DBelief(UniformDistribution(POMDP));
    P.nBeliefs=1000;
    P.dBelief=0.1;
    P.stepsXtrial=50;
    P.rMin=-inf;
    P.rMax=inf;
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % Define the parameters for assesing the solution quality
    P.maxTime=25;
    P.stTime=2;
    P.numTrials=100;
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % Define the parameters for solving
    P.stopCriteria=@(n,t,vc)(t>P.maxTime);