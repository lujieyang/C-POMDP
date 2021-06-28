function data=GetData(fname,GenerateData)
%   Loads and, if necessary, generates data from experiments.
%
%   Checks if the file of results 'fname' exists. If not, (parameter-less) 
%   function GenerateData is executed to produce the file.
%   
%   Then the file is loaded and its content returned to the caller.
%
%   This function is used when generating the figures. The data for the
%   figures takes very long to be computed and, thus, it is pre-computed
%   whenever possible. This function is used to check whether or not some
%   results are already pre-computed with the aim of saving computation 
%   as much as possible.

  f=fopen(fname);
  if f<0
    fprintf('Data is not pre-computed: Generating it\n');
    GenerateData();
    f=fopen(fname);
    if f<0
      error('Data Missing');
    end
  end
  fclose(f);
  fprintf('Data is already computed: Reading it\n');
  data=load(fname);
  