function [gmC map]=CompressGR(gm,m,epsilon,MaxIterations)                                                    
%   Gaussian mixture compression using the Golberger and Roweis method.
%
%   Compresses a normalized Gaussian mixture so that it includes at most
%   'm' elements.
%   This function implements the method by Golberger and Roweis described
%   in appendix A of the paper.
%
%   Parameters
%     gm: The normalized mixture to compress
%     m: The maximum number of components in  the output compressed
%         normalized mixture.
%     epsilon: Convergence criterion. If the relative error between two
%              iterations changes less than epsilon we stop the process.
%     MaxIterations: If the process iterates more times than this threshold
%                    the compression process is stopped.
%   Output:
%     gmC: The output normalized mixture.
%     map: Map between components in the input mixtures and those in the
%          output one (This in \pi in Table 3 in Appendix A in the paper).

  if (gm.n<=m)
    % 'gm' is already compressed
    gmC=gm;
    map=1:gm.n; %trivial mapping one to one
  else
    
    gmC=GetLargestComponents(gm,m);
    % gmC=GetRandomComponents(gm,m);
    % gmC=GetFirstComponents(gm,m);

    % default fake distance
    d=inf;
    
    % default mapping (just to allocate space)
    map=1:gm.n;
    
    iteration=1;
    stop=false;
    while ~stop

      %Compute the mapping from 'gm' to 'gmC
      for i=1:gm.n
        f=gm.g{i};
        [md map(i)]=min(cellfun(@(g)GaussianKL(f,g),gmC.g));
      end

      %Update 'gmC'
      for j=1:m
        % get the components of gm that are close to the j component of gmC
        ndx=(map==j);
        sw=sum(gm.w(ndx));
        if sw>0
          gmC.w(j)=sw;
          gmC.g{j}=FuseComponents(GMixture(gm.w(ndx)/sw,gm.g(ndx)));
        else
          % None of the components of gm is close to this component of gmC
          % Replace with one random component from gm 
          m1=ceil(rand*gm.n);
          gmC.w(j)=gm.w(m1);
          gmC.g{j}=gm.g{m1};
        end
      end
      gmC=Normalize(gmC);

      % Update the distance from 'gmC' to 'gm'
      d1=d; 
      d=cellfun(@(f,g)(GaussianKL(f,g)),gm.g,gmC.g(map))*gm.w';

      iteration=iteration+1;
      
      stop=((d<epsilon)||(abs(d1-d)/d<epsilon));

      if (~stop)
        if (d1<d)
          error('Increasing distance');
        end
        if (iteration>MaxIterations)
          error('Too slow convergence');
        end
      end
    end

  end
