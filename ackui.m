fh = figure; % Create a figure
ai = analoginput('winsound'); % Create an input object
addchannel(ai,1); % Add a channel
set(ai,'TriggerRepeat',inf); % Configure to run infinitely
set(ai,'TimerFcn','plot(peekdata(ai,500))'); % Each timer event will plot recent data
hButton = daqstopbutton(fh,ai); % Add the stopbutton 
