function [s b o r]=SimulationStep(P,b,s,a)
%   Executes one step of a POMDP simulation.
%   
%   It updates the belief using the corresponding Prediction method and the
%   given action and then corrects the belief using the corresponding
%   Update method.
%   The implementation of both the Prediction and Update methods are
%   dependant on the nature of the beliefs.
%
%   Parameters:
%     P: The POMDP.
%     b: The belief to update.
%     s: The hidden state (used to query the observation and reward models)
%     a: The action to execute.
%
%   Outputs:
%     s: The new hidden state.
%     b: The new belief.
%     o: The observation used in the Update.
%     r: The reward obtained in the new attained (hidden) state.
%
%   See also DBelief, GBelief, PBelief, SimulateFrom.

  S=get(P,'StateSpace');
  
  [s b]=Prediction(P,s,b,a,S);
  
  po=GetObsModelFixedS(P,s);
  if isa(po,'double')
    o=RandVector(po);
  else
    o=rand(po);
  end
  b=Update(P,b,o,S);
  
  r=Reward(P,a,s);
  