function [POMDP P]=GetTest1caParameters(varargin)
%   The example on Figure 10.
%
%   This is the same example as GetTest1Parameters but with a continuous
%   action set.
%
%   Parameters
%     - nSampledActions: Samples to use when discretezing the actions
%                        space.
%                        Default value 4.
%
%   See also GetTest1Parameters.

   % Test1 with the default paramters
   %   ncBelief = 4 (not used)
   %   ncAlpha = 9
   %   actionScale = 2
   [POMDP P]=GetTest1Parameters();
   
   % Retrive information on the CS_DA_DO_POMDP
   gamma=get(POMDP,'gamma');
   ncAlpha=get(POMDP,'maxAlphaC');
   
   S=get(POMDP,'StateSpace');
   ds=dim(S);
   O=get(POMDP,'ObsSpace');
   
   OM=get(POMDP,'ObsModel');
   
   % Now define the Action CSpace, the CS_CA_ActionModel and the
   % CS_CA_RewardModel
   
   %CSpace Action 
   A=CSpace(-6,6);
   
   % CS_CA_ActionModel
   B=eye(ds); % Assuming S and A have the same dimensionality
   Sa=0.05*eye(ds);
   AM=CS_CA_ActionModel(S,A,B,Sa);
   
   % CS_CA_RewardModel
   w=[ -10 2 -10  ...
       -2 -2 -2   -2 -2 -2 -2   -2 -2 -2 -2 -2  ...
       -2 -2 -2   -2 -2 -2 -2   -2 -2 -2 -2 -2 ];
     
   gS={ Gaussian(-25,250) Gaussian(3,3) Gaussian(25,250) ...
        Gaussian(-21,1) Gaussian(-19,1) Gaussian(-17,1) ...
        Gaussian(-21,1) Gaussian(-19,1) Gaussian(-17,1) Gaussian(-15,1) ...
        Gaussian(-21,1) Gaussian(-19,1) Gaussian(-17,1) Gaussian(-15,1) Gaussian(-13,1) ...
        Gaussian( 21,1) Gaussian( 19,1) Gaussian( 17,1) ...
        Gaussian( 21,1) Gaussian( 19,1) Gaussian( 17,1) Gaussian( 15,1) ...
        Gaussian( 21,1) Gaussian( 19,1) Gaussian( 17,1) Gaussian( 15,1) Gaussian( 13,1)};
      
   gA={ Gaussian(0,0.05) Gaussian(0,0.05) Gaussian(0,0.05) ... 
        Gaussian(-2,1) Gaussian(-2,1) Gaussian(-2,1) ... 
        Gaussian(-4,1) Gaussian(-4,1) Gaussian(-4,1) Gaussian(-4,1)...
        Gaussian(-6,1) Gaussian(-6,1) Gaussian(-6,1) Gaussian(-6,1) Gaussian(-6,1)...
        Gaussian( 2,1) Gaussian( 2,1) Gaussian( 2,1) ... 
        Gaussian( 4,1) Gaussian( 4,1) Gaussian( 4,1) Gaussian( 4,1)...
        Gaussian( 6,1) Gaussian( 6,1) Gaussian( 6,1) Gaussian( 6,1) Gaussian( 6,1) };

   RM=CS_CA_RewardModel(S,A,w,gS,gA);
   
   if nargin==0
     nSampledActions=4;
   else
     nSampledActions=varargin{1};
   end
   
   % Define the POMDP
   POMDP=CS_DO_CA_POMDP('Test1ca',S,A,O,AM,OM,RM,nSampledActions,gamma,ncAlpha);
   