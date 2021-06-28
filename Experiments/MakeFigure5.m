function MakeFigure5
%   Generates Figure 5.
%   
%   In this experiment we compute the time (in seconds) for the first 
%   iteration of Perseus using different number of components to represent 
%   the beliefs and the alpha-mixtures. 
%   This give an idea of the complexity added when incresing the number of
%   components in the beliefs or in the alpha-mixtures.
%
%   Figure 6 shows the performace degradation when using too few components
%   in beliefs or in alpha-mixtures.
%

  h=clf;
  set(h,'name','C-POMDP Figure 5','numbertitle','off');
  
  fprintf('Loading/Generating the simulation results\n');
  fname='Results/Test1-Figure5.mat';
  GenData=@()(GenerateFigure5Data(fname));
  Results=GetData(fname,GenData);

  subplot(1,2,1);
  bar(Results.cb,Results.tb);
  
  title('1st Iteration Exec. Time');
  xlabel('No. Components Beliefs');
  ylabel('t (s)');
  
  subplot(1,2,2);
  bar(Results.ca,Results.ta);
  xlabel('No. Components \alpha-functions');
  ylabel('time (s)');