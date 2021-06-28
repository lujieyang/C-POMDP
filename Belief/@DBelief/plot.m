function h=plot(b,varargin)
%   Plots a discrete belief.
%
%   Plots a discrete belief as a curbe in the X-Y plane with X in the range
%   [1,numStates] and Y the probability for the corresponding state.

  h=plot(b.v,varargin{1:end}); 