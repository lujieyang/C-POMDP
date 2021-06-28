function [bOut po]=Update(OM,b,o,Sp)
%  Belief evolution under an observation model.
% 
%  Updates a belief with the observation 'o'.
%  Basically, we get the observation model fixing 'o' to get an update model
%  and then we update the belief with this model.
%  The parameter 'Sp' is the sub-space where beliefs are defined and is used to
%  ensure that, after the update, the belief is still inside this
%  sub-space.

  po=GetObsModelFixedO(OM,o);
  bOut=Update(b,po,Sp);
  