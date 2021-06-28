function [POMDP P]=GetTest1Parameters(varargin)
%   The example on Figure 1.
%
%   Example of how to define the POMDP and the parameters for a problem
%   with a continuous state space and discrete action and observation
%   spaces.
%   Actually this example encodes the problem in Figure 1 of the paper that
%   is used for most of the reported experiments (with little variants in
%   some cases).
%
%   Parameters:
%     ncBelief: Number of components in the belief mixtures.
%     ncAlpha: Number of components in the alpha mixtures.
%     actionScale: Scale factor to apply to the right/left displacements.
%
%   Parameters are optional from left to rigth (if two parameters are given
%   we assume they are ncBelief and ncAlpha, etc).
%   When not given we use the following default values
%      ncBelief=4
%      ncAlpha=9
%      actionScale=2
%   Those correspond to the parameters used in Figure 2.
%
%   To solve the problem you can use
%
%      [POMDP P B V Val Alpha t]=TestOne('Test1');
%
%   To solve it many times collecting statistics on the quality of each
%   solution use
%
%       TestRep('Test1','myresults',1:10);
%
%   changing 'myresults' by the label you want to add to the output
%   file names.
%
%   After executing the separate experiments (this can be very time
%   demanding!) you can summarize the obtained statistics using:
%
%        [tics SM SD]=GetPOMDPAverageStatistics('Test1-myresults')
%
%   All problems (and their parameters) should be encoded in a file like
%   this one.
%
%   See also TestOne, TestRep, POMDP, GetHallwayParameters.

  if nargin==0
    ncBelief=5; %4;
  else
    ncBelief=varargin{1};
  end
  
  if nargin<2
    ncAlpha=9;
  else
    ncAlpha=varargin{2};
  end
  
  if nargin<3
    actionScale=2;
  else
    actionScale=varargin{3};
  end
  

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % Define the POMDP
    % State space is 1-D in the range -20,20
    S=CSpace(-20,20);
  
    % 3 actions: left, right, enterDoor
    A=DSpace(3);

    % 4 Observations: left-end, right-end, door, corridor
    O=DSpace(4);

    % discount factor
    gamma=0.95;

    % Action model with continuous states and discrete actions
    mu_a={-actionScale actionScale 0};
    Sigma_a={0.05 0.05 0.05};
    AM=CS_DA_ActionModel(S,A,mu_a,Sigma_a);

    % Observation model with continuous states and discrete observations.
    % Note that we actually define p(o,s) and that we assume p(s) to be
    % uniform. Thus Gaussians should be evenly distributed in 's' and with
    % the adequate covariance to define a uniform coverage. 
    so=1.6;
    om{1}=GMixture(ones(1,5),...
                   {Gaussian(-21,so) Gaussian(-19,so) Gaussian(-17,so) Gaussian(-15,so) Gaussian(-13,so)}); % left-end
    om{2}=GMixture(ones(1,5),...
                   {Gaussian( 21,so) Gaussian( 19,so) Gaussian( 17,so) Gaussian( 15,so) Gaussian( 13,so)}); % right-end
    om{3}=GMixture(ones(1,4),...
                   {Gaussian(-11,so) Gaussian( -5,so) Gaussian(  3,so) Gaussian(  9,so)}); % door
    om{4}=GMixture(ones(1,8),...
                   {Gaussian(-9,so) Gaussian(-7,so) Gaussian(-3,so) Gaussian(-1,so) ...
                    Gaussian( 1,so) Gaussian( 5,so) Gaussian( 7,so) Gaussian(11,so)}); % corridor
    OM=CS_DO_ObsModel(S,O,om);
    
    % reward model with continuous states and discrete actions
    rm{1}=GMixture([-2 -2 -2],{Gaussian(-21,1) Gaussian(-19,1) Gaussian(-17,1)});
    rm{2}=GMixture([-2 -2 -2],{Gaussian( 21,1) Gaussian( 19,1) Gaussian( 17,1)});
    rm{3}=GMixture([-10 2 -10],{Gaussian(-25,250) Gaussian(3,3) Gaussian(25,250)});
    RM=CS_DA_RewardModel(S,A,rm);

    % Assemble the POMDP
    POMDP=CS_DO_DA_POMDP('Test1',S,A,O,AM,OM,RM,gamma,ncAlpha);
    
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % Define the parameters for sampling beliefs  
    % Define the start belief
    g1=Gaussian(-15,30);
    P.start=GBelief(GMixture([1 1 1 1],{g1 g1+10 g1+20 g1+30}),ncBelief);

    % Define the rest of parameters
    % First the noes for Belief sampling
    P.nBeliefs=500;
    P.dBelief=0.1;
    P.stepsXtrial=30;
    P.rMin=-0.5;
    P.rMax= 0.5;
  
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % Define the parameters for testing
    P.maxTime=2500;
    P.stTime=100;
    P.numTrials=100;
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % Define the parameters for solving
    P.stopCriteria=@(n,t,vc)(t>P.maxTime);
    