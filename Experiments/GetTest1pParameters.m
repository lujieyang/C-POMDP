function [POMDP P]=GetTest1pParameters(varargin)
%   The example on Figure 8.
%
%   This is the same example as GetTest1Parameters but using particles to
%   represent beliefs instead of Gaussian mixtures.
%
%   See also GetTest1Parameters.

   % Test1 with the default paramters
   %   ncBelief = 4 (not used)
   %   ncAlpha = 9
   %   actionScale = 2
   [POMDP P]=GetTest1Parameters();
   
   set(POMDP,'name','Test1p');
   
   if nargin==0
     npBelief=25;
   else
     npBelief=varargin{1};
   end
  
   S=get(POMDP,'StateSpace');
   [DS samples]=Discretize(S,npBelief);
   P.start=PBelief(ones(1,npBelief),samples);
   
