function [bOut t]=BeliefPrediction(AM,b,a,Sp)
%   Belief evolution under a given action.
%
%   Generic implementation of a prediction step according to a given action
%   model
%   This bunction returns a belief (bOut) resulting from applying action 
%   'a' the input belief 'b'.
%
%   Additionally, it returns the action model fixing the action to 'a'
%   (i.e., the action model particularized for 'a' used in the prediction).
%   The last parameter, Sp, is the state sub-space where the beliefs are
%   defined. This is used to crop the belief so that it does not scape from
%   the defined area. This is only used when the base state space is
%   continuous.

  t=GetActionModelFixedA(AM,a);
  
  bOut=Prediction(b,t,Sp); 