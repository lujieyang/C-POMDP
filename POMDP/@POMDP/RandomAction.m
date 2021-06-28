function a=RandomAction(P)
%   Draws a random action from a POMDP.
%
%   Selects a random action from the action model associated with the
%   POMPD.
%

 a=rand(get(P,'ActionSpace'));