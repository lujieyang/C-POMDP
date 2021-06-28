% Matlab toolbox for planning in POMDPs with continuous spaces.
%
% Matlab toolbox for the POMDP planner described in 
%   Point-Based Value Iteration for Continuous POMDPs
%   Journal of Machine Learning Research 7, 2006 pp. 2329-2367
% by
%   Jm Porta, N. Vlassis, M.T.J. Spaan, and P. Poupart
%
% This code is a from-scratch re-writting of the original code used for the
% experiments reported in the paper. Several things are different in this
% this version (some minor bugs are fixed, some models are changed....) so,
% expect (small) changes in the results to be obtained with this version and
% those in the paper.
%
% All the experiments deal with a very simple one-dimensional path planning
% problem just to demostrate the viability of the presented approach. 
%
% The weaker point of the presented approach is the observation model.
% Strong assumptions are made on this model and this limits the practical
% applications of this approach, specially when the observation model is
% continuous. 
% If I even continue this research I will try to circumvent this issue.
%
% The main stress in this implementation is put on clarity and not in
% efficientcy. 
%
% The best way to understand this software package is:
%   A) To read the paper.
%   B) To check the Experiments directory where you can find specific
%      functions to replicate the different experiments reported in the paper.
%      We refer to those experiments by the figure number where their results
%      are plotted. It should be relatively easy to use this toolbox on your
%      own problems using these functions as a template.
% 
% For details on each function, check the associated documentation in the
% Doc directory (Doc/index.html)
%
clc;
disp(' ');
disp('                    Software associated with the paper: ');
disp('            Point-Based Value Iteration for Continuous POMDPs');
disp('                                   by');
disp('           Jm Porta, N. Vlassis, M.T.J. Spaan, and P. Poupart');
disp('     Journal of Machine Learning Research Vol. 7, pp. 2329-2367, 2006');
disp(' ');
disp(' ');
% Add all paths of the toolbox recursively
path(path,genpath(pwd));
