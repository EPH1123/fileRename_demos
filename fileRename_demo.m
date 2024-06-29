%fileRename_demo.m

%last updated June 2024 by Eric
% github: EPH1123

% Purpose: generate a random list of empty files, then rename them in a
%batch, following a regular expression search or a simple find-replace;

% Number of files is left unchanged & file contents are unchanged;
% The original filenames are saved in workspace variable "originalFilenames"

% This script is part of a series of short code examples with similar
% function, across different languages.

% There are likely several other approaches to accomplish the same goal,
% depending on operating system.


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Assumptions:

% This code operates in the current folder

% This code was tested only on a Linux machine to simplify; beware: some
% file handling methods work differently in Matlab for different
% operating systems and can be different in Octave (the open-source clone of Matlab)

% Possible alternatives:
% It may be possible to use tools from the Matlab file exchange, but we
% assume that isn't allowed here. Some organizations prohibit or discourage
% use of public code for security reasons.


%% sources used
%  -Mathworks help files
%  -No use of chat bot or code generation tools

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%create small text files with names matching the demo search, plus some extra ones
generate_random_named_text_files(20)

warning(['This code will rename all pattern-matched files without confirming!' newline 'Press any key to continue or press ctrl-c to quit.']);
pause;


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

p='.'; %work in this path only (current folder)
cd(p);

fileList=strsplit(ls('*txt'));      
%list all files in folder and convert to a cell array ;
%in unix/linux, this is a "character vector of names separated by tab and space characters."

originalFilenames=fileList; % save original filenames in workspace

assert(iscell(fileList),"expecting cell array");


%uncomment one of these methods to search & replace in all file names
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% method 1:

% %regular expression search  
% %update any filenames fitting this RE_pattern
% RE_pattern  ='(.*[Bb]ob.*)\.txt'; % any .txt file containing this name
% new_pattern='Alice_new_$1.txt';   % add a new string on the front of each matching file name
% 
% %loop over files in directory & rename; 
% for j=1:numel(fileList)
% 	fname=fileList{j};
% 
% 	%recheck that file exists to avoid error
% 	if exist(fname,'file')>0
% 		new_fileName = regexprep(fname,RE_pattern ,new_pattern);
% 		  if ~strcmp (new_fileName , fname) % replace if name changed
% 			movefile(fname,new_fileName,'f');  %'f'= force / no user confirmation
% 		  end
% 	end
% end


% %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % method 2:

%simple find-replace  
%replace old_string with new_string in all file names
old_string ='abc';
new_string ='xyz';

%loop over files in directory & rename; 
for j=1:numel(fileList)
 	fname=fileList{j};
	
	%recheck that file exists to avoid error
	if exist(fname,'file')>0
		new_fileName = strrep(fname,old_string ,new_string);
		if ~strcmp (new_fileName , fname)     % replace if name changed
			movefile(fname,new_fileName,'f'); %'f'= force / no user confirmation
		end
	end
end





%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%support function
%generate text files with random names in the current directory;
%ensure some filenames fit the patterns searched here, for demonstration purposes
function generate_random_named_text_files(file_count1)
	%file_count1: min number of files to create
	
	%check input & set default if needed
	if nargin==0 || isempty(file_count1) || ~isnumeric(file_count1)
		file_count1=20;
	end
	file_count1=abs(floor(file_count1(1)));

    assert(file_count1<=flintmax);  %sanity check to avoid issues!
	
	%generate fully random file names
	for x=1:file_count1
		s=randsample(['a':'z','0':'9'],15);  %random 15-character filename
		fid=fopen([s '.txt'],'w');
		fprintf(fid,'%s',"file contents");
		fclose(fid);
	end

	%ensure these filenames will fit the patterns searched here, for demonstration purposes; use same file count
	for x=randsample(1:1000,file_count1,false)    %pick a random integer label for each file, no repeats
		fid=fopen(['abc_' num2str(x) '_Bob.txt'],'w');
		fprintf(fid,'%s',"file contents");
		fclose(fid);
	end
	
end