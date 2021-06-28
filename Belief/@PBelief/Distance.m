function d=Distance(pb1,pb2)
%   Distance between beliefs.
%
%   Distance between two beliefs on a continuous state space defined using
%   particles.

  md=arrayfun(@(i)(min(sum((pb2.samples-repmat(pb1.samples(:,i),1,pb2.np)).^2,1))),1:pb1.np);
  d=sum(pb1.w.*md);