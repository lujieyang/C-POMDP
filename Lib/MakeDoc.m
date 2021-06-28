function MakeDoc
%   Generates the documentation for this toolbox.
%
%   Generates the html documentation for this toolbox.
%   We assume m2html is available in the path.
%      (Execute addpath <path to m2html>)
%
%   The documentation can be browsed with a web browser opening
%       Doc/index.html
%
%   This function only works in Linux.

if exist('m2html','file')==2
  % Remove the previous documentation if any
  eval('!rm -rf Doc');
  % generate the new documentation
  m2html('mfiles','.','htmldir','Doc','recursive','on','global','on','template','IRI','index','menu','graph','on','todo','on');
  %m2html('mfiles','.','htmldir','Doc','recursive','on','global','on','template','frame','index','menu','graph','on','todo','on');
  %
  eval('!sed -i ''s/\.\.\///g'' Doc/*.html');
else
  error('m2html is not in the path');
end