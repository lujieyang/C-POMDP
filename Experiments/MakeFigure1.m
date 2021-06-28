function MakeFigure1
%   Generates Figure 1.
%
%   Displays the two lower plots of Figure 1 in the paper (i.e., the
%   observation model and the reward model).
%
%   This is an example of how to get and manipulate observation and reward
%   models.
%
%   See also GetTest1Parameters.

  [POMDP P]=GetTest1Parameters_large_value;
  
  h=clf;
  set(h,'name','C-POMDP Figure 1','numbertitle','off');
  
  subplot(2,1,1);
  OM=get(POMDP,'ObsModel');
  plot(GetObsModelFixedO(OM,1),'color','k','linestyle',':');
  plot(GetObsModelFixedO(OM,2),'color','k','linestyle','-.');
  plot(GetObsModelFixedO(OM,4),'color','k');
  plot(GetObsModelFixedO(OM,3),'color','k','linestyle','--');
  
  legend('Left End','Right End','Corridor','Door');
  
%   axis([-20 20 0 1.1]);
  axis([-20 20 0 1.5]);
  title('Observation Model');
  xlabel('s');
  ylabel('p(o)');
  
  subplot(2,1,2);
  RM=get(POMDP,'RewardModel');
  plot(GetRewardModelFixedA(RM,1),'color','k','linestyle',':');
  plot(GetRewardModelFixedA(RM,2),'color','k','linestyle','-.');
  plot(GetRewardModelFixedA(RM,3),'color','k');
  
  legend('Move Left','Move Right','Enter Door');
  
%   axis([-20 20 -1.2 0.4]);
  axis([-20 20 -1.2 2.2]);
  xlabel('s');
  ylabel('r(a)');
 
  title('Reward Model');
 
  