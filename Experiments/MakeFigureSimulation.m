function MakeFigureSimulation(title,data)
%   Generates the plots in Figures 2, 8, 10, and 11.
%
%   A function to generate the Figures 2, 8, 10, and 11, showing four
%   plots with the evolution in time of
%
%      - The average value per belief (in the paper we actually show the
%        sum of values for all beliefs).
%      - The average accumulated discounted reward.
%      - The number of alpha-elements in the policy.
%      - The average number of policy changes per belief (in the paper we
%        actually show the total number of policy changes).
%
%   This function does not compute anything, it just load the file with the
%   average results and make the plots.
%   The results are loaded for a file with name 
%      data-resutls.mat
%   where data is the given parameter.
%
%   See also GetPOMDPSolutionStatistics.
%

  h=clf;
  set(h,'name',title,'numbertitle','off');

  if ischar(data)
    Results=load([data '-results.mat']);
  else
    Results=data;
  end
  
  subplot(2,2,1);
  errorbar(Results.tics,Results.SM.AV,Results.SD.AV);
  xlabel('time (s)');
  ylabel('Value')
  
  subplot(2,2,2);
  errorbar(Results.tics,Results.SM.R,Results.SD.R);
  xlabel('time (s)');
  ylabel('Acc. Disc. Reward')
  
  subplot(2,2,3);
  errorbar(Results.tics,Results.SM.nAlpha,Results.SD.nAlpha);
  xlabel('time (s)');
  ylabel('No. \alpha-Elements');
  
  
  subplot(2,2,4);
  errorbar(Results.tics,Results.SM.nChanges,Results.SD.nChanges);
  xlabel('time (s)');
  ylabel('No. Policy Changes');
  