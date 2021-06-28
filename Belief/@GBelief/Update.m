function bOut=Update(b,po,Sp)
%   Belief evolution under an observation model.
% 
%   Corrects a belief with the information given by the observation model,
%   'po'.
%   'po' is derived with GetObservationModelFixedO for the
%   corresponding obs model.

  bOut=GBelief(Crop(po*b.GMixture,Sp),b.maxC);
  
  