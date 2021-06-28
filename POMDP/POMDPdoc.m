% POMDP directory
%
% Directory with the implementation of the different types of POMDP.
% A POMDP is defined by the following elements (see Section 2 in the
% paper):
%
%     - A state space.
%     - An action space.
%     - An observation space.
%     - An action model (or transitio model).
%     - An observation model.
%     - A reward model.
%   
% The spaces (state/action/observation) can be discrete or continuous and
% the models change accordingly.
% This directory includes the implementation of the different types of
% POMDP given the underlying types of spaces.
%
% The POMDPs are structured in a hierarchy of objects with the purpose of
% sharing as much code as possible and in order to provide generic
% implementations of the main algorihtms (Perseus, SampleBeliefs,...) that
% use the particular methods for each POMDP sub-type.
%
% TODO % Complete the definition of all types of POMDPs.
%
% See also DSpace, CSpace, AMdoc, OMdoc, RMdoc.