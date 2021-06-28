function POMDPData=ReadDiscretePOMDPData(filename)
%   Reads a discrete POMDP from a file.
%
%   Parser for "Tony's POMDP file format"
%      http://www.cs.brown.edu/research/ai/pomdp/examples/pomdp-file-spec.html
%   This format is only valid for discrete state/actions/observations POMDPs.
% 
%   The applications we have in main when developing this planner is robot
%   navigation. Therefore we assume an observation model and a 
%   reward model typical of these applications: 
%
%         p(o|s) -> depends only on the reached state 's' and not on the
%                   executed action (as it does in the general POMDP model)
%
%         r_a(s) -> depends only on the reached state 's' and on the executed
%                   action 'a' but not the departing state or the obtained
%                   observations (as it does in the general POMDP model).
%                   Actually, in a pure robot navigation scenario the
%                   reward only depends on the reached state and not on the
%                   executed action but we keep the action dependancy to
%                   have a code coherent with the papers.
%
%   POMDP with different observation and reward models produce an error.
%
%   This function is adapted from that defined in the PERSEUS
%   software by Matthijs Spaan and Nikos Vlassis.
%
%   Parameters:
%        filename  - string denoting POMDP file to be parsed
%   Outputs:
%        POMDPData     - struct (see below)
%
%
%   PMDPData struct members definition:
% 
%     nStates       - number of states
%     StateNames    - (nStates x X) chars, name of each state *)
%
%     nActions      - number of actions
%     ActionNames   - (nActions x X) chars, name of each action *)
%     Actions       - {nActions} This is used as a description of the action by
%                     Perseus. For discrete actions POMDPs (as the ones read
%                     here) this is just number from 1 to nActions. From
%                     continuous action spaces each element of this set can
%                     be a vector describing an action or whatever is needed.
%
%     nObs          - number of observations
%     ObsNames      - (nObs x X) chars, name of each observation *)
%
%     gamma         - discount factor.
%     start         - (1 x nStates) start distribution *)
%
%     T             - (nStates x nStates x nActions)
%                         s'        s          a        T(s',s,a)=p(s'|s,a)
%
%     O             - (nObs X nStates)
%                         o      s'                     O{o}(s')=p(o|s')
%
%     R             - (nActions X nStates)              R{a}(s')=r_a(s')
%
%   Members marked by *) are optional: they might not be present in
%   the POMDP file, in that case these members are non-existing or
%   empty.
%
  if nargin<1
    error('Specify filename to be parsed');
  end
 
  file=textread(filename,'%s','delimiter','\n','whitespace','','bufsize',100000,'commentstyle','shell');
  nrLines=length(file);
  
  % read the preamble
  POMDPData=processPreamble(file);
  
  if POMDPData.nStates<1
    error('POMDPData has only %d states.',POMDPData.nStates);
  end
  if POMDPData.nActions<1
    error('POMDPData has only %d actions.',POMDPData.nActions);
  end
  if POMDPData.nObs<1
    error('POMDPData has only %d observations.',POMDPData.nObs);
  end
  
  % allocate memory
  for i=1:POMDPData.nObs
    POMDPData.O{i}=zeros(POMDPData.nStates,1);
  end
  POMDPData.T=cell(1,POMDPData.nActions);
  for i=1:POMDPData.nActions
    POMDPData.T{i}=zeros(POMDPData.nStates,POMDPData.nStates);
  end
  for i=1:POMDPData.nActions
    POMDPData.R{i}=zeros(POMDPData.nStates,1);
  end
 
  % process each line
  for i=1:nrLines
    if ~isempty(file{i})
      switch file{i}(1)
        case 'T'
          if ~isempty(strfind(file{i},':'))
            POMDPData=processTransition(POMDPData,file,i);
          end
        case 'R'
          if ~isempty(strfind(file{i},':'))
            POMDPData=processReward(POMDPData,file,i);
          end
        case 'O'
          if ~isempty(strfind(file{i},':'))
            POMDPData=processObservation(POMDPData,file,i);
          end
        case 's'
          if strcmp('start:',file{i}(1:6))
            [s,f,t]=regexp(file{i},'([-\d\.]+)');
            [foo,d]=size(t);
            if d~=POMDPData.nStates
              POMDPData.start=parseNextLine(file,i+1,POMDPData.nStates,1)';
            else
              POMDPData.start=zeros(d,1);
              string=file{i};
              for j=1:d
                POMDPData.start(j)=str2double(string(t{j}(1):t{j}(2)));
              end
            end
          end
      end
    end
  end
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function POMDPData = processPreamble(file)
  [nr,members]=getNumberAndMembers(file,'states:');
  POMDPData.nStates=nr;
  POMDPData.StateNames=members;
  
  [nr,members]=getNumberAndMembers(file,'actions:');
  POMDPData.nActions=nr;
  POMDPData.ActionNames=members;
  for a=1:POMDPData.nActions
    POMDPData.Actions{a}=a; %In discrete action POMDPDatas actions are just numbered
  end
  
  [nr,members]=getNumberAndMembers(file,'observations:');
  POMDPData.nObs=nr;
  POMDPData.ObsNames=members;
  
  for i=1:length(file)
    if strmatch('discount:',file{i});
      POMDPData.gamma=sscanf(file{i},'discount: %f');
      break;
    end
  end
  
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [nr, members] = getNumberAndMembers(file,baseString)
  for i=1:length(file)
    if strmatch(baseString,file{i})
      string=file{i};
      break;
    end
  end
  
  % try to find a number here
  [s,f,t]=regexp(string,sprintf('%s%s',baseString,'\s*(\d+)'));
  if isempty(s)
    % catch 'X: <list of X>' where X={states,actions,observations}
    % first strip baseString
    [s,f,t]=regexp(string,baseString);
    string1=string(f(1)+1:end);
    % see if there are more members on the next line
    stop=0;
    k=0;
    while ~stop
      k=k+1;
      if isempty(strfind(file{i+k},':'))
        string1=strcat([string1 ' ' file{i+k}]);
      else
        stop=1;
      end
    end
    [s,f,t]=regexp(string1,'\s*(\S+)\s*');
    [foo,nr]=size(t);
    members='';
    for a=1:nr
      members=strvcat(members,string1(t{a}(1):t{a}(2)));
    end
  else
    nr=str2double(string(t{1}(1):t{1}(2)));
    members='';
  end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function POMDPData = processTransition(POMDPData,file,i)
  string=file{i};

  if nnz(string==':')==3
    % catch 'T: <action> : <start-state> : <end-state> <prob>'
    pat='T\s*:\s*(\S+)\s*:\s*(\S+)\s*:\s*(\S+)\s+([\d\.]+)';
    [s,f,t]=regexp(string,pat);
    
    if ~isempty(t)
      prob=str2double(string(t{1}(4,1):t{1}(4,2)));
    else % probably the prob is on the next line
      % catch 'T: <action> : <start-state> : <end-state> 
      pat='T\s*:\s*(\S+)\s*:\s*(\S+)\s*:\s*(\S+)\s*';
      [s,f,t]=regexp(string,pat);
      prob=parseNextLine(file,i+1,1,1);
    end
    
    action=expandAction(POMDPData,string(t{1}(1,1):t{1}(1,2)));
    from=expandState(POMDPData,string(t{1}(2,1):t{1}(2,2)));
    to=expandState(POMDPData,string(t{1}(3,1):t{1}(3,2)));
    
    POMDPData.T{action}(to,from)=prob;
    
  elseif nnz(string==':')==2
    % catch 'T: <action> : <start-state>'
    pat='T\s*:\s*(\S+)\s*:\s*(\S+)';
    [s,f,t]=regexp(string,pat);
    action=expandAction(POMDPData,string(t{1}(1,1):t{1}(1,2)));
    from=expandState(POMDPData,string(t{1}(2,1):t{1}(2,2)));
    % catch all probs
    % first try if they are at the end of this line
    string=string(t{1}(2,2)+1:end);
    [s,f,t]=regexp(string,'([\d\.]+)');
    [foo,d]=size(t);
    if d~=POMDPData.nStates
      % hmm, probably they are on the next line
      string=file{i+1};
      [s,f,t]=regexp(string,'([\d\.]+)');
      [foo,d]=size(t);
      if d~=POMDPData.nStates
        error(['Not the correct number of probabilities on the next ' 'line.']);
      end
    end
    
    for to=1:d
      prob=str2double(string(t{to}(1):t{to}(2)));
      for a=action'
        POMDPData.T{a}(to,from)=prob;
      end
    end
    
  else
    % catch 'T: <action>
    pat='T\s*:\s*(\S+)\s*';
    [s,f,t]=regexp(string,pat);
    action=expandAction(POMDPData,string(t{1}(1,1):t{1}(1,2)));
    values=parseNextLine(file,i+1,POMDPData.nStates,POMDPData.nStates);
    for a=action
      POMDPData.T{action}(:,:)=values';
    end
  end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function POMDPData = processObservation(POMDPData,file,i)
  string=file{i};

  if nnz(string==':')==3
    % catch 'O: <action> : <end-state> : <observation> <prob>'
    pat='O\s*:\s*(\S+)\s*:\s*(\S+)\s*:\s*(\S+)\s+([\d\.]+)';
    [s,f,t]=regexp(string,pat);
    
    if ~isempty(t)
      prob=str2double(string(t{1}(4,1):t{1}(4,2)));
    else % probably the prob is on the next line
      % catch 'O: <action> : <start-state> : <end-state> 
      pat='O\s*:\s*(\S+)\s*:\s*(\S+)\s*:\s*(\S+)\s*';
      [s,f,t]=regexp(string,pat);
      prob=parseNextLine(file,i+1,1,1);
    end
    
    action=expandAction(POMDPData,string(t{1}(1,1):t{1}(1,2)));
    to=expandState(POMDPData,string(t{1}(2,1):t{1}(2,2)));
    observation=expandObservation(POMDPData,string(t{1}(3,1):t{1}(3,2)));
    
    if length(action)~=POMDPData.nActions
      error('The observation Model should be independent of the action');
    end
    no=size(observation,2);
    for i=1:no
      POMDPData.O{observation(i)}(to)=prob; % p(o|s)=p(o|s1,a) 
    end
    
  elseif nnz(string==':')==2
    % catch 'O: <action> : <end-state>'
    pat='O\s*:\s*(\S+)\s*:\s*(\S+)';
    [s,f,t]=regexp(string,pat);
    action=expandAction(POMDPData,string(t{1}(1,1):t{1}(1,2)));
    to=expandState(POMDPData,string(t{1}(2,1):t{1}(2,2)));
    % catch all probs
    % first try if they are at the end of this line
    string=string(t{1}(2,2)+1:end);
    [s,f,t]=regexp(string,'([\d\.]+)');
    [foo,d]=size(t);
    if d~=POMDPData.nObs
      % hmm, probably they are on the next line
      string=file{i+1};
      [s,f,t]=regexp(string,'([\d\.]+)');
      [foo,d]=size(t);
      if d~=POMDPData.nObs
        error(['Not the correct number of probabilities on the next ' 'line.']);
      end
    end
    
    if length(action)~=POMDPData.nActions
      error('The observation Model should be independent of the action');
    end
    
    for obs=1:d
      prob=str2double(string(t{obs}(1):t{obs}(2)));
      POMDPData.O{obs}(to)=prob; % p(o|s)=p(o|s a)
    end
  else
    % catch 'O: <action>
    pat='O\s*:\s*(\S+)\s*';
    [s,f,t]=regexp(string,pat);
    action=expandAction(POMDPData,string(t{1}(1,1):t{1}(1,2)));
    values=parseNextLine(file,i+1,POMDPData.nObs,POMDPData.nStates)';
    
    if length(action)~=POMDPData.nActions
      error('The observation Model should be independent of the action');
    end
    
    for i=1:POMDPData.nObs
      for j=1:POMDPData.nStates
        POMDPData.O{i}(j)=values(i,j); % p(o|s)=p(o|s1,a) 
      end
    end
  end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function POMDPData = processReward(POMDPData,file,i)
  string=file{i};

  if nnz(string==':')==4
    % catch 'R: <action> : <start-state> : <end-state> : <observation> <reward>'
    % Reward can be negative
    pat=['R\s*:\s*(\S+)\s*:\s*(\S+)\s*:\s*(\S+)\s*:\s*(\S+)\s+([-\d\.]+' ...
        ')'];
    [s,f,t]=regexp(string,pat);
    
    if ~isempty(t)
      reward=str2double(string(t{1}(5,1):t{1}(5,2)));
    else % probably the reward is on the next line
      % catch 'R: <action> : <start-state> : <end-state> :
      % <observation>'
      pat='R\s*:\s*(\S+)\s*:\s*(\S+)\s*:\s*(\S+)\s*:\s*(\S+)\s*';
      [s,f,t]=regexp(string,pat);
      reward=parseNextLine(file,i+1,1,1);
    end
    
    action=expandAction(POMDPData,string(t{1}(1,1):t{1}(1,2)));
    from=expandState(POMDPData,string(t{1}(2,1):t{1}(2,2)));
    to=expandState(POMDPData,string(t{1}(3,1):t{1}(3,2)));
    observation=expandObservation(POMDPData,string(t{1}(4,1):t{1}(4,2)));
    
    if length(observation)~=POMDPData.nObs
      error('Reward should be independent of the observation');
    end  
    if length(from)~=POMDPData.nStates
      error('Reward should be independent of the departing state');
    end

    for i=1:size(action,1)
      POMDPData.R{action(i)}(to)=reward; 
    end
  else
    error('Not yet implemented.');
  end

  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function values = parseNextLine(file, i, nrCols, nrRows)
  if strmatch('uniform',file{i})
    values=ones(nrRows,nrCols)/nrCols;
  elseif strmatch('identity',file{i})
    values=eye(nrCols);
  else
    [s,f,t]=regexp(file{i},'([-\d\.]+)');
    [foo,d]=size(t);
    if d~=nrCols
      error(['Not the correct number of probabilities on the next ' ...
          'line.']);
    end
    % check whether this is just a single line of numbers or a full
    % matrix
    if i<length(file)
      numbers=sscanf(file{i+1},'%f');
    else
      numbers=[];
    end
    if any(size(numbers)==0)
      values=zeros(1,d);
      string=file{i};
      for j=1:d
        values(j)=str2double(string(t{j}(1):t{j}(2)));
      end
    else
      % find out how many lines
      i1=i;
      numbers=sscanf(file{i1+1},'%f');
      running=1;
      while running
        numbers=sscanf(file{i1+1},'%f');
        if any(size(numbers)~=0)
          i1=i1+1;
        else
          running=0;
        end
      end
      values=zeros(i1+1-i,d);
      % parse them all
      for k=i:i1
        [s,f,t]=regexp(file{k},'([-\d\.]+)');
        string=file{k};
        for j=1:d
          values(k+1-i,j)=str2double(string(t{j}(1):t{j}(2)));
        end
      end
    end
  end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function r = expandState(POMDPData,c)
  r=expandString(c,POMDPData.nStates,POMDPData.StateNames);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function r = expandAction(POMDPData,c)
  r=expandString(c,POMDPData.nActions,POMDPData.ActionNames);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function r = expandObservation(POMDPData,c)
  r=expandString(c,POMDPData.nObs,POMDPData.ObsNames);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function r = expandString(c,nr,members)
  if strcmp(c,'*')
    r=cumsum(ones(nr,1));
  else
    r=strmatch(c,members,'exact');
    if isempty(r) % apparently c is a numbered state
      r=str2double(c)+1; % Matlab starts at 1, not 0
    end
  end
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%