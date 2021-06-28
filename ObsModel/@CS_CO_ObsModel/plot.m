function h=plot(OM)
% Plots the CS_CO_ObsModel
%
% Plot a 3d surface representing the obs model p(o|s) in continuous
% observation and state spaces
% It only works for one-dimensional spaces.
   
   if dim(OM.S)==1 && dim(OM.O)==1
     
     s=min(OM.S):0.25:max(OM.S);
     o=min(OM.O):0.25:max(OM.O);
     ns=size(s,2);
     no=size(o,2);
     sp=zeros(ns,no);
     for i=1:ns
       for j=1:no
         sp(i,j)=sum(OM.w.*cellfun(@(g)(Value(g,s(i))),OM.gS).*cellfun(@(g)(Value(g,o(j))),OM.gO));
       end
     end
     h=surf(s,o,sp');
   else
     error('CS_CO_ObsModel plot only implemented for one-dimensional S/O spaces');
   end