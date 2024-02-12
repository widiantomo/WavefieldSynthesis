function calibrate(Fs)
% Note: The two chnnels have to be adjacent!
% The calibration signal has to be turned on before running this code
% Position the GUI in the middle of the screen
mag = -30;
screenUnits=get(0,'Units');
set(0,'Units','pixels');
screenSize=get(0,'ScreenSize');
set(0,'Units',screenUnits);
figWidth=600;
figHeight=500;
figPos=[(screenSize(3)-figWidth)/2 (screenSize(4)-figHeight)/2  ...
      figWidth                    figHeight];
% Create the figure window.
hFig=figure(...                    
   'IntegerHandle'     ,'off'                    ,...
   'DoubleBuffer'      ,'on'                     ,...
   'MenuBar'           ,'none'                   ,...
   'HandleVisibility'  ,'on'                     ,...
   'Name'              ,'Analog Input FFT and 3rd Octave demo'  ,...
   'Tag'               ,'Analog Input FFT demo'  ,...
   'NumberTitle'       ,'off'                    ,...
   'Units'             ,'pixels'                 ,...
   'Position'          ,figPos                   ,...
   'UserData'          ,[]                       ,...
   'Colormap'          ,[]                       ,...
   'Pointer'           ,'arrow'                  ,...
   'Visible'           ,'off'                     ...
   );

Axes = axes(...
   'Position'          , [0.1300 0.1100 0.7750 0.80],...
   'Parent'            , hFig,...
   'XLim'              , [0 1]...
   );

% Plot the data.
colorselect = 'k' ;
hLine = bar(mag,colorselect);
set(hLine,'FaceColor','b');

%hLine(3) = plot(data.octave.P);
set(Axes, 'XLim', [0 1]);
	set(Axes,'XTick',[1]); 		% Label frequency axis on octaves. 
	set(Axes,'XTickLabel',1);

	% Label the plot.
	xlabel('Frequency band [Hz]'); ylabel('Power [dB re 20muV]');

%set(hAxes, 'HandleVisibility', 'off');
set(Axes, 'HandleVisibility', 'callback');

% Store the data matrix and display figure.
%set(hFig,'Visible','on','UserData',data,'HandleVisibility', 'off');
set(hFig,'Visible','on','HandleVisibility', 'callback');

    
%close all; % close all figures
i=1;
n = 44100;
while i<100 % looping
    ibuffer=wavrecord(n,Fs); % read in one second singals
    mag=10*log10(mean(ibuffer.^2)); % RMS in dB
    mag = mag +94;
    
    i=i+1;;
end
    