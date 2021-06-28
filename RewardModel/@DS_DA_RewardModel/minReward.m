function mr=minReward(RM)
%   Lower bound of the minimal possible reward.
%  
%   Returns a lower bound for the minimum of the funcion defined by the
%   reward model.

  mr=min(cellfun(@min,RM.r));