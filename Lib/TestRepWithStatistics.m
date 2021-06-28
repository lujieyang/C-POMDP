function TestRepWithStatistics(varargin)
%   Executes many times Perseus on a given problem and collects statistics.
%
%   This is a combination of TestRep and GetPOMDPAverageStatistics, i.e.,
%   it executes several repetitions on a given problem and then it computes
%   the average of the statistics obtained at each repetition.
%

  TestRep(varargin{1:end});
  switch nargin
    case 3
      GetPOMDPAverageStatistics([varargin{1} '-' varargin{2}],varargin{3}(1));

    case 4
      GetPOMDPAverageStatistics([get(varargin{1},'name') '-' varargin{3}],varargin{4}(1));

    otherwise
      error('Wrong number of parameters in TestRepWithStatistics');
  end