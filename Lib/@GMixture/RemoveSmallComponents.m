function [gmOut map]=RemoveSmallComponents(gm,t)
%   Eliminates the small components of a GMixture.
%
%   Produces a Gaussian mixture removing the small components of the input
%   mixture.
%   Parameters:
%     gm: The input mixture.
%     t: Weight threshold. Components with a weight with absolute value
%        below this threshold are removed.
%   Outputs:
%     gmOut: The mixture resulting from removing the small components.
%     map: Vector indicating which elements in the input mixture are used
%          in the output one (map(i)=j if the  i-th component of the output
%          mixture is the j-th component of the input mixture).

  map=find(abs(gm.w)>t);
  gmOut=GMixture(gm.w(map),gm.g(map));
  