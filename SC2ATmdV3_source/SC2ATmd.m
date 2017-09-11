function varargout = SC2ATmd(varargin)
% SC2ATMD M-file for SC2ATmd.fig
%      SC2ATMD, by itself, creates a new SC2ATMD or raises the existing
%      singleton*.
%
%      H = SC2ATMD returns the handle to a new SC2ATMD or the handle to
%      the existing singleton*.
%
%      SC2ATMD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SC2ATMD.M with the given input arguments.
%
%      SC2ATMD('Property','Value',...) creates a new SC2ATMD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SCCATmd_V2_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SC2ATmd_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
%
%   Author: Amy Olex
%
%
%   ************
%   Copyright (C) 2007 Amy Olex
%   
%   This file is part of SC2ATmd.
%
%   SC2ATmd is free software: you can redistribute it and/or modify
%   it under the terms of the GNU General Public License as published by
%   the Free Software Foundation, either version 3 of the License, or
%   (at your option) any later version.
%
%   SC2ATmd is distributed in the hope that it will be useful,
%   but WITHOUT ANY WARRANTY; without even the implied warranty of
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%   GNU General Public License for more details.
%
%   You should have received a copy of the GNU General Public License
%   along with SC2ATmd.  If not, see <http://www.gnu.org/licenses/>.
%   ************

% Edit the above text to modify the response to help SC2ATmd

% Last Modified by GUIDE v2.5 09-Nov-2011 15:57:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SC2ATmd_OpeningFcn, ...
                   'gui_OutputFcn',  @SC2ATmd_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before SC2ATmd is made visible.
function SC2ATmd_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SC2ATmd (see VARARGIN)

% Choose default command line output for SC2ATmd
handles.output = hObject;

% add needed variables
handles.maxfiles = 8;
handles.filecounter = 1;
handles.filestruct = struct([]);
handles.consensus_datastruct = struct([]);

handles.startDir = cd;
handles.lastDir = cd;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SC2ATmd wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SC2ATmd_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;





% ----------------- Tab Buttons ------------------------- %



% --- Executes on button press in tab_fileinfo.
function tab_fileinfo_Callback(hObject, eventdata, handles)
% hObject    handle to tab_fileinfo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tab_fileinfo

try
    
    % references handles.panel_fileinfo

    state = get(hObject, 'Value');
    
    switch state
        case 0,
           % we only want to know if the state is 0 because that means it is being
           % turned on, so we want to turn everything else off and make this panel
           % visible.
           
           
           % reset the status text box
            set(handles.text_jobstatustext, 'String', '');
    
           set(handles.tab_fileinfo, 'BackgroundColor', [1 .502 0], 'FontWeight', 'bold');
           set(handles.panel_fileinfo, 'Visible', 'on');

           % turn other things off
           set(handles.tab_fom, 'Value', 1, 'BackgroundColor', [.925 .914 .847], 'FontWeight', 'normal');
           set(handles.panel_fom, 'Visible', 'off');

           set(handles.tab_stdclust, 'Value', 1, 'BackgroundColor', [.925 .914 .847], 'FontWeight', 'normal');
           set(handles.panel_stdclust, 'Visible', 'off');

           set(handles.tab_stats, 'Value', 1, 'BackgroundColor', [.925 .914 .847], 'FontWeight', 'normal');
           set(handles.panel_stats, 'Visible', 'off');

           set(handles.tab_mapping, 'Value', 1, 'BackgroundColor', [.925 .914 .847], 'FontWeight', 'normal');
           set(handles.panel_mapping, 'Visible', 'off');
           
           set(handles.tab_consensus, 'Value', 1, 'BackgroundColor', [.925 .914 .847], 'FontWeight', 'normal');
           set(handles.panel_consensus, 'Visible', 'off');
           % add others here as I create them 

        case 1,
            set(hObject, 'Value', 0);
    end

catch
        set(handles.text_jobstatustext, 'String', ...
            'There was an unforseen Matlab error. See errorlog.txt file for description.',...
            'ForegroundColor','red');
        guidata(hObject, handles); 
        
        lasterr
        fid = fopen('errorlog.txt', 'w');
        fprintf(fid, '%s', lasterr);
        fclose(fid);   
end


% --- Executes on button press in tab_fom.
function tab_fom_Callback(hObject, eventdata, handles)
% hObject    handle to tab_fom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tab_fom

try
    
    % references panel_fom

    state = get(hObject, 'Value');

    switch state
        case 0,
           % we only want to know if the state is 0 because that means it is being
           % turned on, so we want to turn everything else off and make this panel
           % visible.
           
           
            % reset the status text box
            set(handles.text_jobstatustext, 'String', '');
    
           set(handles.tab_fom, 'BackgroundColor', [1 .502 0], 'FontWeight', 'bold');
           set(handles.panel_fom, 'Visible', 'on');

           % turn other things off
           set(handles.tab_fileinfo, 'Value', 1, 'BackgroundColor', [.925 .914 .847], 'FontWeight', 'normal');
           set(handles.panel_fileinfo, 'Visible', 'off');

           set(handles.tab_stdclust, 'Value', 1, 'BackgroundColor', [.925 .914 .847], 'FontWeight', 'normal');
           set(handles.panel_stdclust, 'Visible', 'off');

           set(handles.tab_stats, 'Value', 1, 'BackgroundColor', [.925 .914 .847], 'FontWeight', 'normal');
           set(handles.panel_stats, 'Visible', 'off');

           set(handles.tab_mapping, 'Value', 1, 'BackgroundColor', [.925 .914 .847], 'FontWeight', 'normal');
           set(handles.panel_mapping, 'Visible', 'off');
           
           set(handles.tab_consensus, 'Value', 1, 'BackgroundColor', [.925 .914 .847], 'FontWeight', 'normal');
           set(handles.panel_consensus, 'Visible', 'off');
           % add others here as I create them 

        case 1,
            set(hObject, 'Value', 0);
    end

catch
        set(handles.text_jobstatustext, 'String', ...
            'There was an unforseen Matlab error. See errorlog.txt file for description.',...
            'ForegroundColor','red');
        guidata(hObject, handles); 
        
        lasterr
        fid = fopen('errorlog.txt', 'w');
        fprintf(fid, '%s', lasterr);
        fclose(fid);   
end

