function [POMDP P]=GetTest1coParameters(varargin)
%   The example on Figure 11.
%
%   This is the same example as GetTest1caParameters but with a continuous
%   observation set.
%
%   Parameters
%     - nSampledObs: Samples to use when discretezing the observation
%                    space.
%                    Default value 100.
%
%   See also GetTest1caParameters.

   % Test1ca with the default paramters
   %   ncBelief = 4 (not used)
   %   ncAlpha = 9
   %   actionScale = 2
   %   nSampledActions = 4
   [POMDP P]=GetTest1caParameters();
   
   % Retrive information on the CS_DA_DO_POMDP
   gamma=get(POMDP,'gamma');
   ncAlpha=get(POMDP,'maxAlphaC');
   nSampledActions=get(POMDP,'nSampledActions');
   
   S=get(POMDP,'StateSpace');
   A=get(POMDP,'ActionSpace');
   
   AM=get(POMDP,'ActionModel');
   RM=get(POMDP,'RewardModel');
   
   % Redefined the obs. space and the obs. model
   O=CSpace(0,5);
   
   % Gaussians covering the state space
   gS=cell(1,22);
   k=1;    
   so=1.6;
   for i=-21:2:21
     gS{k}=Gaussian(i,so);
     k=k+1;
   end
   
   % Gaussian in obs space for left, right, corridor, door
   % defining the noisy observations
   gl=Gaussian(1,0.05);
   gr=Gaussian(2,0.05);
   gc=Gaussian(3,0.05);
   gd=Gaussian(4,0.05);
   gO={gl gl gl gl gl gd gc gc gd gc gc gc gd gc gc gd gc gr gr gr gr gr};
   
   % Weigths for the double Gaussian mixture. Just use a constant weight.
   % Those weights are adjusted insed the CS_CO_ObsModel constructor to
   % ensure p(s)=UniformProbability(S).
   w=ones(1,22);
   
   OM=CS_CO_ObsModel(S,O,w,gS,gO);
   
   % parameters to discretize the obs space.
   if nargin==0
     nSampledObs=25;
   else
     nSampledObs=varargin{1};
   end
   
   % With CO planning takes longer. We redefine maxtime, the stopCriteria, and
   % the time in between statistics with a scale factor, sf.
   sf=8; 

   P.maxTime=sf*P.maxTime;
   P.stopCriteria=@(n,t,vc)(t>P.maxTime);
   P.stTime=sf*P.stTime;
   
   % Define the POMDP
   POMDP=CS_CO_CA_POMDP('Test1co',S,A,O,AM,OM,RM,nSampledActions,nSampledObs,gamma,ncAlpha);
   
