function r=SimulateFrom(P,V,start,n)
%   Simulates a POMDP from a given belief.
%
%   Simulates a POMDP from a given belief ('start') for 'n' steps and using
%   the given policy ('V') to decide the actions to execute.
%
%   The functions drawns a state at random from the 'start' distribution
%   and uses is as a hidden state in the simulation. This hidden state is
%   used to query the observation and reward models.
%
%   Returns the accumulated discounted reward fro the simulation.
%   
%   This function is basically used to get statistics for the policy
%   derived after a planning session. As the elements in 'V' increase, the
%   simulation can get quite time demanding. Actually, this is the most
%   expensive step of the statistics collection that is more costly than
%   the planning itself.
%
%   See also GetPOMDPSolutionStatistics.

  A=get(P,'ActionSpace');
  noPolicy=empty(V);
  s=rand(start);
  b=start;
  r=0;
  gamma=1;
  for i=1:n
    if noPolicy
      a=rand(A);
    else
      a=OptimalAction(V,b);
    end
    [s b o r1]=SimulationStep(P,b,s,a);
    r=r+gamma*r1;
    gamma=gamma*P.gamma;
  end
  