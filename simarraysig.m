function [sigout, tax] = simarraysig(sigarray, fs, sigpos, mpos, c, rev, mpath)
% This function inputs an array of sounds from different sources, assigns
% each one a position in space, and simulates corresponding signals received
% over a microphone array. All distances and times MUST BE in METERS and 
% SECONDS.  This includes the spatial positions of mics, signals, and the
% speed of sound. Each microphone corresponds to a column in the output
% matrix SIGOUT. The second output argument is the corresponding time axis
% TAX, where 0 corresponds to the first time sample in sigarray starting
% from its source postion.
% 
%  [sigout, tax] = simarraysig(sigarray, fs, sigpos, mpos, c, mpath)
%
% The input arguments are:
% sigarray => Matrix where each column represents a source signal
%             and each row represents a time sample of that signal
% fs =>       Signal sampling frequency
% sigpos =>   2 or 3 row matrix where each column represents the coordinates of a
%             signal source and each row is the dimension x,y, and z (if present)
% mpos =>     2 or 3 row matrix where each column represents the coordinates
%             of the mic and each row is the dimension x,y, and z (if present)
% c  =>       Speed of sound (FYI, c = 331.4+0.6*Temperature in Centigrade)
%
% mpath =>   (optional) 3 or 4 row vecotor containing the x,y,z (if present)
%             coordinates of multipath scatterers in the last 2 or 3 rows.  The first
%             row is the scattering coefficient (unitless and less than 1 for a passive
%             scatterer).  Only first order multipath is considered.
%
%  Written by Kevin D. Donohue (donohue@engr.uky.edu) July 2005
%

sfac = -3.2808399e-5;    % Linear attuenuation coefficient for sound in air alpha = SFAC*freq
                         %  in units of dB per (meter Hz)
% Obtain mic array information
[mr, mc] = size(mpos);      % Determine number of mics = mc
[pgr, pgc] = size(sigpos);  % Determine number of sound sources = pgc
[sgr, sgc] = size(sigarray); % Determine number of signals for each source = sgc
%  Check for consistency of input information
if sgc ~= pgc
    error('Each signal source must have a position - columns of SIGPOS = columns SIGARRAY')
end

%  If no multipath scatterers are provided, initialize variable to skip
%  multipath calculations
if nargin == 6
    mpath = [];
    mgc = 0;
else
    [mgr, mgc]= size(mpath);   %  Otherwise, get the number of the multipath scatterers
end

%  Find largest delay to initialize array
dmax = 0;
for k=1:pgc  %  Every signal position
    for r=1:mc  %  with every mic position
        if mgc > 0    %  and if present ..
            for m = 1:mgc   %  with every multipath scatterer
                d = norm((sigpos(:,k)-mpath(2:end,m)),2) + norm((mpath(2:end,m)-mpos(:,r)),2);
                if d > dmax
                    dmax = d;
                end
            end
        else   %  If no multipath scatterers specified, just do direct paths
            d = norm((sigpos(:,k)-mpos(:,r)),2);
            if d > dmax
                 dmax = d;
            end
        end
    end
end

%  Compute output array length based on the greatest delay
outlen = ceil(dmax*fs/c) + sgr;
tax = (0:outlen-1)/fs;  %  Create corresponding time axis
sigout = zeros(outlen,mc);  % Initalize output array
%  Compute a number of frequency domain coefficients to describe the 
%  attenuation spectrum
len = round(fs/40);
nfax = (0:len)/len;
fax = (fs/2)*nfax;    %  Create frequency axis for the attenuation

%  Loop for each source
for k = 1:pgc
    %   Load Impulse file for every mic position
    if rev == 1 % add reverberation because of the room effects
        filenm=['impuse',num2str(k)];
        try
        h=load(filenm);
        catch
        disp('ooopss... please built the impulse response file 1st');
        end
        h=h';
    end                               
    
    % First take care of direct path delay and attenuation from each sound source to mic    
    for r = 1:mc
        md = norm((sigpos(:,k) - mpos(:,r)),2);  %  Compute distance beteen mic and source
        dum = delayt(sigarray(:,k),fs,md/c,(outlen/fs));  %  Delay by travel time
       % mag=10*log10(mean(dum(1000:2000).^2)); % RMS in dB
       % mag=mag+94;
       % disp(mag);    

        
        alph = 10.^(.5*(md)*sfac*fax);  %  Compute spectral reponse of air path
        b = fir2(128,nfax,alph);        %  FIR filter to implement attenuation effects
        dum = filtfilt(b,1,dum);        %  Do the filfilt operation so no delay is realized by the filter
        dum = dum./md;
        % mag=10*log10(mean(dum(1000:2000).^2)); % RMS in dB
        % mag=mag+94;
        % disp(mag);                                            %  free field atenuation
        
        if rev == 1                            
        dum = fconv(dum,h(:,mc));       % Room effect convolution
        end
        
        sigout(:,r) = sigout(:,r) + dum(1:outlen); %  Add contribution to signal output
        %  If multipath present
        if mgc > 0    %  and if present ..
            for m = 1:mgc   %  with every multipath scatterer
                %  Compute distance from the source to scatterer to mic
                md = norm((sigpos(:,k)-mpath(2:end,m)),2) + norm((mpath(2:end,m)-mpos(:,r)),2);
                dum = delayt(sigarray(:,k),fs,md/c,(outlen/fs));  %  Delay by travel time  
                alph = mpath(1,m)*10.^(.5*(md)*sfac*fax);  %  Compute spectral reponse of Air path
                b = fir2(128,nfax,alph);    %  FIR filter to implement attenuation effects
                dum = filtfilt(b,1,dum);    % Do filtfilt operation so no delay is realized by the filter
                                            %   and scale down by distance of source path to mic
                sigout(:,r) = sigout(:,r) + dum(1:outlen);  %  Add contribution to signal output
            end
        end
    end
end
   