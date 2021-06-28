function bOut=Update(b,po,Sp)
%   Belief evolution under an observation model.
%  
%   Corrects a belief with the information given by the observation model,
%   'po'.
%   'po' is derived with GetObservationModelFixedO for the
%   corresponding obs model.
%
%   Note that we use the backed up samples possibly created in a
%   Predicition step before. If no prediction step was exectued before,  
%   the backup and the samples point to the same data.

  c=arrayfun(@(s)(Value(po,s)),b.noiselessMovedSamples);
  w=b.w.*c;
  g=cell(1,b.np);
  for i=1:b.np
    g{i}=Gaussian(b.samples(:,i),b.noise);
  end
  
  ns=zeros(b.ss,b.np);
  nw=zeros(1,b.np);
  for i=1:b.np
    j=RandVector(w);
    ns(:,i)=Crop(Sp,rand(g{j}));
    nw(i)=Value(po,ns(:,i))/c(j);
  end
  
  bOut=PBelief(nw,ns);
  