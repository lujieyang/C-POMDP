function h=plot(RM)
% Plots the CS_CA_RewardModel
%
% Plot a 3d surface representing the reward function in the continous state
% and action spaces.
% It only works for one-dimensional spaces.
   
   if dim(RM.S)==1 && dim(RM.A)==1
     
     s=min(RM.S):max(RM.S);
     a=min(RM.A):max(RM.A);
     ns=size(s,2);
     na=size(a,2);
     sr=zeros(ns,na);
     for i=1:ns
       for j=1:na
         sr(i,j)=sum(RM.w.*cellfun(@(g)(Value(g,s(i))),RM.gS).*cellfun(@(g)(Value(g,a(j))),RM.gA));
       end
     end
     h=surf(s,a,sr');
   else
     error('CS_CA_RewardModel plot only implemented for one-dimensional S/A spaces');
   end