function DS=Discretize(CS,n,varargin)
%   Converts a continuous space into a discrete one.
%
%   Generates a discrete space from a continuous one.
%   The discrete state is generated via sampling (each sample becomes one
%   of the states in the discrete version of the space).
%
%   Parameters:
%     CS: The continuous space
%     n: The number of samples to generate. The number of states of the
%        output discrete space.
%     samples: [optional] some samples to use in the discretization
%
%   Outputs:
%     DS: The resulting discrete space.
%

  if nargin>2
    k=size(varargin{1},2);
    samples=cell(1,k+n);
    samples(1:k)=varargin{1};
  else
    k=0;
    samples=cell(1,n);
  end

  for i=1:n
    samples{k+i}=rand(CS);
  end
  
  DS=DSpace(n+k,samples);