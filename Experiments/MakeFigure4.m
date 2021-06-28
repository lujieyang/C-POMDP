function MakeFigure4
%   Generates Figure 4.
%
%   This figure displays the value for beliefs with only one component.
%   Those beliefs only have two parameters (mean and covariance) and, thus,
%   the value can be displayed as a 3d plot to show how that the value
%   function is not convex in the parameter space.
%
%   POMDP are sometimes addressed in the parameter space (see the paper by
%   Brooks et al. 2006, cited in our paper) but then value iteration can
%   not take advantage of the convexity of the value function.
%
%   If the results for Figure 1 are not pre-computed we compute them on the
%   fly (this can be quite time consuming). Even if they are pre-computed,
%   this function takes some time since it computes the value for a large
%   collection of beliefs.
%

  % means and covariances to use in the plot
  mu=-20:0.5:20;
  sigma=0.5:0.5:7;
  
  % Nothing to be modified beyond this point
  
  fprintf('Loading/Generating the simulation results\n');
  GenData=@()(TestRep('Test1','Figure2',2));
  Results=GetData('Results/Test1-Figure2-2.mat',GenData);
  
  % Get the las policy of the simulation
  Policy=Results.V{end};
  
  fprintf('Computing the values for 1-Gaussian beliefs from the loaded data\n');
  fprintf('This can take some time....\n');
  
  nMu=size(mu,2);
  nSigma=size(sigma,2);
  v=zeros(nSigma,nMu);
  a=zeros(nSigma,nMu);
  for i=1:nSigma
    for j=1:nMu
      b=GBelief(GMixture(1,{Gaussian(mu(j),sigma(i)^2)}));
      [a(i,j) v(i,j)]=OptimalAction(Policy,b);
    end
  end
  fprintf('....plotting the results\n');
  
    
  h=clf;
  set(h,'name','C-POMDP Figure 4','numbertitle','off');
  
  surf(mu,sigma,v,a);
  xlabel('\mu');
  ylabel('\sigma');
  zlabel('Value');
  
  