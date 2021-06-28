function bOut=Prediction(b,t,Sp)
%   Belief evolution given a transition model.
%
%   Updates a belief with a given transiton probability function, 't'.
%   Function 't' is the outcome of GetActionModelFixedA for the corresponding
%   action model.

  bOut=DBelief(t*b.v);
  
  