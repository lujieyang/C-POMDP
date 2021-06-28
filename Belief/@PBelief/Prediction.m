function bOut=Prediction(b,t,Sp)
%   Belief evolution given a transition model.
%  
%   Updates a particle-based belief with a given transiton probability function, 't'.
%   Function 't' is the outcome of GetActionModelFixedA for the corresponding
%   action model.
%
%   Note that the prediction and update steps using particles are tied
%   together (see Section 5.3.2 of the paper). However, for compatibility
%   with the rest of belief representations it is nice to have separate 
%   Prediction and Update functions.
%   Here we store a backup of the particles (to use them in the Update) and
%   we randomly modify them using the action model.

  bOut=b;
  
  bOut.noiselessMovedSamples=bOut.samples+repmat(get(t,'mean'),1,bOut.np);
  bOut.noise=get(t,'covariance');
  for i=1:b.np
    bOut.samples(:,i)=rand(t+bOut.samples(:,i));
  end
  
  
  