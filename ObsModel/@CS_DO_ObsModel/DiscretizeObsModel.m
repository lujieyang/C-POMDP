function DOM=DiscretizeObsModel(OM,DS)
%   Discretizes the observation model on the state side.
%
%   Defines an observation model on a discrete state space from an
%   observation model on a continuous one.
%   In both cases the observation space is discrete.
%   

  ns=dim(DS);
  
  no=dim(OM.O);
  p=cell(1,no);
  for i=1:no
    p{i}=zeros(ns,1);
    for j=1:ns
      p{i}(j)=Value(OM.p{i},DS(j));
    end
  end
  
  % Ensure that  sum_o p(o|s)=1
  % For the contin
  s=p{1};
  for i=2:no
    s=s+p{i};
  end  
  for i=1:no
    p{i}=p{i}./s;
  end
  
  DOM=DS_DO_ObsModel(DS,OM.O,p);
