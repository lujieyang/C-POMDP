function SB=SampleBeliefs(P,start,nBeliefs,minBeliefDist,stepsXtrial,minR,maxR)
%   Samples a set of beliefs from a POMDP.
%
%   Defines a set of 'nBeliefs' beliefs randomly simulating a POMDP.
%   This function corresponds to that in line 2 of Table 2 in section 6 of
%   the paper.
%
%   The sampling of beliefs is organized in trials. Each trial starts from
%   the given 'start' belief and evolves selecting actions and observations
%   at radom. Actions are selected with uniform probability and
%   observations from the corresponding observation model.
%   Each trial is stopped after executing 'stepsXtrial' steps of when the
%   received reward is outside the interval [minR, maxR].
%
%   Only beliefs that are further away more than 'minBelifDist' from any
%   other already stored beliefs are considered.
%   
%   The sampling of beliefs can be quite slow and some information is
%   printed while it proceeds.
%      '.' Means a new belief has been added to the output.
%      '*' Means a trial has ended.
%
%   See also SimulationStep, @DBelief/distance, @GMixture/Distance,
%   @PBelief/Distance.

  rand('state',sum(100*clock));
%   rand('twister',888);
  
  A=get(P,'ActionSpace');
  S=get(P,'StateSpace');
  
  md=minBeliefDist+1;
  SB=cell(1,nBeliefs);
  k=0;
  r=maxR-1;
  while k<nBeliefs
    if (mod(k,stepsXtrial)==0) %|| (r>maxR) || (r<minR)
      b=start;
      s=Crop(S,rand(b));
      fprintf('*\n');
    end

    a=rand(A);
    [s b o r]=SimulationStep(P,b,s,a);
    
    if (k>1) && (minBeliefDist>0)
      md=min(cellfun(@(b1)(Distance(b,b1)),SB(1,k)));
    end
    if md>minBeliefDist
      k=k+1;
      SB{k}=b;
      
      fprintf('.');
      if mod(k,80)==0
        fprintf('\n');
      end
    end
  end
  fprintf('\n');
  