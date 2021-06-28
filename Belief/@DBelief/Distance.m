function d=Distance(db1,db2)
%   Distance between beliefs.
%
%   Distance between two beliefs on a discrete state space.

  d=norm(db1.v-db2.v);