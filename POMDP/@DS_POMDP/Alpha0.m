function a=Alpha0(P)
%   Alpha-element for the first Perseus iteration (discrete state version).
%
%   Generates the alpha element for initial planning horizion when working
%   with discrete state spaces.
%   The role of alpha_0 is detailed in Section 4, page 13, first paragraph.

  S=get(P,'StateSpace');
  gamma=get(P,'gamma');
  [u v]=UniformDistribution(S);
  a=(minReward(P)/(1-gamma))*(1/v)*u;
  