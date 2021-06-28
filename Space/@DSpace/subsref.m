function v=subsref(D,S)
%   Gets a values from a discrete space.
%
%   Retrives an element from a discrete set.
%

  if strcmp(S.type,'()')
    v=D.values{S.subs{:}};
  else
    error('Undefined DSpace subsref')
  end
