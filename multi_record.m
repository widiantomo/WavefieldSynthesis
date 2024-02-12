% multi_redcord.m

% Modified from Jesse Hansen's "record.m", add multiple channels
% --niuxc

% Last updated on 7-28-06

function multi_record
    
    clear all;
    
    global F_RECORD H_RECORD
    global SesInfo 

    SesInfo=[];
    width = 500;
    height = 400;
    % draw the main figure of the gui
    F_RECORD = figure('Position',[25 50 width height],...
        'NumberTitle','off',...
        'Color',[.8 .8 .8],...
        'MenuBar','none',...
        'Name','MultiRecord');

    H_RECORD.Status = uicontrol('Style','text',... % display the status
        'Units','normalized',...
        'Position',[50/width (height-30)/height 90/width 15/height],...
        'HorizontalAlignment', 'left',...
        'BackgroundColor',[.8 .8 .8],...
        'String','Sentence:');

    H_RECORD.Script = uicontrol('Style','edit',... % hold the scripts
        'Units','normalized',...
        'Enable', 'inactive',...
        'BusyAction', 'cancel',...
        'FontSize', 15,...
        'Position',[50/width (height-170)/height 400/width 130/height],...
        'HorizontalAlignment', 'left',...
        'Max', 2,...
        'String','To record, load a session...');

    H_RECORD.Prev = uicontrol('Style','pushbutton',... % previous button
        'Units','normalized',...
        'Enable', 'off',...
        'Position',[50/width (height-230)/height 80/width 30/height],...
        'String','Previous',...
        'Visible','on',...
        'CallBack',{@Prev_Callback});

    H_RECORD.Next = uicontrol('Style','pushbutton',... % next button
        'Units','normalized',...
        'Enable', 'off',...
        'Position',[155/width (height-230)/height 80/width 30/height],...
        'String','Next',...
        'Visible','on',...
        'CallBack',{@Next_Callback});

    H_RECORD.Recd = uicontrol('Style','pushbutton',... % record button
        'Units','normalized',...
        'Enable', 'off',...
        'Position',[260/width (height-230)/height 80/width 30/height],...
        'ForegroundColor',[1 0 0],...
        'String','Record',...
        'Visible','on',...
        'CallBack',{@Record_Callback});

    H_RECORD.Play = uicontrol('Style','pushbutton',... % play button
        'Units','normalized',...
        'Enable', 'off',...
        'Position',[365/width (height-230)/height 80/width 30/height],...
        'String','Play',...
        'Visible','on',...
        'CallBack',{@Play_Callback});

    pan1_wid=150; pan1_hgt=100;
    SesInfo.Text=[];
    SesInfo.Current=0;

    H_RECORD.TimePan = uipanel('Title','Time',...  % time panel
        'Units','normalized',...
        'Position',[50/width (height-360)/height pan1_wid/width pan1_hgt/height],...
        'BackgroundColor',[.8 .8 .8]);

    H_RECORD.TimeLen = uicontrol('Style','text',...  % diplays time length
        'parent', H_RECORD.TimePan,...
        'Units', 'normalized',...
        'Position', [15/pan1_wid (pan1_hgt-40)/pan1_hgt 90/pan1_wid 15/pan1_hgt],...
        'HorizontalAlignment', 'left',...
        'BackgroundColor', [.8 .8 .8],...
        'String', 'Length: 2.00 sec');

    H_RECORD.TimeRt = uicontrol('Style','text',...  % diplays time ratio
        'parent', H_RECORD.TimePan,...
        'Units','normalized',...
        'Position',[15/pan1_wid (pan1_hgt-80)/pan1_hgt 70/pan1_wid 15/pan1_hgt],...
        'HorizontalAlignment', 'left',...
        'BackgroundColor',[.8 .8 .8],...
        'String','Ratio: 1.00');

    H_RECORD.Ratio = uicontrol('Style','Slider',... % user selects time length
        'parent', H_RECORD.TimePan,...
        'Units','normalized',...
        'Position',[90/pan1_wid (pan1_hgt-83)/pan1_hgt 12/pan1_wid 24/pan1_hgt],...
        'Min',0.2,'Max',5.0,'Value',1,...
        'SliderStep',[1/100-0.000001 1/10],...
        'Callback',{@Ratio_Callback});

    pan2_wid=225; pan2_hgt=100;
    H_RECORD.SesPan = uipanel('Title','Session',...  % session panel
        'Units','normalized',...
        'Position',[225/width (height-360)/height pan2_wid/width pan2_hgt/height],...
        'BackgroundColor',[.8 .8 .8]);

    H_RECORD.Load = uicontrol('Style','pushbutton',... % load button
        'parent', H_RECORD.SesPan,...
        'Units','normalized',...
        'Enable', 'on',...
        'Position',[20/pan2_wid (pan2_hgt-60)/pan2_hgt 80/pan2_wid 30/pan2_hgt],...
        'String','Load',...
        'Visible','on',...
        'CallBack',{@Load_Callback});

    H_RECORD.Exit = uicontrol('Style','pushbutton',... % exit button
        'parent', H_RECORD.SesPan,...
        'Units','normalized',...
        'Enable', 'off',...
        'Position',[125/pan2_wid (pan2_hgt-60)/pan2_hgt 80/pan2_wid 30/pan2_hgt],...
        'String','Exit',...
        'Visible','on',...
        'CallBack',{@Exit_Callback});
    
    H_RECORD.Fig = figure('Name','Recorded waveform',...
        'NumberTitle','off',...
        'MenuBar','none',...
        'Visible','off');
        
    uicontrol(H_RECORD.Load);

