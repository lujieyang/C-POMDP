function gm=AddComponent(gm,w,g)
%   Adds a component to the a Gaussian mixture
%
%   Adds a component to the a Gaussian mixture
%   Parameters
%      gm: The mixture to update.
%      w: The weight for the new component.
%      g: The Gaussian for the new component.
%   Output
%      gm: The updated mixture.
%
%   See also GMixture.

  gm.w=[gm.w w];
  gm.g=[gm.g g];
  gm.n=gm.n+1;  