% --- Executes on button press in tab_stdclust.
function tab_stdclust_Callback(hObject, eventdata, handles)
% hObject    handle to tab_stdclust (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tab_stdclust

try
    
    % references panel_stdclust

    state = get(hObject, 'Value');

    switch state
        case 0,
           % we only want to know if the state is 0 because that means it is being
           % turned on, so we want to turn everything else off and make this panel
           % visible.
           
           
            % reset the status text box
            set(handles.text_jobstatustext, 'String', '');
    
           set(handles.tab_stdclust, 'BackgroundColor', [1 .502 0], 'FontWeight', 'bold');
           set(handles.panel_stdclust, 'Visible', 'on');

           % turn other things off
           set(handles.tab_fileinfo, 'Value', 1, 'BackgroundColor', [.925 .914 .847], 'FontWeight', 'normal');
           set(handles.panel_fileinfo, 'Visible', 'off');

           set(handles.tab_fom, 'Value', 1, 'BackgroundColor', [.925 .914 .847], 'FontWeight', 'normal');
           set(handles.panel_fom, 'Visible', 'off');

           set(handles.tab_stats, 'Value', 1, 'BackgroundColor', [.925 .914 .847], 'FontWeight', 'normal');
           set(handles.panel_stats, 'Visible', 'off');       

           set(handles.tab_mapping, 'Value', 1, 'BackgroundColor', [.925 .914 .847], 'FontWeight', 'normal');
           set(handles.panel_mapping, 'Visible', 'off');  
           
           set(handles.tab_consensus, 'Value', 1, 'BackgroundColor', [.925 .914 .847], 'FontWeight', 'normal');
           set(handles.panel_consensus, 'Visible', 'off');

           % add others here as I create them 

        case 1,
            set(hObject, 'Value', 0);
    end

catch
        set(handles.text_jobstatustext, 'String', ...
            'There was an unforseen Matlab error. See errorlog.txt file for description.',...
            'ForegroundColor','red');
        guidata(hObject, handles); 
        
        lasterr
        fid = fopen('errorlog.txt', 'w');
        fprintf(fid, '%s', lasterr);
        fclose(fid);   
end


% --- Executes on button press in tab_consensus.
function tab_consensus_Callback(hObject, eventdata, handles)
% hObject    handle to tab_consensus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tab_consensus

try
    
    % references panel_stdclust

    state = get(hObject, 'Value');

    switch state
        case 0,
           % we only want to know if the state is 0 because that means it is being
           % turned on, so we want to turn everything else off and make this panel
           % visible.
                      
            % reset the status text box
            set(handles.text_jobstatustext, 'String', '');
    
           set(handles.tab_consensus, 'BackgroundColor', [1 .502 0], 'FontWeight', 'bold');
           set(handles.panel_consensus, 'Visible', 'on');

           % turn other things off
           set(handles.tab_fileinfo, 'Value', 1, 'BackgroundColor', [.925 .914 .847], 'FontWeight', 'normal');
           set(handles.panel_fileinfo, 'Visible', 'off');

           set(handles.tab_fom, 'Value', 1, 'BackgroundColor', [.925 .914 .847], 'FontWeight', 'normal');
           set(handles.panel_fom, 'Visible', 'off');

           set(handles.tab_stats, 'Value', 1, 'BackgroundColor', [.925 .914 .847], 'FontWeight', 'normal');
           set(handles.panel_stats, 'Visible', 'off');       

           set(handles.tab_mapping, 'Value', 1, 'BackgroundColor', [.925 .914 .847], 'FontWeight', 'normal');
           set(handles.panel_mapping, 'Visible', 'off');  
           
           set(handles.tab_stdclust, 'Value', 1, 'BackgroundColor', [.925 .914 .847], 'FontWeight', 'normal');
           set(handles.panel_stdclust, 'Visible', 'off');

           % add others here as I create them 

        case 1,
            set(hObject, 'Value', 0);
    end

catch
        set(handles.text_jobstatustext, 'String', ...
            'There was an unforseen Matlab error. See errorlog.txt file for description.',...
            'ForegroundColor','red');
        guidata(hObject, handles); 
        
        lasterr
        fid = fopen('errorlog.txt', 'w');
        fprintf(fid, '%s', lasterr);
        fclose(fid);   
end


% --- Executes on button press in tab_stats.
function tab_stats_Callback(hObject, eventdata, handles)
% hObject    handle to tab_stats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tab_stats

try
    % references panel_stats

    state = get(hObject, 'Value');

    switch state
        case 0,
           % we only want to know if the state is 0 because that means it is being
           % turned on, so we want to turn everything else off and make this panel
           % visible.
           
            % reset the status text box
            set(handles.text_jobstatustext, 'String', '');
    
           set(handles.tab_stats, 'BackgroundColor', [1 .502 0], 'FontWeight', 'bold');
           set(handles.panel_stats, 'Visible', 'on');

           % turn other things off
           set(handles.tab_fileinfo, 'Value', 1, 'BackgroundColor', [.925 .914 .847], 'FontWeight', 'normal');
           set(handles.panel_fileinfo, 'Visible', 'off');

           set(handles.tab_fom, 'Value', 1, 'BackgroundColor', [.925 .914 .847], 'FontWeight', 'normal');
           set(handles.panel_fom, 'Visible', 'off');

           set(handles.tab_stdclust, 'Value', 1, 'BackgroundColor', [.925 .914 .847], 'FontWeight', 'normal');
           set(handles.panel_stdclust, 'Visible', 'off');       

           set(handles.tab_mapping, 'Value', 1, 'BackgroundColor', [.925 .914 .847], 'FontWeight', 'normal');
           set(handles.panel_mapping, 'Visible', 'off');  
           
           set(handles.tab_consensus, 'Value', 1, 'BackgroundColor', [.925 .914 .847], 'FontWeight', 'normal');
           set(handles.panel_consensus, 'Visible', 'off');


           % add others here as I create them 

        case 1,
            set(hObject, 'Value', 0);
    end

catch
        set(handles.text_jobstatustext, 'String', ...
            'There was an unforseen Matlab error. See errorlog.txt file for description.',...
            'ForegroundColor','red');
        guidata(hObject, handles); 
        
        lasterr
        fid = fopen('errorlog.txt', 'w');
        fprintf(fid, '%s', lasterr);
        fclose(fid);   
end

% --- Executes on button press in tab_mapping.
function tab_mapping_Callback(hObject, eventdata, handles)
% hObject    handle to tab_mapping (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tab_mapping

try
    
    % references panel_mapping

    state = get(hObject, 'Value');

    switch state
        case 0,
           % we only want to know if the state is 0 because that means it is being
           % turned on, so we want to turn everything else off and make this panel
           % visible.
           
            % reset the status text box
            set(handles.text_jobstatustext, 'String', '');
    
           set(handles.tab_mapping, 'BackgroundColor', [1 .502 0], 'FontWeight', 'bold');
           set(handles.panel_mapping, 'Visible', 'on');

           % turn other things off
           set(handles.tab_fileinfo, 'Value', 1, 'BackgroundColor', [.925 .914 .847], 'FontWeight', 'normal');
           set(handles.panel_fileinfo, 'Visible', 'off');

           set(handles.tab_fom, 'Value', 1, 'BackgroundColor', [.925 .914 .847], 'FontWeight', 'normal');
           set(handles.panel_fom, 'Visible', 'off');

           set(handles.tab_stdclust, 'Value', 1, 'BackgroundColor', [.925 .914 .847], 'FontWeight', 'normal');
           set(handles.panel_stdclust, 'Visible', 'off');       

           set(handles.tab_stats, 'Value', 1, 'BackgroundColor', [.925 .914 .847], 'FontWeight', 'normal');
           set(handles.panel_stats, 'Visible', 'off');
           
           set(handles.tab_consensus, 'Value', 1, 'BackgroundColor', [.925 .914 .847], 'FontWeight', 'normal');
           set(handles.panel_consensus, 'Visible', 'off');
           % add others here as I create them 

        case 1,
            set(hObject, 'Value', 0);
    end

catch
        set(handles.text_jobstatustext, 'String', ...
            'There was an unforseen Matlab error. See errorlog.txt file for description.',...
            'ForegroundColor','red');
        guidata(hObject, handles); 
        
        lasterr
        fid = fopen('errorlog.txt', 'w');
        fprintf(fid, '%s', lasterr);
        fclose(fid);   
end


% --- Executes on button press in handles.
function handles_Callback(hObject, eventdata, handles)
% hObject    handle to handles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles




% --------------- Menu Bar --------------------------- %

% --------------------------------------------------------------------
function loaddata_Callback(hObject, eventdata, handles)
% hObject    handle to loaddata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function fomcluster_Callback(hObject, eventdata, handles)
% hObject    handle to fomcluster (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    
    % reset the status text box
    set(handles.text_jobstatustext, 'String', '');

    
    
    if handles.filecounter <= handles.maxfiles
        % change the directory to the last accessed
        cd(handles.lastDir);
        
        [fname pname] = uigetfile('*.txt', 'Load Data File');
       
       % change back to starting directory
        cd(handles.startDir);
       
       
       if isequal(fname,0) || isequal(pname,0)
            set(handles.text_jobstatustext, 'String', 'Data import canceled.', ...
                'ForegroundColor', 'red');
            guidata(hObject, handles);
            return;
       end

        %create a structure with index filecounter, and update the filename 
        %and filepath fields in the structure
        handles.filestruct(handles.filecounter).filename = fname;
        handles.filestruct(handles.filecounter).filepath = pname;

        fullname = strcat(pname, fname);
        S = uiimport(fullname);

        %check to see if the import was canceled
        if isequal(S,[])
            set(handles.text_jobstatustext, 'String', 'Data import canceled.', ...
                'ForegroundColor', 'red');
            guidata(hObject, handles);
            return;
        end
        
        % update the last directory accessed
        handles.lastDir = pname;
        
        handles.filestruct(handles.filecounter).data = S.data;

        numtextrows = length(S.textdata(:,1));
        numtextcolumns = length(S.textdata(1,:));

        handles.filestruct(handles.filecounter).rowlabels = S.textdata(2:numtextrows,1);
        handles.filestruct(handles.filecounter).colheader = S.textdata(1,2:numtextcolumns);
        datasize = size(S.data);
        handles.filestruct(handles.filecounter).numdatarow = num2str(datasize(1));
        handles.filestruct(handles.filecounter).numdatacol = num2str(datasize(2));
        handles.filestruct(handles.filecounter).filetype = 'FOM/Clustering';

        % update file info window
        set(handles.fileinfo_text_filename,'String', ...
            strvcat(handles.filestruct(1:handles.filecounter).filename));
        set(handles.fileinfo_text_filepath,'String', ...
            strvcat(handles.filestruct(1:handles.filecounter).filepath));
        set(handles.fileinfo_text_numrows, 'String', ...
            strvcat(handles.filestruct(1:handles.filecounter).numdatarow));
        set(handles.fileinfo_text_numcol, 'String', ...
            strvcat(handles.filestruct(1:handles.filecounter).numdatacol));
        set(handles.fileinfo_text_filetype, 'String', ...
            strvcat(handles.filestruct(1:handles.filecounter).filetype));
        
        % update other dynamic file selection menus
        set(handles.fom_popup_inputfile,'String', ...
        strvcat(handles.filestruct(1:handles.filecounter).filename), 'Value', 1.0);
        set(handles.stdclust_popup_inputfile,'String', ...
        strvcat(handles.filestruct(1:handles.filecounter).filename), 'Value', 1.0);
        set(handles.stats_popup_inputfile,'String', ...
        strvcat(handles.filestruct(1:handles.filecounter).filename), 'Value', 1.0);    
        set(handles.mapping_popup_inputfile,'String', ...
        strvcat(handles.filestruct(1:handles.filecounter).filename), 'Value', 1.0);
        % every time files are added or deleted, reset the heatmapdata
        % listbox to none.
        set(handles.consensus_listbox_heatmapdata,'String', 'none', 'Value', 1.0);
        set(handles.consensus_listbox_inputfile,'String', ...
        strvcat(handles.filestruct(1:handles.filecounter).filename), 'Value', 1.0);
        
        
        handles.filecounter = handles.filecounter+1;
        set(handles.text_jobstatustext, 'String', 'File loaded successfully.',...
            'ForegroundColor','blue');
        guidata(hObject, handles); 

    else
        set(handles.text_jobstatustext, 'String', ...
            'Only 8 files may be loaded at one time.','ForegroundColor','red');
        guidata(hObject, handles); 
    end
    
catch
        set(handles.text_jobstatustext, 'String', ...
            'There was an unforseen Matlab error. See errorlog.txt file for description.',...
            'ForegroundColor','red');
        guidata(hObject, handles); 
        
        lasterr
        fid = fopen('errorlog.txt', 'w');
        fprintf(fid, '%s', lasterr);
        fclose(fid);
end

% --------------------------------------------------------------------
function heatstats_Callback(hObject, eventdata, handles)
% hObject    handle to heatstats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    
    % reset the status text box
    set(handles.text_jobstatustext, 'String', '');
    
    if handles.filecounter <= handles.maxfiles
        % change the directory to the last accessed
        cd(handles.lastDir);
        
       [fname pname] = uigetfile('*.txt', 'Load Data File');
        
       % change back to starting directory
        cd(handles.startDir);
       
        % check to see if cancel was pressed
       if isequal(fname,0) || isequal(pname,0)
            set(handles.text_jobstatustext, 'String', 'Data import canceled.', ...
                'ForegroundColor', 'red');
            guidata(hObject, handles); 
            return;
       end

       %create a structure with index filecounter, and update the filename
        %and filepath fields in the structure
        handles.filestruct(handles.filecounter).filename = fname;
        handles.filestruct(handles.filecounter).filepath = pname;

        fullname = strcat(pname, fname);
        S = uiimport(fullname);

        %check to see if the import was canceled
        if isequal(S,[])
            set(handles.text_jobstatustext, 'String', 'Data import canceled.', ...
                'ForegroundColor', 'red');
            guidata(hObject, handles);
            return;
        end
        
        %update the last directory accessed
        handles.lastDir = pname;
    
        handles.filestruct(handles.filecounter).data = S.data;

        numtextrows = length(S.textdata(:,1));
        numtextcolumns = length(S.textdata(1,:));
        
        handles.filestruct(handles.filecounter).rowlabels = S.textdata(2:numtextrows,1);
        handles.filestruct(handles.filecounter).colheader = S.textdata(1,3:numtextcolumns);
        datasize = size(S.data);
        handles.filestruct(handles.filecounter).numdatarow = num2str(datasize(1));
        handles.filestruct(handles.filecounter).numdatacol = num2str(datasize(2));
        handles.filestruct(handles.filecounter).filetype = 'Heatmap/Stats';

        % update file info window
        set(handles.fileinfo_text_filename,'String', ...
            strvcat(handles.filestruct(1:handles.filecounter).filename));
        set(handles.fileinfo_text_filepath,'String', ...
            strvcat(handles.filestruct(1:handles.filecounter).filepath));
        set(handles.fileinfo_text_numrows, 'String', ...
            strvcat(handles.filestruct(1:handles.filecounter).numdatarow));
        set(handles.fileinfo_text_numcol, 'String', ...
            strvcat(handles.filestruct(1:handles.filecounter).numdatacol));
        set(handles.fileinfo_text_filetype, 'String', ...
            strvcat(handles.filestruct(1:handles.filecounter).filetype));

        % update other dynamic file selection menus
        set(handles.fom_popup_inputfile,'String', ...
        strvcat(handles.filestruct(1:handles.filecounter).filename), 'Value', 1.0);
        set(handles.stdclust_popup_inputfile,'String', ...
        strvcat(handles.filestruct(1:handles.filecounter).filename), 'Value', 1.0);
        set(handles.stats_popup_inputfile,'String', ...
        strvcat(handles.filestruct(1:handles.filecounter).filename), 'Value', 1.0);      
        set(handles.mapping_popup_inputfile,'String', ...
        strvcat(handles.filestruct(1:handles.filecounter).filename), 'Value', 1.0);
        % every time files are added or deleted, reset the heatmapdata
        % listbox to none.
        set(handles.consensus_listbox_heatmapdata,'String', 'none', 'Value', 1.0);
        set(handles.consensus_listbox_inputfile,'String', ...
        strvcat(handles.filestruct(1:handles.filecounter).filename), 'Value', 1.0); 
        
        handles.filecounter = handles.filecounter+1;

        set(handles.text_jobstatustext, 'String', 'File loaded successfully.',...
            'ForegroundColor','blue');
        guidata(hObject, handles); 

    else
        set(handles.text_jobstatustext, 'String', ...
            'Only 8 files may be loaded at one time.','ForegroundColor','red');
        guidata(hObject, handles); 
    end
    
catch
        set(handles.text_jobstatustext, 'String', ...
            'There was an unforseen Matlab error. See errorlog.txt file for description.',...
            'ForegroundColor','red');
        guidata(hObject, handles); 
        
        lasterr
        fid = fopen('errorlog.txt', 'w');
        fprintf(fid, '%s', lasterr);
        fclose(fid);
end


% --------------------------------------------------------------------
function clustermap_Callback(hObject, eventdata, handles)
% hObject    handle to clustermap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    
    % reset the status text box
    set(handles.text_jobstatustext, 'String', '');
    
    if handles.filecounter <= handles.maxfiles
       % change the directory to the last accessed
        cd(handles.lastDir);

        [fname pname] = uigetfile('*.txt', 'Load Data File');
       
        % change back to starting directory
        cd(handles.startDir);
       
        % check to see if cancel was pressed
       if isequal(fname,0) || isequal(pname,0)
            set(handles.text_jobstatustext, 'String', 'Data import canceled.', ...
                'ForegroundColor', 'red');
            guidata(hObject, handles); 
            return;
       end

        %create a structure with index filecounter, and update the filename 
        %and filepath fields in the structure
        handles.filestruct(handles.filecounter).filename = fname;
        handles.filestruct(handles.filecounter).filepath = pname;
        
        fullname = strcat(pname, fname);
        S = uiimport(fullname);

        %check to see if the import was canceled
        if isequal(S,[])
            set(handles.text_jobstatustext, 'String', 'Data import canceled.', ...
                'ForegroundColor', 'red');
            guidata(hObject, handles);
            return;
        end
        
        %update the last directory accessed
        handles.lastDir = pname;
        
        handles.filestruct(handles.filecounter).data = S.data;

        numtextrows = length(S.textdata(:,1));
        numtextcolumns = length(S.textdata(1,:));
        
        handles.filestruct(handles.filecounter).rowlabels = S.textdata(2:numtextrows,1);
        handles.filestruct(handles.filecounter).colheader = S.textdata(1,2:numtextcolumns);
        datasize = size(S.data);
        handles.filestruct(handles.filecounter).numdatarow = num2str(datasize(1));
        handles.filestruct(handles.filecounter).numdatacol = num2str(datasize(2));
        handles.filestruct(handles.filecounter).filetype = 'ClusterMapping';

        % update file infor window
        set(handles.fileinfo_text_filename,'String', ...
            strvcat(handles.filestruct(1:handles.filecounter).filename));
        set(handles.fileinfo_text_filepath,'String', ...
            strvcat(handles.filestruct(1:handles.filecounter).filepath));
        set(handles.fileinfo_text_numrows,'String', ...
            strvcat(handles.filestruct(1:handles.filecounter).numdatarow));
        set(handles.fileinfo_text_numcol, 'String', ...
            strvcat(handles.filestruct(1:handles.filecounter).numdatacol));
        set(handles.fileinfo_text_filetype, 'String', ...
            strvcat(handles.filestruct(1:handles.filecounter).filetype));

        % update other dynamic file selection menus
        set(handles.fom_popup_inputfile,'String', ...
        strvcat(handles.filestruct(1:handles.filecounter).filename), 'Value', 1.0);
        set(handles.stdclust_popup_inputfile,'String', ...
        strvcat(handles.filestruct(1:handles.filecounter).filename), 'Value', 1.0);
        set(handles.stats_popup_inputfile,'String', ...
        strvcat(handles.filestruct(1:handles.filecounter).filename), 'Value', 1.0);      
        set(handles.mapping_popup_inputfile,'String', ...
        strvcat(handles.filestruct(1:handles.filecounter).filename), 'Value', 1.0);
        % every time files are added or deleted, reset the heatmapdata
        % listbox to none.
        set(handles.consensus_listbox_heatmapdata,'String', 'none', 'Value', 1.0);
        set(handles.consensus_listbox_inputfile,'String', ...
        strvcat(handles.filestruct(1:handles.filecounter).filename), 'Value', 1.0);    
        
        handles.filecounter = handles.filecounter+1;

        set(handles.text_jobstatustext, 'String', 'File loaded successfully.',...
            'ForegroundColor','blue');
        guidata(hObject, handles); 

    else
        set(handles.text_jobstatustext, 'String',...
            'Only 8 files may be loaded at one time.','ForegroundColor','red');
        guidata(hObject, handles); 
    end
    
catch
        set(handles.text_jobstatustext, 'String',...
            'There was an unforseen Matlab error. See errorlog.txt file for description.',...
            'ForegroundColor','red');
        guidata(hObject, handles); 
        
        lasterr
        fid = fopen('errorlog.txt', 'w');
        fprintf(fid, '%s', lasterr);
        fclose(fid);
end








% -------------------- File Info Tab ------------------------------%




% --- Executes on selection change in fileinfo_popup_delete.
function fileinfo_popup_delete_Callback(hObject, eventdata, handles)
% hObject    handle to fileinfo_popup_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns fileinfo_popup_delete contents as cell array
%        contents{get(hObject,'Value')} returns selected item from fileinfo_popup_delete

% Contents retrieved under Delete pushbutton

% --- Executes during object creation, after setting all properties.
function fileinfo_popup_delete_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fileinfo_popup_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in fileinfo_button_delete.
function fileinfo_button_delete_Callback(hObject, eventdata, handles)
% hObject    handle to fileinfo_button_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% reset the status text box
set(handles.text_jobstatustext, 'String', '');
    
%in order to get the right file index to delete we will get the numerical
%Value field for the selection, the subtract 1.  This is because the 'none'
%selection occupies field 1, and the '1' selection occupies field 2.
deletefile = get(handles.fileinfo_popup_delete, 'Value') - 1;

% now we want to check to make sure the selected index is in the right
% range.  If not, out put an appropriate error message.

try

    if deletefile > 0 && deletefile < handles.filecounter
       handles.filestruct(deletefile) = []; 

        % decrement filecounter
        handles.filecounter = handles.filecounter-1;
         guidata(hObject, handles);
         pause(1);
           % update tabpanel info
        set(handles.fileinfo_text_filename,'String', ...
            strvcat(handles.filestruct(1:handles.filecounter-1).filename));
        set(handles.fileinfo_text_filepath,'String', ...
            strvcat(handles.filestruct(1:handles.filecounter-1).filepath));
        set(handles.fileinfo_text_numrows,'String', ...
            strvcat(handles.filestruct(1:handles.filecounter-1).numdatarow));
        set(handles.fileinfo_text_numcol, 'String', ...
            strvcat(handles.filestruct(1:handles.filecounter-1).numdatacol));
        set(handles.fileinfo_text_filetype, 'String', ...
            strvcat(handles.filestruct(1:handles.filecounter-1).filetype));

        num_files_left = length(handles.filestruct);
        
        if num_files_left > 0
            
            % update other dynamic file selection menus
            set(handles.fom_popup_inputfile,'String', ...
                strvcat(handles.filestruct(1:handles.filecounter-1).filename), 'Value', 1.0);
            set(handles.stdclust_popup_inputfile,'String', ...
                strvcat(handles.filestruct(1:handles.filecounter-1).filename), 'Value', 1.0);
            set(handles.stats_popup_inputfile,'String', ...
                strvcat(handles.filestruct(1:handles.filecounter-1).filename), 'Value', 1.0);      
            set(handles.mapping_popup_inputfile,'String', ...
                strvcat(handles.filestruct(1:handles.filecounter-1).filename), 'Value', 1.0);
            % every time files are added or deleted, reset the heatmapdata
            % listbox to none.
            set(handles.consensus_listbox_heatmapdata,'String', 'none', 'Value', 1.0);
            set(handles.consensus_listbox_inputfile,'String', ...
                strvcat(handles.filestruct(1:handles.filecounter-1).filename), 'Value', 1.0);
        else
            % set other dynamic file selection menus to None
            set(handles.fom_popup_inputfile,'String', 'none', 'Value', 1.0);
            set(handles.stdclust_popup_inputfile,'String', 'none', 'Value', 1.0);
            set(handles.stats_popup_inputfile,'String', 'none', 'Value', 1.0);      
            set(handles.mapping_popup_inputfile,'String', 'none', 'Value', 1.0);
            set(handles.consensus_listbox_inputfile,'String', 'none', 'Value', 1.0);
            set(handles.consensus_listbox_heatmapdata,'String', 'none', 'Value', 1.0);
        end
        
       set(handles.text_jobstatustext, 'String', 'File deleted successfully.',...
           'ForegroundColor','blue');
       guidata(hObject, handles); 

    elseif deletefile == 0
        set(handles.text_jobstatustext, 'String', 'No files were deleted.',...
            'ForegroundColor','red');
        guidata(hObject, handles);

    elseif deletefile >= handles.filecounter
        set(handles.text_jobstatustext, 'String', 'File does not exist.',...
            'ForegroundColor','red');
        guidata(hObject, handles);    
    end
catch
        set(handles.text_jobstatustext, 'String', ...
            'There was an unforseen Matlab error. See errorlog.txt file for description.',...
            'ForegroundColor','red');
        guidata(hObject, handles); 
        
        lasterr
        fid = fopen('errorlog.txt', 'w');
        fprintf(fid, '%s', lasterr);
        fclose(fid);
end

% --- Executes on button press in fileinfo_button_deleteall.
function fileinfo_button_deleteall_Callback(hObject, eventdata, handles)
% hObject    handle to fileinfo_button_deleteall (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% reset the status text box
set(handles.text_jobstatustext, 'String', '');
    
try

    ButtonName=questdlg({'WARNING!  All imported data is about to be deleted.', ...
            'Press Ok to continue.'},'Warning', 'Ok','Cancel','Ok');
        switch ButtonName
            case 'Ok',
             handles.filestruct(1:handles.filecounter-1) = [];

        % reset filecounter
            handles.filecounter = 1;
             guidata(hObject, handles);
             pause(1);
               % update tabpanel info
            set(handles.fileinfo_text_filename,'String', '');
            set(handles.fileinfo_text_filepath,'String', '');
            set(handles.fileinfo_text_numrows,'String', '');
            set(handles.fileinfo_text_numcol, 'String', '');
            set(handles.fileinfo_text_filetype, 'String', '');

            % update other dynamic file selection menus
            set(handles.fom_popup_inputfile,'String', 'none', 'Value', 1.0);
            set(handles.stdclust_popup_inputfile,'String', 'none', 'Value', 1.0);
            set(handles.stats_popup_inputfile,'String', 'none', 'Value', 1.0);      
            set(handles.mapping_popup_inputfile,'String', 'none', 'Value', 1.0);
            set(handles.consensus_listbox_inputfile,'String', 'none', 'Value', 1.0);
            set(handles.consensus_listbox_heatmapdata,'String', 'none', 'Value', 1.0);

            set(handles.text_jobstatustext, 'String', 'All file data deleted successfully.',...
                'ForegroundColor','blue');
            guidata(hObject, handles); 
            
            
            case 'Cancel'
                return;
        end
        
catch
        set(handles.text_jobstatustext, 'String', ...
            'There was an unforseen Matlab error. See errorlog.txt file for description.',...
            'ForegroundColor','red');
        guidata(hObject, handles); 
        
        lasterr
        fid = fopen('errorlog.txt', 'w');
        fprintf(fid, '%s', lasterr);
        fclose(fid);
end







% ------------ FOM Tab ------------------------------------% 




% --- Executes on button press in fom_checkbox_hierarch.
function fom_checkbox_hierarch_Callback(hObject, eventdata, handles)
% hObject    handle to fom_checkbox_hierarch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of fom_checkbox_hierarch

% value reterived under Analysis button

% --- Executes on button press in fom_checkbox_kmeans.
function fom_checkbox_kmeans_Callback(hObject, eventdata, handles)
% hObject    handle to fom_checkbox_kmeans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of fom_checkbox_kmeans

% value reterived under Analysis button

% --- Executes on selection change in fom_popup_dismeasure.
function fom_popup_dismeasure_Callback(hObject, eventdata, handles)
% hObject    handle to fom_popup_dismeasure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns fom_popup_dismeasure contents as cell array
%        contents{get(hObject,'Value')} returns selected item from fom_popup_dismeasure

% value reterived under Analysis button

% --- Executes during object creation, after setting all properties.
function fom_popup_dismeasure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fom_popup_dismeasure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in fom_popup_fomtype.
function fom_popup_fomtype_Callback(hObject, eventdata, handles)
% hObject    handle to fom_popup_fomtype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns fom_popup_fomtype contents as cell array
%        contents{get(hObject,'Value')} returns selected item from fom_popup_fomtype

% value reterived under Analysis button

% --- Executes during object creation, after setting all properties.
function fom_popup_fomtype_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fom_popup_fomtype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fom_edit_clustintervals_Callback(hObject, eventdata, handles)
% hObject    handle to fom_edit_clustintervals (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fom_edit_clustintervals as text
%        str2double(get(hObject,'String')) returns contents of fom_edit_clustintervals as a double

% value reterived under Analysis button

% --- Executes during object creation, after setting all properties.
function fom_edit_clustintervals_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fom_edit_clustintervals (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in fom_popup_inputfile.
function fom_popup_inputfile_Callback(hObject, eventdata, handles)
% hObject    handle to fom_popup_inputfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns fom_popup_inputfile contents as cell array
%        contents{get(hObject,'Value')} returns selected item from fom_popup_inputfile

% value reterived under Analysis button

% --- Executes during object creation, after setting all properties.
function fom_popup_inputfile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fom_popup_inputfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fom_edit_savepath_Callback(hObject, eventdata, handles)
% hObject    handle to fom_edit_savepath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fom_edit_savepath as text
%        str2double(get(hObject,'String')) returns contents of fom_edit_savepath as a double

% value reterived under Analysis button
% value set by Browse button

% --- Executes during object creation, after setting all properties.
function fom_edit_savepath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fom_edit_savepath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fom_edit_savefile_Callback(hObject, eventdata, handles)
% hObject    handle to fom_edit_savefile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fom_edit_savefile as text
%        str2double(get(hObject,'String')) returns contents of fom_edit_savefile as a double

% value reterived under Analysis button

% --- Executes during object creation, after setting all properties.
function fom_edit_savefile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fom_edit_savefile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in fom_listbox_fileformats.
function fom_listbox_fileformats_Callback(hObject, eventdata, handles)
% hObject    handle to fom_listbox_fileformats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns fom_listbox_fileformats contents as cell array
%        contents{get(hObject,'Value')} returns selected item from fom_listbox_fileformats


% --- Executes during object creation, after setting all properties.
function fom_listbox_fileformats_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fom_listbox_fileformats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in fom_button_browse.
function fom_button_browse_Callback(hObject, eventdata, handles)
% hObject    handle to fom_button_browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    
    % reset the status text box
    set(handles.text_jobstatustext, 'String', '');
    
    % open directory browser

    % change the directory to the last accessed
    cd(handles.lastDir);

    directory = uigetdir();
    handles.lastDir = directory;
        
    % change back to starting directory
    cd(handles.startDir);
        
    % checked to see if cancel was pressed
    if directory == 0
        set(handles.text_jobstatustext, 'String', 'No directory chosen.', ...
            'ForegroundColor', 'blue');
        guidata(hObject, handles);
        return;
    else
        set(handles.fom_edit_savepath, 'String', strcat(directory, '\'));
        guidata(hObject, handles);
    end

catch
        set(handles.text_jobstatustext, 'String', ...
            'There was an unforseen Matlab error. See errorlog.txt file for description.',...
            'ForegroundColor','red');
        guidata(hObject, handles); 
        
        lasterr
        fid = fopen('errorlog.txt', 'w');
        fprintf(fid, '%s', lasterr);
        fclose(fid);   
end




% --- Executes on button press in fom_button_fomanalysis.
function fom_button_fomanalysis_Callback(hObject, eventdata, handles)
% hObject    handle to fom_button_fomanalysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% When I hit the analysis button it will do the following things:
%       - check to see if chosen file type is correct
%       - import analysis parameters
%       - import saved file information
%       - run the appropriate runFOManalysis method

try

    % reset text_jobstatustext to blank before beginning
    set(handles.text_jobstatustext, 'String', '');
    
        % check to make sure some data files have been loaded into the system.
    if isempty(handles.filestruct)
        set(handles.text_jobstatustext, 'String', 'Error: Must import some data files before any analysis can be done.',...
            'ForegroundColor', 'red');
        return;
    end
    
    % set up and needed variables
    methods = {'random'};
    tmpcounter = 2;
    
% --------- check to see if input file type is correct -------------%

    % on button press get the right file data from the fominputfile popup menu

    dataidx = get(handles.fom_popup_inputfile, 'Value');

    % then check to see if selected file is the right type
    if ~isequal(handles.filestruct(dataidx).filetype, 'FOM/Clustering')
        set(handles.text_jobstatustext, 'String', 'Error: File must be of FOM/Clustering type.',...
            'ForegroundColor','red');
        return;
    end

    % if the above error is displayed, and the file selection is now ok, reset
    % the error message
    if isequal(get(handles.text_jobstatustext, 'String'), ...
            'Error: File must be of FOM/Clustering type.')
        set(handles.text_jobstatustext, 'String', '');
    end

 % ---------------- import analysis parameters ------------------ %
 
    % get cluster methods from check boxes.
    % simply check to see which ones are set to 1, then add the appropriate
    % string to the handles.methods structure to pass to the fom analysis
    % method.  To extend this simply check for more methods by using if
    % else statements, and continue adding on to the end of the methods
    % structure.  The tmpcounter keeps track of the current index, it
    % starts at two because the random clustering method is always first.
    
    methods(1) = {''};
    % check hierarchical
    if (get(handles.fom_checkbox_hierarch, 'Value'))
        methods(tmpcounter) = {'hierarchical'};
        tmpcounter = tmpcounter + 1;
    end
    
    % check kmeans
    if (get(handles.fom_checkbox_kmeans, 'Value'))
        methods(tmpcounter) = {'kmeans'};
        tmpcounter = tmpcounter + 1;
    end
    
    
    % check to see if methods is still empty
    if isempty(methods)
        button = questdlg('If no clustering method is chosen, analysis will be run using only random clustering.',...
            'Warning', 'Ok', 'Cancel', 'Cancel');
    
        switch button
            case 'Cancel',
                return;
        end
    end
    
    % to add more clustering methods, simply add checkboxes to the GUI and
    % insert more if-statements here.
    
    
    
    % now get the selected similarity measure from the pop up menu
    contents = get(handles.fom_popup_dismeasure,...
        'String');  % returns all options as a cell array
    dismeasure = contents{get(handles.fom_popup_dismeasure,...
        'Value')}; % returns to the selected option as a string
    
    % check to make sure a distance measure was chosen
    if isequal(dismeasure, 'None')
        set(handles.text_jobstatustext, 'String', 'Error: Must select a similarity measure.', ...
            'ForegroundColor', 'red');
        return;
    end
    
        
    % now get the selected figure of merit analysis type
    contents = get(handles.fom_popup_fomtype,...
        'String');  % returns all options as a cell array
    fomtype = contents{get(handles.fom_popup_fomtype,...
        'Value')}; % returns to the selected option as a string
    
    % check to make sure a fom type was chosen
    if isequal(fomtype, 'None')
        set(handles.text_jobstatustext, 'String', 'Error: Must select an algorithm type', ...
            'ForegroundColor', 'red');
        return;
    end    
    
    % retrieve the cluster list intervals
    list = [get(handles.fom_edit_clustintervals, 'String')];
    clist = unique(str2num(list));
 
    % check clist for appropriate format and content
    
    if isempty(clist) || count(clist, '<=1') > 0
        set(handles.text_jobstatustext, 'String', 'Error: Cluster intervals must be numbers greater than 1.',...
            'ForegroundColor', 'red');
        return;        
    end
   
    
    
 % ------------------- import save file information ------------- %
 
    % get save path
    savepath = get(handles.fom_edit_savepath, 'String');
    if isempty(savepath)
        ButtonName=questdlg({'No path was entered for the output files, so the input file path will be used.', ...
            'Press Ok to continue or Cancel to enter a new path.'},'Warning', 'Ok','Cancel','Ok');
        switch ButtonName
            case 'Ok',
                savepath = handles.filestruct(dataidx).filepath;
            case 'Cancel'
                set(handles.text_jobstatustext, 'String', 'Re-enter save file path.',...
                    'ForegroundColor','blue');
                return;
        end
    elseif exist(savepath, 'dir') == 0
        set(handles.text_jobstatustext, 'String', 'Error: Destination path cannot be found.',...
            'ForegroundColor','red');
        return;   
    end
    
    % get the save file name
    savename = get(handles.fom_edit_savefile, 'String');
    if isempty(savename)
        set(handles.text_jobstatustext, 'String', 'Error: Must enter a file identifier',...
            'ForegroundColor', 'red');
        return;
    elseif exist(strcat(savepath, savename, '.txt'), 'file') > 0
        buttonvalue = questdlg(strcat(savename, ' analysis files already exists.  Would you like to overwrite them?'),...
            'Warning', 'Ok', 'Cancel', 'Ok');

        switch buttonvalue
            case 'Cancel',
                return;
        end           
    end 
 
 
    
 % ---------------- get file format types ----------------------------- %
 
 % in order to do this I need to switch the string values in the list with
 % just the extensions, and make a cell array with just the extensions.
 % Since the .fig files are always saved I can start the array with that.
 % Then I need to figure out how many other sepection there were and add
 % them on the end.
 
 % initilize the fileformat array
 
 fileformats = {'fig'};
 
 % get the data from the list box
 
 list_contents = get(handles.fom_listbox_fileformats, 'String');
 
 % get the selections array
 
 list_selections = get(handles.fom_listbox_fileformats, 'Value');
 
% figure out how many selections were made

[d, num_selections] = size(list_selections);

% check to see if the None selection was chosen.   If so, this overides all
% other selections

if num_selections > 1 && list_selections(1) == 1
    buttonvalue = questdlg({'The None file format selection will override all other selections, and only the .fig file will be saved.', ...
        'Is this ok?  Press Cancel to change your selections.'}, 'Warning', 'Ok', 'Cancel', 'Ok');
    
    switch buttonvalue
        case 'Cancel',
            return;
    end
    
    % add to the fileformats array if the first selection is not None
elseif num_selections > 0 && list_selections(1) ~= 1
    
    for i=1:num_selections
        format = list_selections(i);
        
        switch format
            case 2,
                fileformats(length(fileformats)+1) = {'jpg'};
            case 3,
                fileformats(length(fileformats)+1) = {'bmp'};
            case 4,
                fileformats(length(fileformats)+1) = {'eps'};
            case 5,
                fileformats(length(fileformats)+1) = {'tif'};
            case 6,
                fileformats(length(fileformats)+1) = {'pdf'};
            case 7,
                fileformats(length(fileformats)+1) = {'ai'};
        end
    end
  
end
    
    
 % ------------------ run figure of merit analysis ----------------- %
    
    %  check to see which figure of merit analysis type was selected
   
    switch fomtype
        case 'Original FOM',
            switch dismeasure                    
                case 'Pearsons Correlation',
                    ButtonName=questdlg({'It is advised that Euclidean distance be used with the original figure of merit.',...
                        'Would you like to change your selection?  Press Continue to use Pearsons.'},...
                        'Warning','Change to Euclidean','Continue','Cancel','Change to Euclidean');
                    switch ButtonName
                        case 'Change to Euclidean',
                            dismeasure = 'Euclidean Distance';
                            set(handles.fom_popup_dismeasure, 'Value', 2);
                        case 'Cancel'
                            return;
                    end  % end switch button name
            end % end switch dismeasure
            
            % now run the original FOM
            set(handles.text_jobstatustext, 'String', {'FOM analysis is being generated.';...
                'Please Wait . . . .'}, 'ForegroundColor', 'blue');
                pause(1);
            runFOManalysis(clist, handles.filestruct(dataidx).data, methods, ...
                dismeasure, savename, savepath, fileformats);
            set(handles.text_jobstatustext, 'String', 'FOM analysis completed.', ...
                'ForegroundColor', 'blue');
                pause(1);
            
        case 'Correlation-biased cFOM',
            switch dismeasure                    
            case 'Euclidean Distance',
                ButtonName=questdlg({'It is advised that Pearsons Correlation be used with the correlation-biased figure of merit.', ...
                    'Would you like to change your selection?  Press Continue to use Euclidean.'},...
                    'Warning','Change to Pearsons','Continue','Cancel','Change to Pearsons');
                switch ButtonName
                    case 'Change to Pearsons',
                        dismeasure = 'Pearsons Correlation';
                        set(handles.fom_popup_dismeasure, 'Value', 3);
                    case 'Cancel'
                        return;
                end  % end switch button name
            end % end switch dismeasure
    
            % now run the correlation-biased FOM
            set(handles.text_jobstatustext, 'String', {'cFOM analysis is being generated.'; ...
                'Please Wait . . . .'}, 'ForegroundColor', 'blue');
                pause(1);
            runFOMcorrAnalysis(clist, handles.filestruct(dataidx).data, methods, ...
                dismeasure, savename, savepath, fileformats);
            set(handles.text_jobstatustext, 'String', 'cFOM analysis completed.',...
                'ForegroundColor', 'blue');
                pause(1);
    end  % end switch fom type
    
catch
        set(handles.text_jobstatustext, 'String', ...
            'There was an unforseen Matlab error. See errorlog.txt file for description.',...
            'ForegroundColor','red');
        guidata(hObject, handles); 
        
        lasterr
        fid = fopen('errorlog.txt', 'w');
        fprintf(fid, '%s', lasterr);
        fclose(fid);   
end










% -------------------- Standard Clustering Tab -------------------------- %


% --- Executes on selection change in stdclust_popup_dismeasure.
function stdclust_popup_dismeasure_Callback(hObject, eventdata, handles)
% hObject    handle to stdclust_popup_dismeasure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns stdclust_popup_dismeasure contents as cell array
%        contents{get(hObject,'Value')} returns selected item from stdclust_popup_dismeasure


% --- Executes during object creation, after setting all properties.
function stdclust_popup_dismeasure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stdclust_popup_dismeasure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in stdclust_popup_inputfile.
function stdclust_popup_inputfile_Callback(hObject, eventdata, handles)
% hObject    handle to stdclust_popup_inputfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns stdclust_popup_inputfile contents as cell array
%        contents{get(hObject,'Value')} returns selected item from stdclust_popup_inputfile


% --- Executes during object creation, after setting all properties.
function stdclust_popup_inputfile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stdclust_popup_inputfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stdclust_edit_savepath_Callback(hObject, eventdata, handles)
% hObject    handle to stdclust_edit_savepath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stdclust_edit_savepath as text
%        str2double(get(hObject,'String')) returns contents of stdclust_edit_savepath as a double


% --- Executes during object creation, after setting all properties.
function stdclust_edit_savepath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stdclust_edit_savepath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stdclust_edit_savefile_Callback(hObject, eventdata, handles)
% hObject    handle to stdclust_edit_savefile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stdclust_edit_savefile as text
%        str2double(get(hObject,'String')) returns contents of stdclust_edit_savefile as a double


% --- Executes during object creation, after setting all properties.
function stdclust_edit_savefile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stdclust_edit_savefile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on selection change in stdclust_listbox_fileformats.
function stdclust_listbox_fileformats_Callback(hObject, eventdata, handles)
% hObject    handle to stdclust_listbox_fileformats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns stdclust_listbox_fileformats contents as cell array
%        contents{get(hObject,'Value')} returns selected item from stdclust_listbox_fileformats


% --- Executes during object creation, after setting all properties.
function stdclust_listbox_fileformats_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stdclust_listbox_fileformats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stdclust_edit_numclust_Callback(hObject, eventdata, handles)
% hObject    handle to stdclust_edit_numclust (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stdclust_edit_numclust as text
%        str2double(get(hObject,'String')) returns contents of stdclust_edit_numclust as a double


% --- Executes during object creation, after setting all properties.
function stdclust_edit_numclust_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stdclust_edit_numclust (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in stdclust_popup_clustmethod.
function stdclust_popup_clustmethod_Callback(hObject, eventdata, handles)
% hObject    handle to stdclust_popup_clustmethod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns stdclust_popup_clustmethod contents as cell array
%        contents{get(hObject,'Value')} returns selected item from stdclust_popup_clustmethod


% --- Executes during object creation, after setting all properties.
function stdclust_popup_clustmethod_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stdclust_popup_clustmethod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in stdclust_checkbox_calcstats.
function stdclust_checkbox_calcstats_Callback(hObject, eventdata, handles)
% hObject    handle to stdclust_checkbox_calcstats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of
% stdclust_checkbox_calcstats


function stdclust_edit_minClustSize_Callback(hObject, eventdata, handles)
% hObject    handle to stdclust_edit_minClustSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stdclust_edit_minClustSize as text
%        str2double(get(hObject,'String')) returns contents of stdclust_edit_minClustSize as a double


% --- Executes during object creation, after setting all properties.
function stdclust_edit_minClustSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stdclust_edit_minClustSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in stdclust_checkbox_heatmaps.
function stdclust_checkbox_heatmaps_Callback(hObject, eventdata, handles)
% hObject    handle to stdclust_checkbox_heatmaps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of stdclust_checkbox_heatmaps
try 

    if get(hObject, 'Value')
        set(handles.text156, 'Enable', 'on');
        set(handles.text157, 'Enable', 'on');
        set(handles.text52, 'Enable', 'on');
        set(handles.text51, 'Enable', 'on');

        set(handles.stdclust_radio_redgreen, 'Enable', 'on');
        set(handles.stdclust_radio_yellowblue, 'Enable', 'on');
        set(handles.stdclust_radio_redwhiteblue, 'Enable', 'on');
        set(handles.stdclust_listbox_fileformats, 'Enable', 'on');
        set(handles.stdclust_edit_minClustSize, 'Enable', 'on');
        set(handles.stdclust_panel_heatmap, 'ForegroundColor', [0 0 0]);

    else
        set(handles.text156, 'Enable', 'off');
        set(handles.text157, 'Enable', 'off');
        set(handles.text52, 'Enable', 'off');
        set(handles.text51, 'Enable', 'off');
        
        set(handles.stdclust_radio_redgreen, 'Enable', 'off');
        set(handles.stdclust_radio_yellowblue, 'Enable', 'off');
        set(handles.stdclust_radio_redwhiteblue, 'Enable', 'off');
        set(handles.stdclust_listbox_fileformats, 'Enable', 'off');
        set(handles.stdclust_edit_minClustSize, 'Enable', 'off');
        set(handles.stdclust_panel_heatmap, 'ForegroundColor', [.502 .502 .502]);
    end

catch
        set(handles.text_jobstatustext, 'String', ...
            'There was an unforseen Matlab error. See errorlog.txt file for description.',...
            'ForegroundColor','red');
        guidata(hObject, handles); 
        
        lasterr
        fid = fopen('errorlog.txt', 'w');
        fprintf(fid, '%s', lasterr);
        fclose(fid);   
end


% --- Executes on button press in stdclust_button_browse.
function stdclust_button_browse_Callback(hObject, eventdata, handles)
% hObject    handle to stdclust_button_browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    
    % reset the status text box
    set(handles.text_jobstatustext, 'String', '');
    
    % open directory browser

    % change the directory to the last accessed
    cd(handles.lastDir);

    directory = uigetdir();
    handles.lastDir = directory;
        
    % change back to starting directory
    cd(handles.startDir);

    % checked to see if cancel was pressed
    if directory == 0
        set(handles.text_jobstatustext, 'String', 'No directory chosen.', ...
            'ForegroundColor', 'blue');
        guidata(hObject, handles);
        return;
    else
        set(handles.stdclust_edit_savepath, 'String', strcat(directory, '\'));
        guidata(hObject, handles);
    end

catch
        set(handles.text_jobstatustext, 'String', ...
            'There was an unforseen Matlab error. See errorlog.txt file for description.',...
            'ForegroundColor','red');
        guidata(hObject, handles); 
        
        lasterr
        fid = fopen('errorlog.txt', 'w');
        fprintf(fid, '%s', lasterr);
        fclose(fid);   
end





% --- Executes on button press in stdclust_button_clustanalysis.
function stdclust_button_clustanalysis_Callback(hObject, eventdata, handles)
% hObject    handle to stdclust_button_clustanalysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    % reset jobstatustext
    set(handles.text_jobstatustext, 'String', '');
    
        % check to make sure some data files have been loaded into the system.
    if isempty(handles.filestruct)
        set(handles.text_jobstatustext, 'String', 'Error: Must import some data files before any analysis can be done.',...
            'ForegroundColor', 'red');
        return;
    end
    
% --------- check to see if input file type is correct -------------%

    % on button press get the right file data from the fominputfile popup menu

    dataidx = get(handles.stdclust_popup_inputfile, 'Value');

    % then check to see if selected file is the right type
    if ~isequal(handles.filestruct(dataidx).filetype, 'FOM/Clustering')
        set(handles.text_jobstatustext, 'String', 'Error: File must be of FOM/Clustering type.',...
            'ForegroundColor','red');
        return;
    end

    % if the above error is displayed, and the file selection is now ok, reset
    % the error message
    if isequal(get(handles.text_jobstatustext, 'String'), ...
            'Error: File must be of FOM/Clustering type.')
        set(handles.text_jobstatustext, 'String', '');
    end


    % ---------------- import analysis parameters ------------------ %
 
    % get number of clusters from text box.
    % get the cluster method
    % get the similarity measure
    % get the color map
    % see if calc stats is checked
    
    
    % number of clusters
    % check to make sure something was entered
    if isempty(get(handles.stdclust_edit_numclust, 'String'))
        set(handles.text_jobstatustext, 'String', 'Error: Must enter number of clusters.',...
            'ForegroundColor', 'red');
        return;
    end
    
    numclust = str2double(get(handles.stdclust_edit_numclust, 'String'));
    totnumgenes = str2double(handles.filestruct(dataidx).numdatarow);
  
    % check to see if it is in the right format and range
    if isnan(numclust) || (numclust <= 1)  || (numclust >= totnumgenes)
        set(handles.text_jobstatustext, 'String', 'Error: Enter a number greater than 1 and less than the total number of elements.',...
            'ForegroundColor', 'red');
        return;
    end     
    

    
    % clustering method
    contents = get(handles.stdclust_popup_clustmethod, 'String');
    method = contents{get(handles.stdclust_popup_clustmethod, 'Value')};
    
    % check to make sure a method was chosen
    if isequal(method, 'None')
        set(handles.text_jobstatustext, 'String', 'Error: Must select a clustering method.', ...
            'ForegroundColor', 'red');
        return;
    end
    
    
    % similarity measure
    contents = get(handles.stdclust_popup_dismeasure,...
        'String');  % returns all options as a cell array
    dismeasure = contents{get(handles.stdclust_popup_dismeasure,...
        'Value')}; % returns to the selected option as a string
    
    % check to make sure a distance measure was chosen
    if isequal(dismeasure, 'None')
        set(handles.text_jobstatustext, 'String', 'Error: Must select a similarity measure.', ...
            'ForegroundColor', 'red');
        return;
    end
    
    
    % get the colormap
    if(get(handles.stdclust_radio_yellowblue, 'Value'))
        colormapval = 'blue-yellow';
    elseif(get(handles.stdclust_radio_redwhiteblue, 'Value'))
        colormapval = 'red-white-blue';
    else
        colormapval = 'red-green';
    end
    
    
% ------------------- import save file information ------------- %
 
    % get save path
    savepath = get(handles.stdclust_edit_savepath, 'String');
    if isempty(savepath)
        ButtonName=questdlg({'No destination was entered for the output files, so the input file destination will be used.', ...
            'Press Ok to continue or Cancel to enter a new destination.'},'Warning', 'Ok','Cancel','Ok');
        switch ButtonName
            case 'Ok',
                savepath = handles.filestruct(dataidx).filepath;
            case 'Cancel'
                set(handles.text_jobstatustext, 'String', 'Re-enter destination folder for results.',...
                    'ForegroundColor','blue');
                return;
        end
    elseif exist(savepath, 'dir') == 0
        set(handles.text_jobstatustext, 'String', 'Error: Destination path cannot be found.',...
           'ForegroundColor','red');
        return;           
    end
    
    % get the save file name
    savename = get(handles.stdclust_edit_savefile, 'String');
    if isempty(savename)
        set(handles.text_jobstatustext, 'String', 'Error: Must enter a file identifier',...
            'ForegroundColor', 'red');
        return;
    elseif exist(strcat(savepath, savename, '.txt'), 'file') > 0
        buttonvalue = questdlg(strcat(savename, ' analysis files already exists.  Would you like to overwrite them?'),...
            'Warning', 'Ok', 'Cancel', 'Ok');

        switch buttonvalue
            case 'Cancel',
                return;
        end           
    end 
 
 
    
    create_heatmaps = get(handles.stdclust_checkbox_heatmaps, 'Value');

    if create_heatmaps
        % the radio buttons don't need to be checked
        % The input data files need to be checked as they are not automatically
        % updated until after initilization.
        % The only things that need to be checked are the file types and the
        % minimum cluster size.  The user also needs to be warned that a lot of
        % files will be created with this option.


        % ------------- check the minClustSize box ---------------------- %

        if isempty(handles.stdclust_edit_minClustSize) || isnan(str2double(get(handles.stdclust_edit_minClustSize, 'String'))) || str2double(get(handles.stdclust_edit_minClustSize, 'String')) <= 0
            set(handles.text_jobstatustext, 'String', 'Error: Must enter a positive, non-zero minimum cluster size for heatmap generation.',...
                'ForegroundColor', 'red');
            return;
        end

        % ---------------- get file format types ----------------------------- %

        % initilize the fileformat array

        fileformats = {'fig'};

         % get the data from the list box

         list_contents = get(handles.stdclust_listbox_fileformats, 'String');

         % get the selections array

         list_selections = get(handles.stdclust_listbox_fileformats, 'Value');

        % figure out how many file type selections were made

        [d, num_selections] = size(list_selections);


        % check to see if the None selection was chosen.   If so, this overides all
        % other selections

        if num_selections > 1 && list_selections(1) == 1
            buttonvalue = questdlg({'The None file format selection will override all other selections, and only the .fig file will be saved.', ...
                'Is this ok?  Press Cancel to change your selections.'}, 'Warning', 'Ok', 'Cancel', 'Ok');

            switch buttonvalue
                case 'Cancel',
                    return;
            end

            % add to the fileformats array if the first selection is not None
        elseif num_selections > 0 && ~isequal(list_selections(1),1)

            for i=1:num_selections
                format = list_selections(i);

                switch format
                    case 2,
                        fileformats(length(fileformats)+1) = {'jpg'};
                    case 3,
                        fileformats(length(fileformats)+1) = {'bmp'};
                    case 4,
                        fileformats(length(fileformats)+1) = {'eps'};
                    case 5,
                        fileformats(length(fileformats)+1) = {'tif'};
                    case 6,
                        fileformats(length(fileformats)+1) = {'pdf'};
                    case 7,
                        fileformats(length(fileformats)+1) = {'ai'};
                end
            end

        end


        if num_selections > 0 && ~isequal(list_selections(1),1)
            % notify the user that they are about to create a lot of files

            msg = strcat('Selecting  ',num2str(num_selections), ' additional file types will generate  ', ...
                num2str((num_selections+1)), ' image files for each cluster.  Press Ok to continue and Cancel to change your selections.');

            buttonvalue = questdlg(msg, 'Warning', 'Ok', 'Cancel', 'Ok');

            switch buttonvalue
                case 'Cancel',
                    return;
            end
        end


    end % end if heatmap is checked


    


    
    
    % ----------- perform clustering ------------------- %

    set(handles.text_jobstatustext, 'String', 'Clustering, please wait...', ...
        'ForegroundColor','blue');

    clusterResult = StandardCluster( handles.filestruct(dataidx).data, ...
        handles.filestruct(dataidx).rowlabels, handles.filestruct(dataidx).colheader,...
        numclust, savename, savepath, dismeasure, method, colormapval  );

    if(get(handles.stdclust_checkbox_heatmaps, 'Value'))

        % get all the needed variables from the GUI
        % get colormap type
        if(get(handles.stdclust_radio_yellowblue, 'Value'))
            colormap = 'blue-yellow';
        elseif(get(handles.stdclust_radio_redwhiteblue, 'Value'))
            colormap = 'red-white-blue';
        else
            colormap = 'red-green';
        end

        row_labels = handles.filestruct(dataidx).rowlabels;
        col_header = handles.filestruct(dataidx).colheader;
        data = handles.filestruct(dataidx).data;
        
        num_clusters = length(unique(clusterResult));
        minClustSize = str2double(get(handles.stdclust_edit_minClustSize, 'String'));

       generateHeatmaps( clusterResult, row_labels, col_header,...
            data, num_clusters, savename, savepath, colormap, fileformats, minClustSize );


    end % end generation of heatmaps
        
        
    if(get(handles.stdclust_checkbox_calcstats, 'Value'))
        set(handles.text_jobstatustext, 'String', {'Finished clustering.',...
            'Calculating cluster statistics...'}, 'ForegroundColor','blue');

        statfilename = strcat(savepath, savename, '-ClusterStats.txt');

        ClusterStats(clusterResult, handles.filestruct(dataidx).data, ...
            numclust, statfilename, [1,1,1,1,1,1,1,1]);
    end % end calculation of calcstats

    set(handles.text_jobstatustext, 'String', 'Finished.', 'ForegroundColor','blue');


catch
        set(handles.text_jobstatustext, 'String', ...
            'There was an unforseen Matlab error. See errorlog.txt file for description.',...
            'ForegroundColor','red');
        guidata(hObject, handles); 
        
        lasterr
        fid = fopen('errorlog.txt', 'w');
        fprintf(fid, '%s', lasterr);
        fclose(fid);   
end







% ---------------- Statistics Tab ------------------------------------ %



% --- Executes on selection change in stats_popup_inputfile.
function stats_popup_inputfile_Callback(hObject, eventdata, handles)
% hObject    handle to stats_popup_inputfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns stats_popup_inputfile contents as cell array
%        contents{get(hObject,'Value')} returns selected item from stats_popup_inputfile


% --- Executes during object creation, after setting all properties.
function stats_popup_inputfile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stats_popup_inputfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stats_edit_savepath_Callback(hObject, eventdata, handles)
% hObject    handle to stats_edit_savepath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stats_edit_savepath as text
%        str2double(get(hObject,'String')) returns contents of stats_edit_savepath as a double


% --- Executes during object creation, after setting all properties.
function stats_edit_savepath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stats_edit_savepath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stats_edit_savefile_Callback(hObject, eventdata, handles)
% hObject    handle to stats_edit_savefile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stats_edit_savefile as text
%        str2double(get(hObject,'String')) returns contents of stats_edit_savefile as a double


% --- Executes during object creation, after setting all properties.
function stats_edit_savefile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stats_edit_savefile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in stats_checkbox_numgenes.
function stats_checkbox_numgenes_Callback(hObject, eventdata, handles)
% hObject    handle to stats_checkbox_numgenes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of stats_checkbox_numgenes


% --- Executes on button press in stats_checkbox_avgED.
function stats_checkbox_avgED_Callback(hObject, eventdata, handles)
% hObject    handle to stats_checkbox_avgED (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of stats_checkbox_avgED


% --- Executes on button press in stats_checkbox_avgProfile.
function stats_checkbox_avgProfile_Callback(hObject, eventdata, handles)
% hObject    handle to stats_checkbox_avgProfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of stats_checkbox_avgProfile


% --- Executes on button press in stats_checkbox_stddev.
function stats_checkbox_stddev_Callback(hObject, eventdata, handles)
% hObject    handle to stats_checkbox_stddev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of stats_checkbox_stddev


% --- Executes on button press in stats_checkbox_stderr.
function stats_checkbox_stderr_Callback(hObject, eventdata, handles)
% hObject    handle to stats_checkbox_stderr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of stats_checkbox_stderr


% --- Executes on button press in stats_checkbox_posnegcounts.
function stats_checkbox_posnegcounts_Callback(hObject, eventdata, handles)
% hObject    handle to stats_checkbox_posnegcounts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of stats_checkbox_posnegcounts


function stats_edit_minClustSize_Callback(hObject, eventdata, handles)
% hObject    handle to stats_edit_minClustSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stats_edit_minClustSize as text
%        str2double(get(hObject,'String')) returns contents of stats_edit_minClustSize as a double


% --- Executes during object creation, after setting all properties.
function stats_edit_minClustSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stats_edit_minClustSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in stats_listbox_fileformats.
function stats_listbox_fileformats_Callback(hObject, eventdata, handles)
% hObject    handle to stats_listbox_fileformats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns stats_listbox_fileformats contents as cell array
%        contents{get(hObject,'Value')} returns selected item from stats_listbox_fileformats


% --- Executes during object creation, after setting all properties.
function stats_listbox_fileformats_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stats_listbox_fileformats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in stats_toggle_directions.
function stats_toggle_directions_Callback(hObject, eventdata, handles)
% hObject    handle to stats_toggle_directions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of
% stats_toggle_directions

try
    
    if get(hObject, 'Value')
        set(handles.stats_panel_directions, 'Visible', 'on');
        set(handles.stats_toggle_directions, 'String', 'Hide Directions');
    else
        set(handles.stats_panel_directions, 'Visible', 'off');
        set(handles.stats_toggle_directions, 'String', 'View Directions');
    end

catch
        set(handles.text_jobstatustext, 'String', ...
            'There was an unforseen Matlab error. See errorlog.txt file for description.',...
            'ForegroundColor','red');
        guidata(hObject, handles); 
        
        lasterr
        fid = fopen('errorlog.txt', 'w');
        fprintf(fid, '%s', lasterr);
        fclose(fid);   
end


% --- Executes on button press in stats_button_browse.
function stats_button_browse_Callback(hObject, eventdata, handles)
% hObject    handle to stats_button_browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    
    % reset the status text box
    set(handles.text_jobstatustext, 'String', '');
    
    % open directory browser

    % change the directory to the last accessed
    cd(handles.lastDir);

    directory = uigetdir();
    handles.lastDir = directory;
        
    % change back to starting directory
    cd(handles.startDir);

    % checked to see if cancel was pressed
    if directory == 0
        set(handles.text_jobstatustext, 'String', 'No directory chosen.', ...
            'ForegroundColor', 'blue');
        guidata(hObject, handles);
        return;
    else
        set(handles.stats_edit_savepath, 'String', strcat(directory, '\'));
        guidata(hObject, handles);
    end

catch
        set(handles.text_jobstatustext, 'String', ...
            'There was an unforseen Matlab error. See errorlog.txt file for description.',...
            'ForegroundColor','red');
        guidata(hObject, handles); 
        
        lasterr
        fid = fopen('errorlog.txt', 'w');
        fprintf(fid, '%s', lasterr);
        fclose(fid);   
end


% --- Executes on button press in stats_button_calculate.
function stats_button_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to stats_button_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    % reset jobstatustext
    set(handles.text_jobstatustext, 'String', '');
    
        % check to make sure some data files have been loaded into the system.
    if isempty(handles.filestruct)
        set(handles.text_jobstatustext, 'String', 'Error: Must import some data files before any analysis can be done.',...
            'ForegroundColor', 'red');
        return;
    end
    
% --------- check to see if input file type is correct -------------%

    % on button press get the right file data from the fominputfile popup menu

    dataidx = get(handles.stats_popup_inputfile, 'Value');

    % then check to see if selected file is the right type
    if ~isequal(handles.filestruct(dataidx).filetype, 'Heatmap/Stats')
        set(handles.text_jobstatustext, 'String', 'Error: File must be of Heatmap/Stats type.',...
            'ForegroundColor','red');
        return;
    end
    
% ------------------------- import variables --------------- %
    
% first create the stats array that follows the following format:
% [AvgExpVec, StdDevVec, StdErrVec, #upVec, #downVec, #zeroVec, AvgEuclid, #genes]
% [avgProfile, stddev, stderr, posnegcounts, avgED, numgenes]

stats = [get(handles.stats_checkbox_avgProfile, 'Value'), ...
    get(handles.stats_checkbox_stddev, 'Value'), ...
    get(handles.stats_checkbox_stderr, 'Value'), ...
    get(handles.stats_checkbox_posnegcounts, 'Value'), ...
    get(handles.stats_checkbox_avgED, 'Value'), ...
    get(handles.stats_checkbox_numgenes, 'Value')];

if isequal(stats, [0 0 0 0 0 0])
    set(handles.text_jobstatustext, 'String', 'Error: You must select at least one of the cluster statistics to calculate.', ...
        'ForegroundColor', 'red');
    return;
end

% ------------------- import save file information ------------- %
 
    % get save path
    savepath = get(handles.stats_edit_savepath, 'String');
    if isempty(savepath)
        ButtonName=questdlg({'No destination was entered for the output files, so the input file destination will be used.', ...
            'Press Ok to continue or Cancel to enter a new destination.'},'Warning', 'Ok','Cancel','Ok');
        switch ButtonName
            case 'Ok',
                savepath = handles.filestruct(dataidx).filepath;
            case 'Cancel'
                set(handles.text_jobstatustext, 'String', 'Re-enter destination folder for results.',...
                    'ForegroundColor','blue');
                return;
        end
    elseif exist(savepath, 'dir') == 0
        set(handles.text_jobstatustext, 'String', 'Error: Destination path cannot be found.',...
           'ForegroundColor','red');
        return;           
    end
    
    % get the save file name
    savename = get(handles.stats_edit_savefile, 'String');
    if isempty(savename)
        set(handles.text_jobstatustext, 'String', 'Error: Must enter a file identifier',...
            'ForegroundColor', 'red');
        return;
    elseif exist(strcat(savepath, savename, '-ClusterStats.txt'), 'file') > 0
        buttonvalue = questdlg(strcat(savename, '-ClusterStats.txt already exists.  Would you like to overwrite it?'),...
            'Warning', 'Ok', 'Cancel', 'Ok');

        switch buttonvalue
            case 'Cancel',
                return;
        end           
    end 


    clusterResult = handles.filestruct(dataidx).data(:,1);
    data = handles.filestruct(dataidx).data;
    data(:,1) = [];
    numclusters = length(unique(clusterResult));
    statfilename = strcat(savepath, savename, '-ClusterStats.txt');
    ClusterStats(clusterResult, data, numclusters, statfilename, stats);

    set(handles.text_jobstatustext, 'String', 'Statistics calculated sucessfully.', 'ForegroundColor', 'blue');

catch
        set(handles.text_jobstatustext, 'String', ...
            'There was an unforseen Matlab error. See errorlog.txt file for description.',...
            'ForegroundColor','red');
        guidata(hObject, handles); 
        
        lasterr
        fid = fopen('errorlog.txt', 'w');
        fprintf(fid, '%s', lasterr);
        fclose(fid);   
end



% --- Executes on button press in stats_radio_redgreen.
function stats_radio_redgreen_Callback(hObject, eventdata, handles)
% hObject    handle to stats_radio_redgreen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of stats_radio_redgreen


% --- Executes on button press in stats_radio_yellowblue.
function stats_radio_yellowblue_Callback(hObject, eventdata, handles)
% hObject    handle to stats_radio_yellowblue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of stats_radio_yellowblue


% --- Executes on button press in stats_button_heatmaps.
function stats_button_heatmaps_Callback(hObject, eventdata, handles)
% hObject    handle to stats_button_heatmaps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    % reset jobstatustext
    set(handles.text_jobstatustext, 'String', '');
    
        % check to make sure some data files have been loaded into the system.
    if isempty(handles.filestruct)
        set(handles.text_jobstatustext, 'String', 'Error: Must import some data files before any analysis can be done.',...
            'ForegroundColor', 'red');
        return;
    end
    
% --------- check to see if input file type is correct -------------%

    % on button press get the right file data from the fominputfile popup menu

    dataidx = get(handles.stats_popup_inputfile, 'Value');

    % then check to see if selected file is the right type
    if ~isequal(handles.filestruct(dataidx).filetype, 'Heatmap/Stats')
        set(handles.text_jobstatustext, 'String', 'Error: File must be of Heatmap/Stats type.',...
            'ForegroundColor','red');
        return;
    end
    

% ------------------- import save file information ------------- %
 
    % get save path
    savepath = get(handles.stats_edit_savepath, 'String');
    if isempty(savepath)
        ButtonName=questdlg({'No destination was entered for the output files, so the input file destination will be used.', ...
            'Press Ok to continue or Cancel to enter a new destination.'},'Warning', 'Ok','Cancel','Ok');
        switch ButtonName
            case 'Ok',
                savepath = handles.filestruct(dataidx).filepath;
            case 'Cancel'
                set(handles.text_jobstatustext, 'String', 'Re-enter destination folder for results.',...
                    'ForegroundColor','blue');
                return;
        end
    elseif exist(savepath, 'dir') == 0
        set(handles.text_jobstatustext, 'String', 'Error: Destination path cannot be found.',...
           'ForegroundColor','red');
        return;           
    end
    
    % get the save file name
    savename = get(handles.stats_edit_savefile, 'String');
    if isempty(savename)
        set(handles.text_jobstatustext, 'String', 'Error: Must enter a file identifier',...
            'ForegroundColor', 'red');
        return;
    elseif exist(strcat(savepath, savename, '.txt'), 'file') > 0
        buttonvalue = questdlg(strcat(savename, ' heatmap files already exists.  Would you like to overwrite them?'),...
            'Warning', 'Ok', 'Cancel', 'Ok');

        switch buttonvalue
            case 'Cancel',
                return;
        end           
    end 
    
    
    
     % ---------------- get file format types ----------------------------- %

     % initilize the fileformat array

     fileformats = {'fig'};

     % get the data from the list box

     list_contents = get(handles.stats_listbox_fileformats, 'String');

     % get the selections array

     list_selections = get(handles.stats_listbox_fileformats, 'Value');

    % figure out how many selections were made

    [d, num_selections] = size(list_selections);


 if num_selections > 0 && ~isequal(list_selections(1),1)
        % notify the user that they are about to create a lot of files

        msg = strcat('Selecting  ',num2str(num_selections), ' additional file types will generate  ', ...
            num2str(num_selections+1), ' image files for each cluster.  Press Ok to continue and Cancel to change your selections.');

        buttonvalue = questdlg(msg, 'Warning', 'Ok', 'Cancel', 'Ok');

        switch buttonvalue
            case 'Cancel',
                return;
        end
    end
    
    
    
    % check to see if the None selection was chosen.   If so, this overides all
    % other selections

    if num_selections > 1 && list_selections(1) == 1
        buttonvalue = questdlg({'The None file format selection will override all other selections, and only the .fig file will be saved.', ...
            'Is this ok?  Press Cancel to change your selections.'}, 'Warning', 'Ok', 'Cancel', 'Ok');

        switch buttonvalue
            case 'Cancel',
                return;
        end

        % add to the fileformats array if the first selection is not None
    elseif num_selections > 0 && list_selections(1) ~= 1

        for i=1:num_selections
            format = list_selections(i);

            switch format
                case 2,
                    fileformats(length(fileformats)+1) = {'jpg'};
                case 3,
                    fileformats(length(fileformats)+1) = {'bmp'};
                case 4,
                    fileformats(length(fileformats)+1) = {'eps'};
                case 5,
                    fileformats(length(fileformats)+1) = {'tif'};
                case 6,
                    fileformats(length(fileformats)+1) = {'pdf'};
                case 7,
                    fileformats(length(fileformats)+1) = {'ai'};
            end
        end

    end
    
  % ------------- check the minClustSize box ---------------------- %
    
    if isempty(handles.stats_edit_minClustSize) || isnan(str2double(get(handles.stats_edit_minClustSize, 'String'))) || str2double(get(handles.stats_edit_minClustSize, 'String')) <= 0
        set(handles.text_jobstatustext, 'String', 'Error: Must enter a positive, non-zero minimum cluster size for heatmap generation.',...
            'ForegroundColor', 'red');
        return;
    end
    
% --------------- Get colormap type and creat heatmaps -------------- %
    
    if(get(handles.stats_radio_yellowblue, 'Value'))
        colormap = 'blue-yellow';
    elseif(get(handles.stats_radio_redwhiteblue, 'Value'))
        colormap = 'red-white-blue';
    else
        colormap = 'red-green';
    end

    heatmapfilename = savename;   
    clusterResult = handles.filestruct(dataidx).data(:,1);
    data = handles.filestruct(dataidx).data;
    data(:,1) = [];
    numclusters = length(unique(clusterResult));

    generateHeatmaps( clusterResult, handles.filestruct(dataidx).rowlabels,...
        handles.filestruct(dataidx).colheader, data, numclusters, heatmapfilename,...
        savepath, colormap, fileformats, str2double(get(handles.stats_edit_minClustSize, 'String')) );
    
    set(handles.text_jobstatustext, 'String', 'Heatmaps generated sucessfully.',...
        'ForegroundColor', 'blue');

catch
        set(handles.text_jobstatustext, 'String', ...
            'There was an unforseen Matlab error. See errorlog.txt file for description.',...
            'ForegroundColor','red');
        guidata(hObject, handles); 
        
        lasterr
        fid = fopen('errorlog.txt', 'w');
        fprintf(fid, '%s', lasterr);
        fclose(fid);   
end

    
        
     












% ------------------ Cluster Mapping Tab -------------------------- %        
        

% --- Executes on selection change in mapping_popup_inputfile.
function mapping_popup_inputfile_Callback(hObject, eventdata, handles)
% hObject    handle to mapping_popup_inputfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns mapping_popup_inputfile contents as cell array
%        contents{get(hObject,'Value')} returns selected item from mapping_popup_inputfile


% --- Executes during object creation, after setting all properties.
function mapping_popup_inputfile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mapping_popup_inputfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mapping_edit_savepath_Callback(hObject, eventdata, handles)
% hObject    handle to mapping_edit_savepath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mapping_edit_savepath as text
%        str2double(get(hObject,'String')) returns contents of mapping_edit_savepath as a double


% --- Executes during object creation, after setting all properties.
function mapping_edit_savepath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mapping_edit_savepath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mapping_edit_savefile_Callback(hObject, eventdata, handles)
% hObject    handle to mapping_edit_savefile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mapping_edit_savefile as text
%        str2double(get(hObject,'String')) returns contents of mapping_edit_savefile as a double


% --- Executes during object creation, after setting all properties.
function mapping_edit_savefile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mapping_edit_savefile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in mapping_button_browse.
function mapping_button_browse_Callback(hObject, eventdata, handles)
% hObject    handle to mapping_button_browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    
    % reset the status text box
    set(handles.text_jobstatustext, 'String', '');
    
    % open directory browser

    % change the directory to the last accessed
    cd(handles.lastDir);

    directory = uigetdir();
    handles.lastDir = directory;
        
    % change back to starting directory
    cd(handles.startDir);

    % checked to see if cancel was pressed
    if directory == 0
        set(handles.text_jobstatustext, 'String', 'No directory chosen.', ...
            'ForegroundColor', 'blue');
        guidata(hObject, handles);
        return;
    else
        set(handles.mapping_edit_savepath, 'String', strcat(directory, '\'));
        guidata(hObject, handles);
    end

catch
        set(handles.text_jobstatustext, 'String', ...
            'There was an unforseen Matlab error. See errorlog.txt file for description.',...
            'ForegroundColor','red');
        guidata(hObject, handles); 
        
        lasterr
        fid = fopen('errorlog.txt', 'w');
        fprintf(fid, '%s', lasterr);
        fclose(fid);   
end



% --- Executes on button press in mapping_button_create.
function mapping_button_create_Callback(hObject, eventdata, handles)
% hObject    handle to mapping_button_create (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    % reset jobstatustext
    set(handles.text_jobstatustext, 'String', '');
    
        % check to make sure some data files have been loaded into the system.
    if isempty(handles.filestruct)
        set(handles.text_jobstatustext, 'String', 'Error: Must import some data files before any analysis can be done.',...
            'ForegroundColor', 'red');
        return;
    end
    
% --------- check to see if input file type is correct -------------%

    % on button press get the right file data from the fominputfile popup menu

    dataidx = get(handles.mapping_popup_inputfile, 'Value');

    % then check to see if selected file is the right type
    if ~isequal(handles.filestruct(dataidx).filetype, 'ClusterMapping')
        set(handles.text_jobstatustext, 'String', 'Error: File must be of ClusterMapping type.',...
            'ForegroundColor','red');
        return;
    end
    

% ------------------- import save file information ------------- %
 
    % get save path
    savepath = get(handles.mapping_edit_savepath, 'String');
    if isempty(savepath)
        ButtonName=questdlg({'No destination was entered for the output files, so the input file destination will be used.', ...
            'Press Ok to continue or Cancel to enter a new destination.'},'Warning', 'Ok','Cancel','Ok');
        switch ButtonName
            case 'Ok',
                savepath = handles.filestruct(dataidx).filepath;
            case 'Cancel'
                set(handles.text_jobstatustext, 'String', 'Re-enter destination folder for results.',...
                    'ForegroundColor','blue');
                return;
        end
    elseif exist(savepath, 'dir') == 0
        set(handles.text_jobstatustext, 'String', 'Error: Destination path cannot be found.',...
           'ForegroundColor','red');
        return;           
        
    end
    
    % get the save file name
    savename = get(handles.mapping_edit_savefile, 'String');
    if isempty(savename)
        set(handles.text_jobstatustext, 'String', 'Error: Must enter a file identifier',...
            'ForegroundColor', 'red');
        return;
    elseif exist(strcat(savepath, savename, '.txt'), 'file') > 0
        buttonvalue = questdlg(strcat(savename, '.txt already exists.  Would you like to overwrite it?'),...
            'Warning', 'Ok', 'Cancel', 'Ok');

        switch buttonvalue
            case 'Cancel',
                return;
        end           
    end 

    
  % ---------------- create cluster mapping ------------------------- %
  
    mapfile = strcat(savepath, savename, '.txt');

    CreateClusterMapping( handles.filestruct(dataidx).data(:,1), handles.filestruct(dataidx).data(:,2), mapfile );

    set(handles.text_jobstatustext, 'String', 'Cluster mapping generated sucessfully.',...
        'ForegroundColor', 'blue');
    
        
catch
        set(handles.text_jobstatustext, 'String', ...
            'There was an unforseen Matlab error. See errorlog.txt file for description.',...
            'ForegroundColor','red');
        guidata(hObject, handles); 
        
        lasterr
        fid = fopen('errorlog.txt', 'w');
        fprintf(fid, '%s', lasterr);
        fclose(fid);   
end



















% ---------------------- Consensus CLustering TAB -------------------- %

function consensus_edit_savepath_Callback(hObject, eventdata, handles)
% hObject    handle to consensus_edit_savepath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of consensus_edit_savepath as text
%        str2double(get(hObject,'String')) returns contents of consensus_edit_savepath as a double


% --- Executes during object creation, after setting all properties.
function consensus_edit_savepath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to consensus_edit_savepath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function consensus_edit_savefile_Callback(hObject, eventdata, handles)
% hObject    handle to consensus_edit_savefile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of consensus_edit_savefile as text
%        str2double(get(hObject,'String')) returns contents of consensus_edit_savefile as a double


% --- Executes during object creation, after setting all properties.
function consensus_edit_savefile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to consensus_edit_savefile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function consensus_edit_initnumclusts_Callback(hObject, eventdata, handles)
% hObject    handle to consensus_edit_initnumclusts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of consensus_edit_initnumclusts as text
%        str2double(get(hObject,'String')) returns contents of consensus_edit_initnumclusts as a double


% --- Executes during object creation, after setting all properties.
function consensus_edit_initnumclusts_CreateFcn(hObject, eventdata, handles)
% hObject    handle to consensus_edit_initnumclusts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in consensus_listbox_fileformats.
function consensus_listbox_fileformats_Callback(hObject, eventdata, handles)
% hObject    handle to consensus_listbox_fileformats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns consensus_listbox_fileformats contents as cell array
%        contents{get(hObject,'Value')} returns selected item from consensus_listbox_fileformats


% --- Executes during object creation, after setting all properties.
function consensus_listbox_fileformats_CreateFcn(hObject, eventdata, handles)
% hObject    handle to consensus_listbox_fileformats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in consensus_checkbox_clusterruns.
function consensus_checkbox_clusterruns_Callback(hObject, eventdata, handles)
% hObject    handle to consensus_checkbox_clusterruns (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of consensus_checkbox_clusterruns



% --- Executes on button press in consensus_checkbox_calcstats.
function consensus_checkbox_calcstats_Callback(hObject, eventdata, handles)
% hObject    handle to consensus_checkbox_calcstats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of consensus_checkbox_calcstats

% --- Executes during object creation, after setting all properties.
function consensus_listbox_clustmethod_CreateFcn(hObject, eventdata, handles)
% hObject    handle to consensus_listbox_clustmethod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in consensus_listbox_dismeasure.
function consensus_listbox_dismeasure_Callback(hObject, eventdata, handles)
% hObject    handle to consensus_listbox_dismeasure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns consensus_listbox_dismeasure contents as cell array
%        contents{get(hObject,'Value')} returns selected item from consensus_listbox_dismeasure


% --- Executes during object creation, after setting all properties.
function consensus_listbox_dismeasure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to consensus_listbox_dismeasure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in consensus_listbox_heatmapdata.
function consensus_listbox_heatmapdata_Callback(hObject, eventdata, handles)
% hObject    handle to consensus_listbox_heatmapdata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns consensus_listbox_heatmapdata contents as cell array
%        contents{get(hObject,'Value')} returns selected item from consensus_listbox_heatmapdata


% --- Executes during object creation, after setting all properties.
function consensus_listbox_heatmapdata_CreateFcn(hObject, eventdata, handles)
% hObject    handle to consensus_listbox_heatmapdata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function consensus_edit_kmeanReps_Callback(hObject, eventdata, handles)
% hObject    handle to consensus_edit_kmeanReps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of consensus_edit_kmeanReps as text
%        str2double(get(hObject,'String')) returns contents of consensus_edit_kmeanReps as a double


% --- Executes during object creation, after setting all properties.
function consensus_edit_kmeanReps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to consensus_edit_kmeanReps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function consensus_edit_customfile_Callback(hObject, eventdata, handles)
% hObject    handle to consensus_edit_customfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of consensus_edit_customfile as text
%        str2double(get(hObject,'String')) returns contents of consensus_edit_customfile as a double


% --- Executes during object creation, after setting all properties.
function consensus_edit_customfile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to consensus_edit_customfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function consensus_edit_minClustSize_Callback(hObject, eventdata, handles)
% hObject    handle to consensus_edit_minClustSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of consensus_edit_minClustSize as text
%        str2double(get(hObject,'String')) returns contents of consensus_edit_minClustSize as a double


% --- Executes during object creation, after setting all properties.
function consensus_edit_minClustSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to consensus_edit_minClustSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in consensus_checkbox_heatmaps.
function consensus_checkbox_heatmaps_Callback(hObject, eventdata, handles)
% hObject    handle to consensus_checkbox_heatmaps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of
% consensus_checkbox_heatmaps

try 

    if get(hObject, 'Value')
        set(handles.text147, 'Enable', 'on');
        set(handles.text118, 'Enable', 'on');
        set(handles.text119, 'Enable', 'on');
        set(handles.text141, 'Enable', 'on');
        set(handles.text140, 'Enable', 'on');
        set(handles.text139, 'Enable', 'on');

        set(handles.consensus_radio_redgreen, 'Enable', 'on');
        set(handles.consensus_radio_yellowblue, 'Enable', 'on');
        set(handles.consensus_radio_redwhiteblue, 'Enable', 'on');
        set(handles.consensus_listbox_heatmapdata, 'Enable', 'on');
        set(handles.consensus_listbox_fileformats, 'Enable', 'on');
        set(handles.consensus_edit_minClustSize, 'Enable', 'on');
        set(handles.uipanel35, 'ForegroundColor', [0 0 0]);

    else
        set(handles.text147, 'Enable', 'off');
        set(handles.text118, 'Enable', 'off');
        set(handles.text119, 'Enable', 'off');
        set(handles.text141, 'Enable', 'off');
        set(handles.text140, 'Enable', 'off');
        set(handles.text139, 'Enable', 'off');

        set(handles.consensus_radio_redgreen, 'Enable', 'off');
        set(handles.consensus_radio_yellowblue, 'Enable', 'off');
        set(handles.consensus_radio_redwhiteblue, 'Enable', 'off');
        set(handles.consensus_listbox_heatmapdata, 'Enable', 'off');
        set(handles.consensus_listbox_fileformats, 'Enable', 'off');
        set(handles.consensus_edit_minClustSize, 'Enable', 'off');
        set(handles.uipanel35, 'ForegroundColor', [.502 .502 .502]);
    end

catch
        set(handles.text_jobstatustext, 'String', ...
            'There was an unforseen Matlab error. See errorlog.txt file for description.',...
            'ForegroundColor','red');
        guidata(hObject, handles); 
        
        lasterr
        fid = fopen('errorlog.txt', 'w');
        fprintf(fid, '%s', lasterr);
        fclose(fid);   
end



% --- Executes on selection change in consensus_listbox_inputfile.
function consensus_listbox_inputfile_Callback(hObject, eventdata, handles)
% hObject    handle to consensus_listbox_inputfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns consensus_listbox_inputfile contents as cell array
%        contents{get(hObject,'Value')} returns selected item from consensus_listbox_inputfile

try
    contents = cellstr(get(hObject, 'String'));
    selected = contents(get(hObject, 'Value'));

    set(handles.consensus_listbox_heatmapdata, 'String', selected, 'Value', 1.0);

catch
        set(handles.text_jobstatustext, 'String', ...
            'There was an unforseen Matlab error. See errorlog.txt file for description.',...
            'ForegroundColor','red');
        guidata(hObject, handles); 
        
        lasterr
        fid = fopen('errorlog.txt', 'w');
        fprintf(fid, '%s', lasterr);
        fclose(fid);   
end

% --- Executes during object creation, after setting all properties.
function consensus_listbox_inputfile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to consensus_listbox_inputfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in consensus_listbox_clustmethod.
function consensus_listbox_clustmethod_Callback(hObject, eventdata, handles)
% hObject    handle to consensus_listbox_clustmethod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns consensus_listbox_clustmethod contents as cell array
%        contents{get(hObject,'Value')} returns selected item from consensus_listbox_clustmethod

try
    
    contents = get(hObject, 'String');
    selected = contents(get(hObject, 'Value'));

    if ismember('Import Custom', selected)
        set(handles.consensus_panel_customruns, 'Visible', 'on');
        set(handles.consensus_panel_kmeanReps, 'Visible', 'off');       
        set(handles.consensus_checkbox_clusterruns, 'Enable', 'off');
        set(handles.consensus_listbox_dismeasure, 'Enable', 'off');
        set(handles.consensus_edit_initnumclusts, 'Enable', 'off');
        set(handles.text136, 'ForegroundColor', [.502 .502 .502]);
        set(handles.text150, 'ForegroundColor', [.502 .502 .502]);
    elseif ismember('Kmeans', selected)
        set(handles.consensus_panel_customruns, 'Visible', 'off');
        set(handles.consensus_panel_kmeanReps, 'Visible', 'on');
        set(handles.consensus_checkbox_clusterruns, 'Enable', 'on');
        set(handles.consensus_listbox_dismeasure, 'Enable', 'on');
        set(handles.consensus_edit_initnumclusts, 'Enable', 'on');
        set(handles.text136, 'ForegroundColor', [0 0 0]);
        set(handles.text150, 'ForegroundColor', [0 0 0]);
    else
        set(handles.consensus_panel_customruns, 'Visible', 'off');
        set(handles.consensus_panel_kmeanReps, 'Visible', 'off');
        set(handles.consensus_checkbox_clusterruns, 'Enable', 'on');
        set(handles.consensus_listbox_dismeasure, 'Enable', 'on');
        set(handles.consensus_edit_initnumclusts, 'Enable', 'on');
        set(handles.text136, 'ForegroundColor', [0 0 0]);
        set(handles.text150, 'ForegroundColor', [0 0 0]);
    end

catch
        set(handles.text_jobstatustext, 'String', ...
            'There was an unforseen Matlab error. See errorlog.txt file for description.',...
            'ForegroundColor','red');
        guidata(hObject, handles); 
        
        lasterr
        fid = fopen('errorlog.txt', 'w');
        fprintf(fid, '%s', lasterr);
        fclose(fid);   
end

% --- Executes on selection change in consensus_edit_threshold.
function consensus_edit_threshold_Callback(hObject, eventdata, handles)
% hObject    handle to consensus_edit_threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns consensus_edit_threshold contents as cell array
%        contents{get(hObject,'Value')} returns selected item from consensus_edit_threshold


% --- Executes during object creation, after setting all properties.
function consensus_edit_threshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to consensus_edit_threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in consensus_toggle_directions.
function consensus_toggle_directions_Callback(hObject, eventdata, handles)
% hObject    handle to consensus_toggle_directions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of
% consensus_toggle_directions

try
    
    if get(hObject, 'Value')
        set(handles.consensus_panel_directions, 'Visible', 'on');
        set(handles.consensus_toggle_directions, 'String', 'Hide Directions');
    else
        set(handles.consensus_panel_directions, 'Visible', 'off');
        set(handles.consensus_toggle_directions, 'String', 'View Directions');
    end

catch
        set(handles.text_jobstatustext, 'String', ...
            'There was an unforseen Matlab error. See errorlog.txt file for description.',...
            'ForegroundColor','red');
        guidata(hObject, handles); 
        
        lasterr
        fid = fopen('errorlog.txt', 'w');
        fprintf(fid, '%s', lasterr);
        fclose(fid);   
end


% --- Executes on button press in consensus_button_browsecustom.
function consensus_button_browsecustom_Callback(hObject, eventdata, handles)
% hObject    handle to consensus_button_browsecustom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    
    % reset the status text box
    set(handles.text_jobstatustext, 'String', '');
    
    % open directory browser
    
    % change the directory to the last accessed
    cd(handles.lastDir);
        
    [name, path] = uigetfile('*.txt', 'Load Custom Cluster Solution');
    
    % change back to starting directory
    cd(handles.startDir);
    
    % check to see if cancel was pressed
    if name == 0
        set(handles.text_jobstatustext, 'String', 'No file chosen.', ...
            'ForegroundColor', 'blue');
        guidata(hObject, handles);
        return;
    else
        set(handles.consensus_edit_customfile, 'String', strcat(path, name));
        guidata(hObject, handles);
    end
    
    fullname = strcat(path, name);
    S = uiimport(fullname);

    %check to see if the import was canceled
    if isequal(S,[])
        set(handles.text_jobstatustext, 'String', 'Data import canceled.', ...
            'ForegroundColor', 'red');
        guidata(hObject, handles);
        return;
    end
    
    %update the last directory accessed
    handles.lastDir = path;
    
    num_rows = length(S.textdata(:,1));
    num_col = length(S.textdata(1,:));
    
    handles.customdata.rowlabels = S.textdata(2:num_rows, 1);
    handles.customdata.collabels = S.textdata(1, 2:num_col);
    handles.customdata.data = S.data(:,:);
    guidata(hObject, handles);

catch
        set(handles.text_jobstatustext, 'String', ...
            'There was an unforseen Matlab error. See errorlog.txt file for description.',...
            'ForegroundColor','red');
        %handles.customdata = [];
        guidata(hObject, handles); 
        
        lasterr
        fid = fopen('errorlog.txt', 'w');
        fprintf(fid, '%s', lasterr);
        fclose(fid);   
end


% --- Executes on button press in consensus_button_browse.
function consensus_button_browse_Callback(hObject, eventdata, handles)
% hObject    handle to consensus_button_browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    
    % reset the status text box
    set(handles.text_jobstatustext, 'String', '');
    
    % open directory browser

    % change the directory to the last accessed
    cd(handles.lastDir);

    directory = uigetdir();
    handles.lastDir = directory;
        
    % change back to starting directory
    cd(handles.startDir);

    % checked to see if cancel was pressed
    if directory == 0
        set(handles.text_jobstatustext, 'String', 'No directory chosen.', ...
            'ForegroundColor', 'blue');
        guidata(hObject, handles);
        return;
    else
        set(handles.consensus_edit_savepath, 'String', strcat(directory, '\'));
        guidata(hObject, handles);
    end

catch
        set(handles.text_jobstatustext, 'String', ...
            'There was an unforseen Matlab error. See errorlog.txt file for description.',...
            'ForegroundColor','red');
        guidata(hObject, handles); 
        
        lasterr
        fid = fopen('errorlog.txt', 'w');
        fprintf(fid, '%s', lasterr);
        fclose(fid);   
end



% --- Executes on button press in consensus_button_cluster.
function consensus_button_cluster_Callback(hObject, eventdata, handles)
% hObject    handle to consensus_button_cluster (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    
    % reset jobstatustext
    set(handles.text_jobstatustext, 'String', '');
    
    % check to make sure some data files have been loaded into the system.
    if isempty(handles.filestruct)
        set(handles.text_jobstatustext, 'String', 'Error: Must import some data files before any analysis can be done.',...
            'ForegroundColor', 'red');
        return;
    end
   
% --------- check to see if input file types are correct -------------%

    % on button press get the right file data from the fominputfile popup menu

    dataidxary = get(handles.consensus_listbox_inputfile, 'Value');
    
    if isempty(dataidxary)
        set(handles.text_jobstatustext, 'String', 'Error: Must select at least 1 input file.',...
            'ForegroundColor', 'red');
        return;
    end
    
    % then check to see if selected files are the right type
    for i=1:length(dataidxary)
        if ~isequal(handles.filestruct(dataidxary(i)).filetype, 'FOM/Clustering')
            set(handles.text_jobstatustext, 'String', 'Error: All files must be of FOM/Clustering type.',...
                'ForegroundColor','red');
            return;
        end
        
 % If this file is ok, copy selected data to a new structure   

        handles.consensus_datastruct(i).data = handles.filestruct(dataidxary(i)).data;
        handles.consensus_datastruct(i).colheader = handles.filestruct(dataidxary(i)).colheader;
        handles.consensus_datastruct(i).rowlabels = handles.filestruct(dataidxary(i)).rowlabels;
        handles.consensus_datastruct(i).filename = handles.filestruct(dataidxary(i)).filename;
        handles.consensus_datastruct(i).filepath = handles.filestruct(dataidxary(i)).filepath;
        handles.consensus_datastruct(i).filetype = handles.filestruct(dataidxary(i)).filetype;
        handles.consensus_datastruct(i).numdatarow = handles.filestruct(dataidxary(i)).numdatarow;
        handles.consensus_datastruct(i).numdatacol = handles.filestruct(dataidxary(i)).numdatacol;

    end

    
    % If Import Custom is chosen for the clustering method, make sure there
    % is a file entered in the consensus_edit_customfile box.
    
    if isempty(get(handles.consensus_listbox_clustmethod, 'Value'))
        set(handles.text_jobstatustext, 'String', 'Error: Must select at least 1 cluster method.',...
            'ForegroundColor', 'red');
        return;
    end
    
    contents = get(handles.consensus_listbox_clustmethod, 'String');
    selected = contents(get(handles.consensus_listbox_clustmethod, 'Value'));

    if ismember('Import Custom', selected)
  
        if isempty(get(handles.consensus_edit_customfile, 'String')) % || isequal(handles.consensus_edit_customfile, '')
            set(handles.text_jobstatustext, 'String', 'Error: Must import a file containing custom cluster results.',...
                'ForegroundColor', 'red');
            return;
        elseif length(selected) > 1
            ButtonName=questdlg({'Selecting the Import Custom option will override any other selection.', ...
            'Press Ok to continue or Cancel to review cluster method choices.'},'Warning', 'Ok','Cancel','Ok');
            switch ButtonName
                case 'Cancel',
                    return;
            end
        end
    % If Kmeans is chosen for the clustering method, make sure there
    % is a number entered in the consensus_edit_kmeanReps box.  
    
    elseif ismember('Kmeans', selected)
        
        if isempty(handles.consensus_edit_kmeanReps) || isnan(str2double(get(handles.consensus_edit_kmeanReps, 'String'))) || str2double(get(handles.consensus_edit_kmeanReps, 'String')) <= 0
            set(handles.text_jobstatustext, 'String', 'Error: Must enter a positive, non-zero number of repititions for the kmeans algorithm.',...
                'ForegroundColor', 'red');
            return;
        end
        
    elseif ismember('Hierarchical', selected) && length(selected) == 1
        
        % then hierarchical is the only choice, so the user must have
        % selected 2 or more data sets.
        if length(dataidxary) < 2 && length(get(handles.consensus_listbox_dismeasure, 'Value')) == 1
            set(handles.text_jobstatustext, 'String', 'Error: Must select 2 or more datasets and/or similarity measures for analysis if Hierarchical is the only clustering method.',...
                'ForegroundColor', 'red');
            return;
        end
        
    end


    % ---------- check to see if initial number of clusters was entered --%
    
    if ~ismember('Import Custom', selected) && isempty(handles.consensus_edit_initnumclusts) || isnan(str2double(get(handles.consensus_edit_initnumclusts, 'String'))) || str2double(get(handles.consensus_edit_initnumclusts, 'String')) <= 0
        set(handles.text_jobstatustext, 'String', 'Error: Must enter a positive initial number greater than 1.',...
            'ForegroundColor', 'red');
        return;
    end
 
% --------- check to see if dismeasure was selected ------------------- %

    if isempty(get(handles.consensus_listbox_dismeasure, 'Value')) && ~ismember('Import Custom', selected)
        set(handles.text_jobstatustext, 'String', 'Error: Must select at least 1 similarity measure.',...
            'ForegroundColor', 'red');
        return;
    end
    
    
% ------------------- import save file information ------------- %
 
    % get save path
    % for consensus clustering, since mutiple files from multiple locations
    % can be used, the user must select a destination folder.
    savepath = get(handles.consensus_edit_savepath, 'String');
    if isempty(savepath)
        set(handles.text_jobstatustext, 'String', 'Error: Must select a destination folder for results.',...
           'ForegroundColor','red');
           return;
    elseif exist(savepath, 'dir') == 0
        set(handles.text_jobstatustext, 'String', 'Error: Destination path cannot be found.',...
           'ForegroundColor','red');
           return;    
    end
    
    % get the save file name
    savename = get(handles.consensus_edit_savefile, 'String');
    if isempty(savename)
        set(handles.text_jobstatustext, 'String', 'Error: Must enter a file identifier',...
            'ForegroundColor', 'red');
        return;
    elseif exist(strcat(savepath, savename, '.txt'), 'file') > 0
        buttonvalue = questdlg(strcat(savename, ' analysis files already exists.  Would you like to overwrite them?'),...
            'Warning', 'Ok', 'Cancel', 'Ok');

        switch buttonvalue
            case 'Cancel',
                return;
        end          
    end 
    
    
    

    % --------------- Check heatmap options ------------------------------ %


    create_heatmaps = get(handles.consensus_checkbox_heatmaps, 'Value');

    if create_heatmaps
        % the radio buttons don't need to be checked
        % The input data files need to be checked as they are not automatically
        % updated until after initilization.
        % The only things that need to be checked are the file types and the
        % minimum cluster size.  The user also needs to be warned that a lot of
        % files will be created with this option.

        % ---------- Check to see if data file have been chosen ---------- %

        if isequal(get(handles.consensus_listbox_heatmapdata, 'String'), 'none') || isempty(get(handles.consensus_listbox_heatmapdata, 'Value'))
                set(handles.text_jobstatustext, 'String', 'Error: Must select at least 1 data file for heatmap generation.',...
                'ForegroundColor', 'red');
            return;
        end

        % ------------- check the minClustSize box ---------------------- %

        if isempty(handles.consensus_edit_minClustSize) || isnan(str2double(get(handles.consensus_edit_minClustSize, 'String'))) || str2double(get(handles.consensus_edit_minClustSize, 'String')) <= 0
            set(handles.text_jobstatustext, 'String', 'Error: Must enter a positive, non-zero minimum cluster size for heatmap generation.',...
                'ForegroundColor', 'red');
            return;
        end

        % ---------------- get file format types ----------------------------- %

         % initilize the fileformat array

         fileformats = {'fig'};

         % get the data from the list box

         list_contents = get(handles.consensus_listbox_fileformats, 'String');

         % get the selections array

         list_selections = get(handles.consensus_listbox_fileformats, 'Value');

        % figure out how many file type selections were made

        [d, num_selections] = size(list_selections);

        % figure out how many datasets were selected

        [d, num_heatmapdata] = size(get(handles.consensus_listbox_heatmapdata));


        % check to see if the None selection was chosen.   If so, this overides all
        % other selections

        if num_selections > 1 && list_selections(1) == 1
            buttonvalue = questdlg({'The None file format selection will override all other selections, and only the .fig file will be saved.', ...
                'Is this ok?  Press Cancel to change your selections.'}, 'Warning', 'Ok', 'Cancel', 'Ok');

            switch buttonvalue
                case 'Cancel',
                    return;
            end

            % add to the fileformats array if the first selection is not None
        elseif num_selections > 0 && ~isequal(list_selections(1),1)

            for i=1:num_selections
                format = list_selections(i);

                switch format
                    case 2,
                        fileformats(length(fileformats)+1) = {'jpg'};
                    case 3,
                        fileformats(length(fileformats)+1) = {'bmp'};
                    case 4,
                        fileformats(length(fileformats)+1) = {'eps'};
                    case 5,
                        fileformats(length(fileformats)+1) = {'tif'};
                    case 6,
                        fileformats(length(fileformats)+1) = {'pdf'};
                    case 7,
                        fileformats(length(fileformats)+1) = {'ai'};
                end
            end

        end


        if num_selections > 0 && ~isequal(list_selections(1),1)
            % notify the user that they are about to create a lot of files

            msg = strcat('Selecting  ',num2str(num_selections), ' additional file types will generate  ', ...
                num2str((num_selections+1)*num_heatmapdata), ' image files for each cluster.  Press Ok to continue and Cancel to change your selections.');

            buttonvalue = questdlg(msg, 'Warning', 'Ok', 'Cancel', 'Ok');

            switch buttonvalue
                case 'Cancel',
                    return;
            end
        end


    end % end if heatmap is checked



    % ---------- Check for order of all data files and custom data file ---- %

    num_datasets = length(handles.consensus_datastruct);

    % get a random index that exists in the first dataset
    perm = randperm(str2double(handles.consensus_datastruct(1).numdatarow) - 2);

    randidx = perm(1)+1;  % this is done so that the first and last idx cannot 
    % be chosen since those are checked anyway.

    % get the size of the first data set

    dsize = size(handles.consensus_datastruct(1).data);

    lastidx = dsize(1);

    if num_datasets > 1
        for i=2:num_datasets
            % first check to see if the data sets have equal number of rows
            %tmpsize = size(handles.consensus_datastruct(i).data)
            tmpsize = size(handles.consensus_datastruct(i).data);
            if ~isequal(dsize(1), tmpsize(1))
                set(handles.text_jobstatustext, 'String', 'Error: all input data must have the same number of rows and columns.',...
                    'ForegroundColor', 'red');
                return;
            end

            % the check to see if the first, last and random gene id's are the
            % same.
            if ~isequal(handles.consensus_datastruct(1).rowlabels(1), handles.consensus_datastruct(i).rowlabels(1)) || ...
                    ~isequal(handles.consensus_datastruct(1).rowlabels(lastidx), handles.consensus_datastruct(i).rowlabels(lastidx)) || ...
                    ~isequal(handles.consensus_datastruct(1).rowlabels(randidx), handles.consensus_datastruct(i).rowlabels(randidx))

                set(handles.text_jobstatustext, 'String', 'Error: all input data must be in the same order.',...
                    'ForegroundColor', 'red');
                return;
            end  

        end
    end

    if ismember('Import Custom', selected)

        custsize = size(handles.customdata.data);
        % first check to see if the data set size is equal
        if ~isequal(dsize(1),custsize(1))
            set(handles.text_jobstatustext, 'String', 'Error: Custom Data must have same number of columns as input file.',...
                'ForegroundColor', 'red');
            return;
        end

        % then check to see if the first, last and random gene id's are the
        % same.
        if ~isequal(handles.customdata.rowlabels(1), handles.customdata.rowlabels(1)) || ...
                ~isequal(handles.customdata.rowlabels(lastidx), handles.customdata.rowlabels(lastidx)) || ...
                ~isequal(handles.customdata.rowlabels(randidx), handles.customdata.rowlabels(randidx))

            set(handles.text_jobstatustext, 'String', 'Error: all input data must be in the same order.',...
                'ForegroundColor', 'red');
            return;
        end  
    end



    % --------------- Done error checking!!! -------------------------- %


    if ismember('Import Custom', selected)
        % if the user is importing there own clustering solution then skip
        % right to the identification of consensus clusters.
        % in the future make an option so that the user can change the cutoff
        % to optain 'fuzzy' consensus clusters with varying degrees of
        % confidence.  For example, instead of clustering together 100% of the
        % time the user may want clusters that only for 80% of the time.  To do
        % this the cutoff must be changed.

        tmp = size(handles.customdata.data);
        num_runs = tmp(2);
        
        % This is the threshold calculations of how many times 2 genes are required to cluster together
        % to be included in a consensus cluster and not left out as a
        % singleton.  
        %percent = str2double(get(handles.consensus_edit_threshold, 'String'))/100;
        %chosen = get(handles.consensus_edit_threshold, 'Value');
        cutoff = ceil((str2double(get(handles.consensus_edit_threshold, 'String'))/100) * tmp(2))
        
        consensus_solution = identify_consensus_clusters( handles.customdata.rowlabels, ...
        handles.consensus_datastruct, handles.customdata.data, num_runs, cutoff, savename, savepath );

    else
        % else we need to generate the cluster run matrix, then call the
        % identify consensus function.
        algs = get(handles.consensus_listbox_clustmethod, 'String');
        alg_list = algs(get(handles.consensus_listbox_clustmethod, 'Value'));

        dismeasures = get(handles.consensus_listbox_dismeasure, 'String');
        dismeasure_list = dismeasures(get(handles.consensus_listbox_dismeasure, 'Value'));

        numreps = str2double(get(handles.consensus_edit_kmeanReps, 'String'));

        num_clusters = str2double(get(handles.consensus_edit_initnumclusts, 'String'));


        [clustered_mat, runheader] = create_clusterruns( handles.consensus_datastruct, ...
            handles.consensus_datastruct(1).rowlabels, alg_list, dismeasure_list, numreps,...
            num_clusters, savepath, savename, get(handles.consensus_checkbox_clusterruns, 'Value') );



        tmp = size(clustered_mat);
        num_runs = tmp(2);
        
        % This is the threshold calculations of how many times 2 genes are required to cluster together
        % to be included in a consensus cluster and not left out as a
        % singleton.  
        %percent = str2double(get(handles.consensus_edit_threshold, 'String'))/100;
        %chosen = get(handles.consensus_edit_threshold, 'Value');
        cutoff = ceil((str2double(get(handles.consensus_edit_threshold, 'String'))/100) * tmp(2))
        
        consensus_solution = identify_consensus_clusters( handles.consensus_datastruct(1).rowlabels, ...
        handles.consensus_datastruct, clustered_mat, num_runs, cutoff, savename, savepath );

    end


    % check to see if calcstats was checked
    if get(handles.consensus_checkbox_calcstats, 'Value')

         for d=1:num_datasets
            % create the dataset extension:
            [x, sourcefile, e] = GetFileInfo(handles.consensus_datastruct(d).filename);
            statfilename = strcat(savepath, savename, '-', sourcefile, '-ClusterStats.txt');
            numclust = length(unique(consensus_solution));

            set(handles.text_jobstatustext, 'String', {'Finished clustering.',...
            'Calculating cluster statistics...'}, 'ForegroundColor','blue');
            pause(.1);
            ClusterStats(consensus_solution, handles.consensus_datastruct(d).data, ...
                numclust, statfilename, [1,1,1,1,1,1,1,1]);
         end

    end


    % now check to see if heatmap generation is required.

    if create_heatmaps

        % get the dataset indicies chosen for heatmap generation
        usedata = get(handles.consensus_listbox_heatmapdata, 'Value');

        % get all the needed variables from the GUI
        % get colormap type
        if(get(handles.consensus_radio_yellowblue, 'Value'))
            colormap = 'blue-yellow';
        elseif(get(handles.consensus_radio_redwhiteblue, 'Value'))
            colormap = 'red-white-blue';
        else
            colormap = 'red-green';
        end

        row_labels = handles.consensus_datastruct(usedata(1)).rowlabels;
        num_clusters = length(unique(consensus_solution));
        minClustSize = str2double(get(handles.consensus_edit_minClustSize, 'String'));


        for d=1:length(usedata)
            % create the dataset extension:
            [x, sourcefile, e] = GetFileInfo(handles.consensus_datastruct(usedata(d)).filename);
            fileident = strcat(savename, '-', sourcefile);

            col_labels = handles.consensus_datastruct(usedata(d)).colheader;
            data = handles.consensus_datastruct(usedata(d)).data;

            % Now run the generate heatmap algorithm.
            generateHeatmaps( consensus_solution, row_labels, col_labels,...
                data, num_clusters, fileident, savepath, colormap, fileformats, minClustSize );

        end


    end


    set(handles.text_jobstatustext, 'String', 'Finished.', 'ForegroundColor','blue');


catch
        set(handles.text_jobstatustext, 'String', ...
            'There was an unforseen Matlab error. See errorlog.txt file for description.',...
            'ForegroundColor','red');
        %handles.customdata = [];
        guidata(hObject, handles); 
        
        lasterr
        fid = fopen('errorlog.txt', 'w');
        fprintf(fid, '%s', lasterr);
        fclose(fid);   
end







% -------------------- Help Menus --------------------------------- %


% --------------------------------------------------------------------
function help_menu_input_Callback(hObject, eventdata, handles)
% hObject    handle to help_menu_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open('Help_Input.pdf');

% --------------------------------------------------------------------
function help_menu_output_Callback(hObject, eventdata, handles)
% hObject    handle to help_menu_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open('Help_Output.pdf');

% --------------------------------------------------------------------
function help_menu_tutorial_Callback(hObject, eventdata, handles)
% hObject    handle to help_menu_tutorial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open('Help_Tutorial.pdf');

% --------------------------------------------------------------------
function Help_menu_Callback(hObject, eventdata, handles)
% hObject    handle to Help_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)