end


% %---------------------------------------------------------------
% % callback function: Load_Callback
% load the session-file containing information for the recording session
function Load_Callback(source,eventdata)

    global F_RECORD H_RECORD
    global SesInfo 
    
    [filename, pathname] = uigetfile('*','Select the session file');

    if filename ~= 0
        % open the session-file
        SesInfo.FileName=[pathname, filename];
        fid=fopen(SesInfo.FileName,'rt');
        if fid==-1
            errordlg('Need a valid session file', 'Session file error');
            return;
        end
        
        % reset fields
        SesInfo.DataPath=[];
        SesInfo.SpeakerID=[];
        SesInfo.SessionID=[];
        SesInfo.DeviceID=[];
        SesInfo.Fs=[];
        SesInfo.ChannelFrom=[];
        SesInfo.ChannelTo=[];
        SesInfo.ScriptFile=[];
        SesInfo.SentenceNum=[];
        SesInfo.RecordedNum=[];
        SesInfo.SpeakerPath=[];
        SesInfo.SessionPath=[];

        % parse the information in the session-file
        while 1
            tline = fgetl(fid);
            if tline==-1, break, end
            
            if tline(1)=='#'  % skip comment lines
                continue;
            end
            
            [field,value]=strread(tline,'%s%s','delimiter',' =\b\r\n\t');
            field=field{1}; value=value{1}; % get strings
            switch field
                case 'DataPath'
                    % the path where the recordings are stored
                    SesInfo.DataPath=value;
                case 'SpeakerID'
                    SesInfo.SpeakerID=value;
                case 'SessionID'
                    SesInfo.SessionID=value;
                case 'DeviceID'
                    SesInfo.DeviceID=str2num(value);
                case 'SamplingFreq'
                    SesInfo.Fs=str2num(value);
                case 'ChannelFrom'
                    SesInfo.ChannelFrom=str2num(value);
                case 'ChannelTo'
                    SesInfo.ChannelTo=str2num(value);
                case 'ScriptFile'
                    % whole file name the the script file
                    SesInfo.ScriptFile=value;
                case 'SentenceNum'
                    % total number of senteces in the script file
                    SesInfo.SentenceNum=str2num(value);
                case 'RecordedNum'
                    % total number of recorded sentences
                    SesInfo.RecordedNum=str2num(value);
                otherwise
                    warndlg(tline, 'Unkown line warning');
            end
        end
        fclose(fid);
        
        % validate the information
        % test data pathes
        if isempty(SesInfo.DataPath) || ~isdir(SesInfo.DataPath)
            errordlg('Need a valid data path', 'Data path error');
            return;
        end
        
        if isempty(SesInfo.SpeakerID)
            errordlg('Need a valid speaker ID', 'Speaker ID error');
            return;
        else
            if ispc
                SesInfo.SpeakerPath=[SesInfo.DataPath, '\', SesInfo.SpeakerID];
            else
                SesInfo.SpeakerPath=[SesInfo.DataPath, '/', SesInfo.SpeakerID];
            end
            if ~isdir(SesInfo.SpeakerPath)
                [rc, mes, mesid]=mkdir(SesInfo.DataPath, SesInfo.SpeakerID);
                if ~rc
                    errordlg(mes, 'Make dir error');
                    return;
                end
            end
        end

        if isempty(SesInfo.SessionID)
            errordlg('Need a valid session ID', 'Ssesion ID error');
            return;
        else
            if ispc
                SesInfo.SessionPath=[SesInfo.SpeakerPath, '\', SesInfo.SessionID];
            else
                SesInfo.SessionPath=[SesInfo.SpeakerPath, '/', SesInfo.SessionID];
            end
            if ~isdir(SesInfo.SessionPath)
                [rc, mes, mesid]=mkdir(SesInfo.SpeakerPath, SesInfo.SessionID);
                if ~rc
                    errordlg(mes, 'Make dir error');
                    return;
                end
            end
        end
        
        % test input settings (skip now)
        if isempty(SesInfo.DeviceID) || isempty(SesInfo.Fs) || ...
                isempty(SesInfo.ChannelFrom) || isempty(SesInfo.ChannelTo)
            errordlg('Need valid settings for the input', 'Input setting error');
            return;
        end
        
        % test and load scripts
        if isempty(SesInfo.ScriptFile) || isempty(SesInfo.SentenceNum) ...
                || isempty(SesInfo.RecordedNum)
            errordlg('Need a valid script file', 'Script file error');
            return;
        else
            srcid=fopen(SesInfo.ScriptFile,'rt');
            if srcid==-1
                errordlg('Need a valid script file', 'Script file error');
                return;
            end
            for i=1:SesInfo.SentenceNum
                tline=fgetl(srcid);
                if tline==-1
                    errordlg('Please check the number of sentences', 'Script file error');
                    return;
                end
                SesInfo.Text{i}=tline;
            end
            fclose(srcid);
        end

        % Initialize the current status and scripts
        if SesInfo.RecordedNum<SesInfo.SentenceNum
            SesInfo.Current=SesInfo.RecordedNum+1;
        else
            SesInfo.Current=SesInfo.RecordedNum;
        end
        update_scripts;
        
        % update recoding time
        update_time;
        
        % updata figure
        update_fig;
        
        % change buttons for recording
        if SesInfo.Current>1
            set(H_RECORD.Prev,'enable','on');
        end
        set(H_RECORD.Load,'enable','off');
        set(H_RECORD.Exit,'enable','on');
        set(H_RECORD.Recd,'enable','on');
        % set(H_RECORD.Play,'enable','on'); % (supported latter)
        uicontrol(H_RECORD.Recd); 
    end
end

% %---------------------------------------------------------------
% % callback function: Exit_Callback
% Save the session-file and exit the recording session
function Exit_Callback(source,eventdata)

    global F_RECORD H_RECORD
    global SesInfo 

    % Save session information
    fid=fopen(SesInfo.FileName,'wt');
    if fid==-1
        errordlg('Cannot open the session file', 'Session file error');
        return;
    end

    fprintf(fid, '# Session file\n');
    fprintf(fid, 'DataPath=%s\n', SesInfo.DataPath);
    fprintf(fid, 'SpeakerID=%s\n', SesInfo.SpeakerID);
    fprintf(fid, 'SessionID=%s\n', SesInfo.SessionID);
    fprintf(fid, 'DeviceID=%d\n', SesInfo.DeviceID);
    fprintf(fid, 'SamplingFreq=%d\n', SesInfo.Fs);
    fprintf(fid, 'ChannelFrom=%d\n', SesInfo.ChannelFrom);
    fprintf(fid, 'ChannelTo=%d\n', SesInfo.ChannelTo);
    fprintf(fid, 'ScriptFile=%s\n', SesInfo.ScriptFile);
    fprintf(fid, 'SentenceNum=%d\n', SesInfo.SentenceNum);
    fprintf(fid, 'RecordedNum=%d\n', SesInfo.RecordedNum);
    
    fclose(fid);
    
    % close the figure to exit
    close(H_RECORD.Fig);
    close(F_RECORD);
end

% %---------------------------------------------------------------
% % callback function: Ratio_Callback
% change the ratio for recording time of the current sentence
function Ratio_Callback(source,eventdata)

    global F_RECORD H_RECORD
    global SesInfo
    
    update_time; 
    
end

% %---------------------------------------------------------------
% % callback function: Prev_Callback
% go to the previous sentence
function Prev_Callback(source,eventdata)

    global F_RECORD H_RECORD
    global SesInfo
    
    if SesInfo.Current>1
        SesInfo.Current=SesInfo.Current-1;
        update_scripts;
    end
    
    update_fig;
    
    if SesInfo.Current>1
        set(H_RECORD.Prev,'enable','on');
    else
        set(H_RECORD.Prev,'enable','off');
    end
    if SesInfo.Current<=SesInfo.RecordedNum && SesInfo.Current<SesInfo.SentenceNum
        set(H_RECORD.Next,'enable','on');
    else
        set(H_RECORD.Next,'enable','off');
    end
    update_time;
    set(H_RECORD.Recd,'enable','on');
    uicontrol(H_RECORD.Recd);
    
end

% %---------------------------------------------------------------
% % callback function: Next_Callback
% go to the next sentence
function Next_Callback(source,eventdata)

    global F_RECORD H_RECORD
    global SesInfo
    
    if SesInfo.Current<=SesInfo.RecordedNum && SesInfo.Current<SesInfo.SentenceNum
        SesInfo.Current=SesInfo.Current+1;
        update_scripts;
    end

    update_fig;
    
    if SesInfo.Current>1
        set(H_RECORD.Prev,'enable','on');
    else
        set(H_RECORD.Prev,'enable','off');
    end
    if SesInfo.Current<=SesInfo.RecordedNum && SesInfo.Current<SesInfo.SentenceNum
        set(H_RECORD.Next,'enable','on');
    else
        set(H_RECORD.Next,'enable','off');
    end
    update_time;
    set(H_RECORD.Recd,'enable','on');
    uicontrol(H_RECORD.Recd);
    
end

% %---------------------------------------------------------------
% % callback function: Record_Callback
% Record the current sentence, store the recordings and proceed to the next
% one
function Record_Callback(source,eventdata)

    global F_RECORD H_RECORD
    global SesInfo
    
    % disable all the controls and the the recoding in process
    uicontrol(H_RECORD.Recd);
    set(H_RECORD.Prev,'enable','off');
    set(H_RECORD.Next,'enable','off');
    set(H_RECORD.Recd,'enable','off');
    set(H_RECORD.Play,'enable','off');
    set(H_RECORD.Load,'enable','off');
    set(H_RECORD.Exit,'enable','off');
    set(H_RECORD.Ratio,'enable','off');
    set(H_RECORD.Status, 'ForegroundColor',[1 0 0]);
    set(H_RECORD.Script, 'ForegroundColor',[1 0 0]);
    
    % set up recodings
    %(simulate the recording)
    % uiwait(F_RECORD,SesInfo.Reclen);
    uiwait(F_RECORD,0.2);
%     ibuffer=zeros(100,SesInfo.ChannelTo-SesInfo.ChannelFrom+1);
    ibuffer=pa_wavrecord(SesInfo.ChannelFrom,SesInfo.ChannelTo,...
        SesInfo.Fs*SesInfo.Reclen,SesInfo.Fs, SesInfo.DeviceID);
    %a=ibuffer/max(max(abs(ibuffer)))*.99; % normalize
    a=ibuffer;
    
    % write files
    [N,M]=size(a);
    for i=1:M
        if ispc
            outfile=sprintf('%s\\%s%s_%03d-%d.wav',SesInfo.SessionPath,SesInfo.SpeakerID,...
                SesInfo.SessionID, SesInfo.Current, i+SesInfo.ChannelFrom-1);
        else
            outfile=sprintf('%s/%s%s_%03d-%d.wav',SesInfo.SessionPath,SesInfo.SpeakerID,...
                SesInfo.SessionID, SesInfo.Current, i+SesInfo.ChannelFrom-1);
        end            
        data=a(:,i);
        wavwrite(data,SesInfo.Fs,outfile);
    end
    

    % recover all the contols
    set(H_RECORD.Status, 'ForegroundColor',[0 0 0]);
    set(H_RECORD.Script, 'ForegroundColor',[0 0 0]);
    if SesInfo.Current==SesInfo.RecordedNum+1
        SesInfo.RecordedNum=SesInfo.Current;
%         if SesInfo.RecordedNum==SesInfo.SentenceNum  % All done
%             helpdlg('All sentence have been recorded, you may exit or go back to re-record any sentence.','Done');
%         end
    end

    update_fig; % display the sentence just recorded    
    
    if SesInfo.Current<=SesInfo.RecordedNum && SesInfo.Current<SesInfo.SentenceNum
        SesInfo.Current=SesInfo.Current+1;
        update_scripts;
        update_time;
    end
    
    if SesInfo.Current>1
        set(H_RECORD.Prev,'enable','on');
    end
    if SesInfo.Current<=SesInfo.RecordedNum && SesInfo.Current<SesInfo.SentenceNum
        set(H_RECORD.Next,'enable','on');
    end
    set(H_RECORD.Exit,'enable','on');
    set(H_RECORD.Ratio,'enable','on');
    set(H_RECORD.Recd,'enable','on');
    uicontrol(H_RECORD.Recd);
    

end

% %---------------------------------------------------------------
% % function: update_scripts
% Display the current sentence to be recorded
function update_scripts

    global F_RECORD H_RECORD
    global SesInfo
    
    % update the status
    status=sprintf('Sentence: %d/%d',SesInfo.Current,SesInfo.SentenceNum);
    set(H_RECORD.Status,'String',status);
    % update the display
    set(H_RECORD.Script,'String',SesInfo.Text{SesInfo.Current});

end

% %---------------------------------------------------------------
% % function: update_time
% Display the current sentence to be recorded
function update_time

    global F_RECORD H_RECORD
    global SesInfo

    % estimate and display the recording time (in seconds)
    SesInfo.Ratio=get(H_RECORD.Ratio,'Value');
    rt=sprintf('Ratio: %0.2f',SesInfo.Ratio);
    set(H_RECORD.TimeRt,'String',rt);
    if SesInfo.Current>0
        sentlen=length(SesInfo.Text{SesInfo.Current});
        SesInfo.Reclen=1+sentlen/10*SesInfo.Ratio;
        time=sprintf('Length: %0.2f sec',SesInfo.Reclen);
        set(H_RECORD.TimeLen,'String',time);
    end

end


% %---------------------------------------------------------------
% % function: update_fig
% Display the waveforms of the current sentence
function update_fig(num)

    global F_RECORD H_RECORD
    global SesInfo

    set(H_RECORD.Fig,'Visible','off');
    clf(H_RECORD.Fig);
    figure(H_RECORD.Fig);
    
    if nargin == 0
        num=SesInfo.Current;
    end

    title=sprintf('Sentence %03d',num);
    set(H_RECORD.Fig,'Name',title);

    nchannel=SesInfo.ChannelTo-SesInfo.ChannelFrom+1;
    for i=1:nchannel
        subplot(nchannel,1,i);
        if num<=SesInfo.RecordedNum
            if ispc
                wavfile=sprintf('%s\\%s%s_%03d-%d.wav',SesInfo.SessionPath,SesInfo.SpeakerID,...
                    SesInfo.SessionID, num, i+SesInfo.ChannelFrom-1);
            else
                wavfile=sprintf('%s/%s%s_%03d-%d.wav',SesInfo.SessionPath,SesInfo.SpeakerID,...
                    SesInfo.SessionID, num, i+SesInfo.ChannelFrom-1);
            end
            
            data=wavread(wavfile);
            tt=(0:length(data)-1)/SesInfo.Fs;
            plot(tt,data); hold on;
            axis([tt(1),tt(end),-1,1]);
            zoom xon;
        end
    end
    
    set(H_RECORD.Fig,'Visible','on');
    figure(F_RECORD);
end

