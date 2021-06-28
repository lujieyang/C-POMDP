function [sOut bOut]=Prediction(AM,s,b,a,Sp)
%   Belief evolution under the given action. 
%
%   Updates a belief applying action 'a'.
%   Parameters:
%     AM: The action model to use.
%     s: The hidden state. We also update it to use it in simulations.
%        Note, however, that this state is never accesible by the planner
%        (only the beliefs are).
%     b: The belief to update.
%     a: The action to apply
%     Sp: Space where the belief is defined (used to bound the belief  and
%         the hidden state if necessary).
%   Outputs:
%     sOut: The updated hidden state.
%     bOut: The updated belief.  

  [bOut t]=BeliefPrediction(AM,b,a,Sp);
  
  sOut=Crop(Sp,s+rand(t));
  