function [V Value Alpha t]=Perseus(P,B,stopCriteria)
%   The Perseus point-based POMDP solver.
%
%   Perseus algorithm.
%   A point-based solver for POMDP.
%   This corresponds to the algorithm in Table 2 (Section 6.1) of the paper.
%
%   Inputs
%      P: A POMDP object. This can be any of the specializations of the
%         POMDP (discrete/continuous states/actions/observations).
%      B: A set of beliefs.
%      stopCriteria: A function with 3 parameters (planning horizon,
%                    execution time, maximum change in the value for all
%                    beliefs in B in the last iteration).
%                    The function returns true if the main loop of Perseus
%                    must be stopped.
%   Outputs
%      V: A cell array of policies. V{n} is the policy for planning 
%         horizon 'n'.
%      Value: A cell array of vectors. Value{n}(i) is the value for belief
%             'i' in planning horizon 'n'.
%      Alpha: A cell array of vectors. Alpha{n}(i) is the alpha assigned to
%             belief 'i' in planning horizon 'n'.
%      t: A vector. t(n) is the time taken to compute the policy for
%         planning horizon 'n'.
% 
  
  % Get the number of beliefs in the set B
  nb=size(B,2);

  % Set up the initial policy (policy with planning horizon=1)
  n=1;                   
  V{n}=Policy;
  alpha0=Alpha0(P);
  V{n}=AddAlpha(V{n},alpha0,RandomAction(P));
  
  [Alpha{n} Value{n}]=cellfun(@(b)(MaxAlpha(V{n},b)),B);
    
  % And now start the itarations to improve the policy
  t_init=cputime;
  stop=false;
  
  while ~stop
    
    n1=n+1; % Horizon for the new policy to compute
    fprintf('    Iteration %u: ',n1);
    
    % Pre-compute the set of \Alphas_j_a_o 
    % This is only feasible in some types of POMDPs
    % In the rest of cases the output is empty
    fprintf('[P')
    Alphas_j_a_o=ComputeAlphas_j_a_o(P,V{n});
    fprintf('] ');
    
    % The new policy is initially empty
    V{n1}=Policy;
    
    % Initially all beliefs in B are to be improved   
    pending=true(1,nb);
    nPending=nb;
    it=1;
    while nPending>0
      fprintf('%u(%u)',it,nPending);
      it=it+1;
      
      % Select a belief pending to be improved at random
      ndx=find(pending); 
      nPending=size(ndx,2);
      cb=ndx(ceil(rand*nPending));
     
      % POMDP with continouos action sets are converted to their discrete
      % counterparts by sampling actions.
      % We sample a set of actions (taking into accound the action previously
      % assigned to the belief and the planning horizon).
      [alpha action]=V{n}{Alpha{n}(cb)};
      P1=DiscretizeActionModel(P,action,n);
      
      % Execute the backup (this is a different function given different
      % types of POMDP)
      fprintf('b[');
      [alpha optimalAction v]=Backup(P1,B{cb},V{n},Alphas_j_a_o);
      fprintf(']');
      
      % If the new value is not better that the one in the previous
      % planning horizon, use the previous alpha.
      if v<Value{n}(cb)
        [alpha optimalAction]=V{n}{Alpha{n}(cb)}; 
        fprintf('p ');
      else
        fprintf('n ');
      end
       
      % Add the new alpha to the new policy
      [V{n1} l]=AddAlpha(V{n1},alpha,optimalAction);
      
      for i=1:nb
        if pending(i)
          nv=Expectation(B{i},alpha);
          if nv>=Value{n}(i)
            pending(i)=false;
            nPending=nPending-1;
            Value{n1}(i)=nv;
            Alpha{n1}(i)=l;
          end
        end
      end
      
    end %  while nPending>0
    
    %[Alpha{n1} Value{n1}]=cellfun(@(b)(MaxAlpha(V{n1},b)),B);
  
    t(n1)=cputime-t_init; 
    vd=Value{n1}-Value{n};
    mvd=max(vd);
    avd=sum(vd)/nb;

    fprintf('\n                     mvd:%g  avd: %g  t: %f\n',mvd,avd,t(n1));
    
    n=n1; 
    
    stop=stopCriteria(n,t(n),mvd);
  end
  
  
