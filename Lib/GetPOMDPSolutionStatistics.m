function [tics aV aR nA nC]=GetPOMDPSolutionStatistics(POMDP,P,B,V,Alpha,time,maxTime,stTime)
%   Collects statistics with the outcome of an experiment.
%
%   Computes statistics on a solution obtained by Perseus.
%   Parameters
%     - POMDP: The POMDP on which Perseus was applied.
%     - P: Set of parameters used to solve the problem.
%     - B: Set of Beliefs used to apply Perseus.
%     - V: Set of policies obtained by Perseus (one per iteration. Lines
%          6-22 of Table 1, page 12 of the paper).
%     - Alpha: Alpha element assigned to each Belief in each iteration
%     - time: Time at which each iteration was compleated.
%     - maxTime: Max time in second for which to which collect statistics.
%     - stTime: Step between two consecutive recollection of statistics.
%   Outputs
%     - tics: Time at which statistics are collected
%     - aV: Average value for all beliefs. The computation of this value
%           can be quite demanding.
%     - aR: Average cummulative discounted reward. T The POMDP is simulated 
%           several times for several time slices (both parameters are set 
%           in P) and, thus, his is extremely time demanding.
%     - nA: Number of alpha elements in the policy.
%     - nC: Average number of changes in the optimal action for each belief
%           from one policy to the next.

  nSteps=floor(maxTime/stTime);
  tics=(0:(nSteps-1))*stTime;
  
  aV=zeros(1,nSteps);
  aR=zeros(1,nSteps);
  nA=zeros(1,nSteps);
  nC=zeros(1,nSteps);
  
  % Table from time at fixed intervals to time in
  % irregular
  h=ones(1,nSteps);
  j=1;
  for i=2:nSteps
    while time(j)<tics(i)
      j=j+1;
    end
    h(i)=j-1;
  end
  
  %Number of beliefs in B
  nb=size(B,2);
  
  fprintf(' Computing average expected value   :');
  for n=1:nSteps
    fprintf('.');
    if (n==1)||(h(n)~=h(n-1))
      [Aph Vl]=cellfun(@(b)(MaxAlpha(V{h(n)},b)),B);
      aV(n)=sum(Vl)/nb;
    else
      aV(n)=aV(n-1);
    end
  end
  fprintf('\n');
  
  fprintf(' Computing average discounted reward:');
  for n=1:nSteps
    fprintf('.');
    if (n==1)||(h(n)~=h(n-1))
      r=0.0;
      for i=1:P.numTrials
        r1=SimulateFrom(POMDP,V{h(n)},P.start,P.stepsXtrial);
        r=r+r1;
      end
      aR(n)=r/P.numTrials;
    else
      aR(n)=aR(n-1);
    end
  end
  fprintf('\n');
  
  fprintf(' Getting number of alpha elements:\n');
  for n=1:nSteps
    nA(n)=size(V{h(n)});
  end
  
  fprintf(' Getting number of policy changes:\n');
  discreteA=isa(get(POMDP,'ActionSpace'),'DSpace');
  nC(1)=1; % at first step all belief change
  for n=2:nSteps
    l=h(n-1);
    s=h(n);
    for i=1:nb
      [e1 a1]=V{l}{Alpha{l}(i)};
      [e2 a2]=V{s}{Alpha{s}(i)};
      if discreteA
        nC(n)=nC(n)+(a1~=a2);
      else
        nC(n)=nC(n)+norm(a1-a2);
      end
    end
    nC(n)=nC(n)/nb;
  end
  
  