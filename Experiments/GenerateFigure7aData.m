function GenerateFigure7aData(fname)
%   Generates the data for Figure 7-left.
%
%   In this experiment we compute the time (in seconds) for the first 
%   iteration of Perseus for a discretized version of the problem 
%   described in Figure 1 with increasing number of states.
%   This gives allow to compare the computational complexity of the discrete
%   and the continuous versions of Perseus (compare the execution times
%   here with those in Figure 5).
%
%   Parameters:
%     fname: file where to store the results.
%
%   See also MakeFigure1, MakeFigure7.

   ns=100:100:1000;
   
   % Nothing to be modified beyond this point
   
   nns=size(ns,2);

   [POMDP P]=GetTest1Parameters;
   
   stopCriteria=@(n,t,vc)(n>1);
   
   nRep=5;
   
   tp=zeros(1,nns);
   k=1;
   for n=ns
     
     fprintf('Discretizing the POMDP with %u states\n',n);
     DPOMDP=Discretize(POMDP,n);
     
     start=DBelief(UniformDistribution(get(DPOMDP,'StateSpace')));
     
     fprintf('Sampling Beliefs\n');
     B=SampleBeliefs(DPOMDP,start,P.nBeliefs,P.dBelief,P.stepsXtrial,P.rMin,P.rMax);
     r=0;
     for s=1:nRep
       [V Val Alpha t]=Perseus(DPOMDP,B,stopCriteria);
       r=r+t(2);
     end
     tp(k)=r/nRep;
     k=k+1;
 
   end
   
   save(fname,'ns','tp');
   
