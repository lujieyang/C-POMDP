function gmC=Compress(gm,m)
%   Gaussian mixutre compression.
%
%   Compresses a Gaussian mixture so that it includes only 'm' components.
%   We first remove components with tiny weigth and then we apply the 
%   compression by Goldberger and Roweis (see Appendix A in the paper).
%
%   Note that this can be applied to both normalized and unnormalized
%   mixtures.
%
%   Both Gaussian-based beliefs and alpha-elements are compressed. So, this 
%   is one of the fundamental methods of this toolbox. Any improvement in
%   this function results in a large speed up in the global planner.

  if (gm.n<=m) || (m==0) % if gmC is not already compressed or not to be compressed
    gmC=gm;
  else
    % This is to ensure all weights are positive, in [0,1], and sum 1
    gmN=Normalize(gm);

    % Remove remove non-important components (to speed up next step)
    %   - gmLC is the sub-set of gmN with relemant components
    %   - mapLC is the index of the elements of gmN used to form gmLC
    [gmLC mapLC]=RemoveSmallComponents(gmN,0.1/gmN.n);
    
    % Use the Goldberger and Roweis compression
    %   - gmC is the compressed mixture
    %   - mapC are pointers from eleements in gmLC to elements in gmC
    %     (this allow to identify the elements in gmLC aggregated to form
    %     an element in gmC)
    [gmC mapC]=CompressGR(Normalize(gmLC),m,1e-5,50);
 
    % Recover the original weigths summing the weights of the input 
    % components assigned to each  output component
    gmC.w=zeros(1,gmC.n);
    for i=1:gmC.n
      ndx=(mapC==i);
      gmC.w(i)=sum(gm.w(mapLC(ndx)));
    end

    % Caution: at this point gmC is not normalized any more
    gmC=RemoveSmallComponents(gmC,1e-3);
 end
