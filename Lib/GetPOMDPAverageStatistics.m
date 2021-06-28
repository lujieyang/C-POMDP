function [tics SM SD]=GetPOMDPAverageStatistics(prefix,varargin)
%   Averages statistics collected after an experiment.
%
%   Experiments are repeated several times to get reliable statistics on
%   the results. After each experiment, a file is generated with statistics
%   on the results of the experiments. This function agregates those
%   statistics computing their average value and their standard deviation.
%   These are the values used to generate the plots in the paper.
%
%   This function accepts two parameters
%      - Prefix: First part of the name for the files with the results. All
%                files are assumed to be in the Result directory (this part
%                of the filename is automatically added) and filenames are
%                supposed to be numbered consecutively. The number is added
%                at the end of the file name, preceeded by a '-'.
%      - n: Number of the first result file to be used. If not given 1 is
%           assumed.
%   This function reads as many available result files as available.
%   The results are returned and also written down to a file with name
%   'Results/Prefix-result.mat'.
%
%   The outputs are
%      tics: Time at which statistics where collected
%      SM: Mean for 
%           AV: Average value for all beliefs
%           R: Average Discounted accumulated reward for several simulations
%           nAlpha: Average number of alpha elements in the policy
%           nChanges: Average number of changes of optimal action per
%                     belief from one policy to the next.
%      SD: The standard deviation for the previous data.
%
%   Example of use 
%    [tics SM SD]=GetPOMDPAverageStatistics('Test1-Figure1')
%
%   See also TestRep, GetPOMDPSolutionStatistics.
  
  if nargin==1
    start=1;
  else
    start=varargin{1};
  end
  
  k=1;
  found=true;
  while found
    name=sprintf('Results/%s-%u.mat',prefix,start+k-1);
    fid=fopen(name);
    if (fid<0)
      found=false;
    else
      fprintf('Reading file: %s\n',name);
      fclose(fid);

      C=load(name);
        
      if k==1
        nSteps=size(C.aV,2);
        tics=C.tics;
        
        AV=zeros(10,nSteps);
        R=zeros(10,nSteps);
        nAlpha=zeros(10,nSteps);
        nChanges=zeros(10,nSteps);
      else
        if nSteps~=size(C.aV,2)
          error('Size missmatch between different results');
        end
      end
      
      AV(k,:)=C.aV;
      R(k,:)=C.aR;
      nAlpha(k,:)=C.nA;
      nChanges(k,:)=C.nC;
      
      k=k+1;
    end % end of if file can be openned
  end
  if k>1
    % Compute mean values
    r=1:(k-1);
    SM.AV=mean(AV(r,:),1);
    SD.AV=std(AV(r,:),1,1);
    
    SM.R=mean(R(r,:),1);
    SD.R=std(R(r,:),1,1);
    
    SM.nAlpha=mean(nAlpha(r,:),1);
    SD.nAlpha=std(nAlpha(r,:),1,1);
    
    SM.nChanges=mean(nChanges(r,:),1);
    SD.nChanges=std(nChanges(r,:),1,1);
  
    name=sprintf('Results/%s-results.mat',prefix);
    save(name,'tics','SM','SD');
  else
    error('No data available to compute the average results');
  end
